import { useActionData, useSearchParams } from "@remix-run/react";
import { InputOTP, InputOTPGroup, InputOTPSlot } from "~/components/ui/input-otp";
import { Button } from "~/components/ui/button";
import { prisma } from "../../../prisma";

export const action = async ({ request }: { request: Request }) => {
  const formData = await request.formData();
  const otp = formData.get("otp");
  const email = formData.get("email");

  if (!otp || !email) {
    return new Response(JSON.stringify({ error: "Invalid verification attempt" }), {
      status: 400,
      headers: { "Content-Type": "application/json" }
    });
  }

  const verification = await prisma.oTPVerification.findFirst({
    where: {
      user: {
        email: email as string
      },
      code: otp as string,
      isUsed: false,
      expiresAt: {
        gt: new Date()
      }
    },
    include: {
      user: true
    }
  });

  if (!verification) {
    return new Response(JSON.stringify({ error: "Invalid or expired OTP" }), {
      status: 400,
      headers: { "Content-Type": "application/json" }
    });
  }

  // Mark OTP as used
  await prisma.oTPVerification.update({
    where: { id: verification.id },
    data: { isUsed: true }
  });

  // Create user session
  return createUserSession({
    userId: verification.user.id,
    organizationId: verification.user.organizations[0]?.id,
    remember: true,
    redirectTo: "/dashboard"
  });
};

export default function VerifyOTP() {
  const [searchParams] = useSearchParams();
  const email = searchParams.get("email");
  const actionData = useActionData();

  return (
    <div className="flex min-h-svh w-full items-center justify-center p-6 md:p-10">
      <div className="w-full max-w-sm space-y-6">
        <div className="space-y-2 text-center">
          <h1 className="text-2xl font-semibold tracking-tight">
            Enter verification code
          </h1>
          <p className="text-sm text-muted-foreground">
            We've sent a code to {email}
          </p>
        </div>

        <form method="post" className="space-y-4">
          <input type="hidden" name="email" value={email || ''} />
          <div className="space-y-4">
            <InputOTP
              name="otp"
              maxLength={6}
              render={({ slots }) => (
                <InputOTPGroup>
                  {slots.map((slot, index) => (
                    <InputOTPSlot key={index} {...slot} />
                  ))}
                </InputOTPGroup>
              )}
            />
          </div>

          <Button type="submit" className="w-full">
            Verify
          </Button>
        </form>

        {actionData?.error && (
          <div className="text-sm text-red-600">{actionData.error}</div>
        )}
      </div>
    </div>
  );
}