import { useActionData } from "@remix-run/react";
import { LoginForm } from "../../components/LoginForm";
import { loginSchema } from "../../lib/validations/auth";
import { prisma } from "../../db.server";
import { compare } from "bcryptjs";
import { createCookieSessionStorage, redirect } from "@remix-run/node";

const sessionSecret = process.env.SESSION_SECRET;

if (!sessionSecret) {
  throw new Error("SESSION_SECRET must be set");
}

const storage = createCookieSessionStorage({
  cookie: {
    name: "ciso_session",
    secure: process.env.NODE_ENV === "production",
    secrets: [sessionSecret],
    sameSite: "lax",
    path: "/",
    maxAge: 60 * 60 * 24 * 30, // 30 days
    httpOnly: true,
  },
});

export async function createUserSession({
  userId,
  organizationId,
  remember,
  redirectTo,
}: {
  userId: string;
  organizationId?: string;
  remember: boolean;
  redirectTo: string;
}) {
  const session = await storage.getSession();
  session.set("userId", userId);
  if (organizationId) {
    session.set("organizationId", organizationId);
  }

  return redirect(redirectTo, {
    headers: {
      "Set-Cookie": await storage.commitSession(session, {
        maxAge: remember ? 60 * 60 * 24 * 30 : undefined,
      }),
    },
  });
}

type ActionData = {
  error?: string;
  success?: boolean;
} & { [key: string]: unknown };

export type { ActionData };

export const action = async ({ request }: { request: Request }) => {
  const formData = await request.formData();
  const loginType = formData.get("loginType");

  // SSO authentication will be implemented later
  if (loginType === "sso") {
    return new Response(JSON.stringify({ error: "SSO login coming soon" }), {
      status: 400,
      headers: {
        "Content-Type": "application/json"
      }
    });
  }

  const email = formData.get("email");
  const password = formData.get("password");

  const result = loginSchema.safeParse({ email, password });

  if (!result.success) {
    return new Response(JSON.stringify({ error: result.error.issues[0].message }), {
      status: 400,
      headers: {
        "Content-Type": "application/json"
      }
    });
  }

  const user = await prisma.user.findUnique({
    where: {
      email: email as string,
    },
    include: {
      organizations: true
    }
  });

if (!user || !user.password) {
  return new Response(JSON.stringify({ error: "Invalid email or password" }), {
    status: 401,
    headers: {
      "Content-Type": "application/json"
    }
  });
}

const isValidPassword = await compare(password as string, user.password);

await prisma.userLoginHistory.create({
  data: {
    userId: user.id,
    email: email as string,
    success: isValidPassword && user.status === "ACTIVE",
    failureReason: !isValidPassword 
      ? "Invalid password"
      : user.status !== "ACTIVE"
      ? "Account inactive"
      : undefined,
    ipAddress: request.headers.get("x-forwarded-for")?.split(',')[0].trim() || request.headers.get("x-real-ip") || request.socket?.remoteAddress,
    userAgent: request.headers.get("user-agent")
  }
});

  if (!isValidPassword) {
    return new Response(JSON.stringify({ error: "Invalid email or password" }), {
      status: 401,
      headers: {
        "Content-Type": "application/json"
      }
    });
  }

  if (user.status !== "ACTIVE") {
    return new Response(JSON.stringify({ error: "Account is not active" }), {
      status: 401,
      headers: {
        "Content-Type": "application/json"
      }
    });
  }

  // Create user session
  return createUserSession({
    userId: user.id,
    organizationId: user.organizations[0]?.id, // Default to first organization
    remember: true,
    redirectTo: "/dashboard"
  });



export default function Login() {
  const actionData = useActionData();

  return (
    <div className="flex min-h-svh w-full items-center justify-center p-6 md:p-10">
      <div className="w-full max-w-sm">
        <LoginForm />
        {(actionData as { error?: string })?.error && (
          <div className="mt-4 text-sm text-red-600">{(actionData as { error: string })?.error}</div>
        )}
      </div>
    </div>
  );
}
