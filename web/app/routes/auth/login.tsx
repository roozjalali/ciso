import { json } from "@remix-run/node";
import { Form, useActionData } from "@remix-run/react";
import { Button } from "~/components/ui/button";
import { Input } from "~/components/ui/input";
import { Label } from "~/components/ui/label";

export const action = async ({ request }) => {
  const formData = await request.formData();
  const email = formData.get("email");
  const password = formData.get("password");

  // TODO: Implement actual authentication logic
  if (!email || !password) {
    return json({ error: "Email and password are required" }, { status: 400 });
  }

  return json({ success: true });
};

export default function Login() {
  const actionData = useActionData();

  return (
    <div className="flex min-h-screen items-center justify-center">
      <div className="w-full max-w-md space-y-8 p-8">
        <div className="text-center">
          <h2 className="text-2xl font-bold">Sign in to your account</h2>
        </div>
        <Form method="post" className="mt-8 space-y-6">
          <div className="space-y-4">
            <div>
              <Label htmlFor="email">Email address</Label>
              <Input
                id="email"
                name="email"
                type="email"
                autoComplete="email"
                required
                className="mt-1"
              />
            </div>
            <div>
              <Label htmlFor="password">Password</Label>
              <Input
                id="password"
                name="password"
                type="password"
                autoComplete="current-password"
                required
                className="mt-1"
              />
            </div>
          </div>
          {actionData?.error && (
            <div className="text-sm text-red-600">{actionData.error}</div>
          )}
          <Button type="submit" className="w-full">
            Sign in
          </Button>
        </Form>
      </div>
    </div>
  );
}