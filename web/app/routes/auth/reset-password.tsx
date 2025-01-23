import { json } from "@remix-run/node";
import { Form, useActionData } from "@remix-run/react";
import { Button } from "~/components/ui/button";
import { Input } from "~/components/ui/input";
import { Label } from "~/components/ui/label";

export const action = async ({ request }) => {
  const formData = await request.formData();
  const email = formData.get("email");

  if (!email) {
    return json(
      { error: "Email is required" },
      { status: 400 }
    );
  }

  // TODO: Implement actual password reset logic
  // 1. Generate reset token
  // 2. Send reset email
  // 3. Store reset token with expiration

  return json({ success: true, message: "If an account exists with this email, you will receive password reset instructions." });
};

export default function ResetPassword() {
  const actionData = useActionData();

  return (
    <div className="flex min-h-screen items-center justify-center">
      <div className="w-full max-w-md space-y-8 p-8">
        <div className="text-center">
          <h2 className="text-2xl font-bold">Reset your password</h2>
          <p className="mt-2 text-sm text-gray-600">
            Enter your email address and we'll send you instructions to reset your password.
          </p>
        </div>
        <Form method="post" className="mt-8 space-y-6">
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
          {actionData?.error && (
            <div className="text-sm text-red-600">{actionData.error}</div>
          )}
          {actionData?.success && (
            <div className="text-sm text-green-600">{actionData.message}</div>
          )}
          <Button type="submit" className="w-full">
            Send reset instructions
          </Button>
        </Form>
      </div>
    </div>
  );
}