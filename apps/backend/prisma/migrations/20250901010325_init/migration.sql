-- CreateEnum
CREATE TYPE "public"."Role" AS ENUM ('ADMIN', 'CONSULTOR', 'EMPRESA');

-- CreateEnum
CREATE TYPE "public"."ForceCategory" AS ENUM ('TENDENCIAS', 'MERCADO', 'INDUSTRIA', 'MACRO');

-- CreateEnum
CREATE TYPE "public"."Impact" AS ENUM ('ALTO', 'MEDIO', 'BAJO');

-- CreateEnum
CREATE TYPE "public"."Tag" AS ENUM ('OPORTUNIDAD', 'NECESIDAD', 'PROBLEMA');

-- CreateTable
CREATE TABLE "public"."User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "password" TEXT NOT NULL,
    "role" "public"."Role" NOT NULL DEFAULT 'EMPRESA',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ExternalForce" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "category" "public"."ForceCategory" NOT NULL,
    "ownerId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ExternalForce_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Selection" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "forceId" TEXT NOT NULL,
    "impact" "public"."Impact",
    "category" "public"."Tag",
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Selection_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "public"."User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Selection_userId_forceId_key" ON "public"."Selection"("userId", "forceId");

-- AddForeignKey
ALTER TABLE "public"."ExternalForce" ADD CONSTRAINT "ExternalForce_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "public"."User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
