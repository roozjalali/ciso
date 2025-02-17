import { prisma } from '@/lib/prisma';

export const createProductVersions = async (data) => {
  return await prisma.productVersions.create({
    data,
  });
};

export const updateProductVersions = async ({ where, data }) => {
  return await prisma.productVersions.update({
    where,
    data,
  });
};

export const getProductVersions = async (key: { versionId: number }) => {
  return await prisma.productVersions.findUnique({
    where: key,
  });
};

export const deleteProductVersions = async (key: { versionId: number }) => {
  return await prisma.productVersions.delete({
    where: key,
  });
};

export const listCVEMetadata = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.productVersions.findMany({
    skip,
    take: limit,
  });
};