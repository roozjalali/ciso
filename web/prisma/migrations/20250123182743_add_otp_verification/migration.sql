-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('ACTIVE', 'BLOCKED', 'PENDING');

-- CreateEnum
CREATE TYPE "InviteStatus" AS ENUM ('PENDING', 'ACCEPTED', 'EXPIRED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "EmailType" AS ENUM ('PASSWORD_RESET', 'EMAIL_VERIFICATION', 'INVITATION');

-- CreateEnum
CREATE TYPE "ActivityCategory" AS ENUM ('AUTH', 'USER_MANAGEMENT', 'ORGANIZATION', 'MODULE_ACCESS', 'PERMISSION', 'SSO', 'SYSTEM');

-- CreateTable
CREATE TABLE "ThreatCVE" (
    "id" TEXT NOT NULL,
    "cveId" TEXT NOT NULL,
    "dataType" TEXT NOT NULL,
    "dataVersion" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "moduleId" TEXT NOT NULL,

    CONSTRAINT "ThreatCVE_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ThreatCVEMetadata" (
    "id" TEXT NOT NULL,
    "assignerOrgId" TEXT NOT NULL,
    "assignerShortName" TEXT NOT NULL,
    "datePublished" TIMESTAMP(3) NOT NULL,
    "dateReserved" TIMESTAMP(3) NOT NULL,
    "dateUpdated" TIMESTAMP(3) NOT NULL,
    "state" TEXT NOT NULL,
    "cveId" TEXT NOT NULL,

    CONSTRAINT "ThreatCVEMetadata_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ThreatContainer" (
    "id" TEXT NOT NULL,
    "cveId" TEXT NOT NULL,

    CONSTRAINT "ThreatContainer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ThreatCNA" (
    "id" TEXT NOT NULL,
    "containerId" TEXT NOT NULL,
    "legacyV4Record" JSONB,

    CONSTRAINT "ThreatCNA_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ThreatAffected" (
    "id" TEXT NOT NULL,
    "product" TEXT NOT NULL,
    "vendor" TEXT NOT NULL,
    "cnaId" TEXT NOT NULL,

    CONSTRAINT "ThreatAffected_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ThreatVersion" (
    "id" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "affectedId" TEXT NOT NULL,

    CONSTRAINT "ThreatVersion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ThreatDescription" (
    "id" TEXT NOT NULL,
    "lang" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "cnaId" TEXT NOT NULL,

    CONSTRAINT "ThreatDescription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ThreatProblemType" (
    "id" TEXT NOT NULL,
    "cnaId" TEXT NOT NULL,

    CONSTRAINT "ThreatProblemType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ThreatProblemTypeDescription" (
    "id" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "lang" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "problemTypeId" TEXT NOT NULL,

    CONSTRAINT "ThreatProblemTypeDescription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ThreatProviderMetadata" (
    "id" TEXT NOT NULL,
    "dateUpdated" TIMESTAMP(3) NOT NULL,
    "orgId" TEXT NOT NULL,
    "shortName" TEXT NOT NULL,
    "cnaId" TEXT NOT NULL,

    CONSTRAINT "ThreatProviderMetadata_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ThreatReference" (
    "id" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "cnaId" TEXT NOT NULL,

    CONSTRAINT "ThreatReference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Organization" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Organization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "password" TEXT,
    "isAdmin" BOOLEAN NOT NULL DEFAULT false,
    "isEmailVerified" BOOLEAN NOT NULL DEFAULT false,
    "status" "UserStatus" NOT NULL DEFAULT 'PENDING',
    "ssoIdentifier" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmailVerification" (
    "id" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "EmailVerification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserGroup" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Module" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Module_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Permission" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "moduleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ModuleAccess" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "moduleId" TEXT NOT NULL,
    "isEnabled" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ModuleAccess_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Invitation" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "userId" TEXT,
    "token" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "status" "InviteStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Invitation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SSOConfig" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "clientSecret" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "settings" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SSOConfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Activity" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "orgId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "category" "ActivityCategory" NOT NULL,
    "details" JSONB,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Activity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PasswordReset" (
    "id" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "isUsed" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PasswordReset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmailThrottle" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "ipAddress" TEXT,
    "type" "EmailType" NOT NULL,
    "attemptCount" INTEGER NOT NULL DEFAULT 1,
    "lastAttemptAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "EmailThrottle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OTPVerification" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "isUsed" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OTPVerification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_OrganizationToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_OrganizationToUser_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_UserToUserGroup" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_UserToUserGroup_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_PermissionToUserGroup" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_PermissionToUserGroup_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "ThreatCVE_cveId_key" ON "ThreatCVE"("cveId");

-- CreateIndex
CREATE UNIQUE INDEX "ThreatCVEMetadata_cveId_key" ON "ThreatCVEMetadata"("cveId");

-- CreateIndex
CREATE UNIQUE INDEX "ThreatContainer_cveId_key" ON "ThreatContainer"("cveId");

-- CreateIndex
CREATE UNIQUE INDEX "ThreatCNA_containerId_key" ON "ThreatCNA"("containerId");

-- CreateIndex
CREATE INDEX "ThreatAffected_vendor_idx" ON "ThreatAffected"("vendor");

-- CreateIndex
CREATE INDEX "ThreatAffected_product_idx" ON "ThreatAffected"("product");

-- CreateIndex
CREATE UNIQUE INDEX "ThreatProviderMetadata_cnaId_key" ON "ThreatProviderMetadata"("cnaId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_ssoIdentifier_key" ON "User"("ssoIdentifier");

-- CreateIndex
CREATE UNIQUE INDEX "EmailVerification_token_key" ON "EmailVerification"("token");

-- CreateIndex
CREATE UNIQUE INDEX "EmailVerification_userId_key" ON "EmailVerification"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "UserGroup_name_orgId_key" ON "UserGroup"("name", "orgId");

-- CreateIndex
CREATE UNIQUE INDEX "Module_name_key" ON "Module"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Permission_name_moduleId_key" ON "Permission"("name", "moduleId");

-- CreateIndex
CREATE UNIQUE INDEX "ModuleAccess_orgId_moduleId_key" ON "ModuleAccess"("orgId", "moduleId");

-- CreateIndex
CREATE UNIQUE INDEX "Invitation_token_key" ON "Invitation"("token");

-- CreateIndex
CREATE UNIQUE INDEX "SSOConfig_orgId_key" ON "SSOConfig"("orgId");

-- CreateIndex
CREATE UNIQUE INDEX "PasswordReset_token_key" ON "PasswordReset"("token");

-- CreateIndex
CREATE INDEX "EmailThrottle_ipAddress_idx" ON "EmailThrottle"("ipAddress");

-- CreateIndex
CREATE UNIQUE INDEX "EmailThrottle_email_type_key" ON "EmailThrottle"("email", "type");

-- CreateIndex
CREATE INDEX "OTPVerification_userId_idx" ON "OTPVerification"("userId");

-- CreateIndex
CREATE INDEX "_OrganizationToUser_B_index" ON "_OrganizationToUser"("B");

-- CreateIndex
CREATE INDEX "_UserToUserGroup_B_index" ON "_UserToUserGroup"("B");

-- CreateIndex
CREATE INDEX "_PermissionToUserGroup_B_index" ON "_PermissionToUserGroup"("B");

-- AddForeignKey
ALTER TABLE "ThreatCVE" ADD CONSTRAINT "ThreatCVE_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES "Module"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ThreatCVEMetadata" ADD CONSTRAINT "ThreatCVEMetadata_cveId_fkey" FOREIGN KEY ("cveId") REFERENCES "ThreatCVE"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ThreatContainer" ADD CONSTRAINT "ThreatContainer_cveId_fkey" FOREIGN KEY ("cveId") REFERENCES "ThreatCVE"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ThreatCNA" ADD CONSTRAINT "ThreatCNA_containerId_fkey" FOREIGN KEY ("containerId") REFERENCES "ThreatContainer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ThreatAffected" ADD CONSTRAINT "ThreatAffected_cnaId_fkey" FOREIGN KEY ("cnaId") REFERENCES "ThreatCNA"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ThreatVersion" ADD CONSTRAINT "ThreatVersion_affectedId_fkey" FOREIGN KEY ("affectedId") REFERENCES "ThreatAffected"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ThreatDescription" ADD CONSTRAINT "ThreatDescription_cnaId_fkey" FOREIGN KEY ("cnaId") REFERENCES "ThreatCNA"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ThreatProblemType" ADD CONSTRAINT "ThreatProblemType_cnaId_fkey" FOREIGN KEY ("cnaId") REFERENCES "ThreatCNA"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ThreatProblemTypeDescription" ADD CONSTRAINT "ThreatProblemTypeDescription_problemTypeId_fkey" FOREIGN KEY ("problemTypeId") REFERENCES "ThreatProblemType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ThreatProviderMetadata" ADD CONSTRAINT "ThreatProviderMetadata_cnaId_fkey" FOREIGN KEY ("cnaId") REFERENCES "ThreatCNA"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ThreatReference" ADD CONSTRAINT "ThreatReference_cnaId_fkey" FOREIGN KEY ("cnaId") REFERENCES "ThreatCNA"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmailVerification" ADD CONSTRAINT "EmailVerification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserGroup" ADD CONSTRAINT "UserGroup_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Permission" ADD CONSTRAINT "Permission_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES "Module"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModuleAccess" ADD CONSTRAINT "ModuleAccess_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModuleAccess" ADD CONSTRAINT "ModuleAccess_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES "Module"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invitation" ADD CONSTRAINT "Invitation_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SSOConfig" ADD CONSTRAINT "SSOConfig_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Activity" ADD CONSTRAINT "Activity_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Activity" ADD CONSTRAINT "Activity_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PasswordReset" ADD CONSTRAINT "PasswordReset_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OTPVerification" ADD CONSTRAINT "OTPVerification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OrganizationToUser" ADD CONSTRAINT "_OrganizationToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OrganizationToUser" ADD CONSTRAINT "_OrganizationToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserToUserGroup" ADD CONSTRAINT "_UserToUserGroup_A_fkey" FOREIGN KEY ("A") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserToUserGroup" ADD CONSTRAINT "_UserToUserGroup_B_fkey" FOREIGN KEY ("B") REFERENCES "UserGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionToUserGroup" ADD CONSTRAINT "_PermissionToUserGroup_A_fkey" FOREIGN KEY ("A") REFERENCES "Permission"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionToUserGroup" ADD CONSTRAINT "_PermissionToUserGroup_B_fkey" FOREIGN KEY ("B") REFERENCES "UserGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;
