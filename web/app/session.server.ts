
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
