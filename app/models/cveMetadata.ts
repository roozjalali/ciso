import { prisma } from '@/lib/prisma';

export const createCVEMetadata = async (data) => {
  return await prisma.cVEMetadata.create({
    data,
  });
};

export const updateCVEMetadata = async ({ where, data }) => {
  return await prisma.cVEMetadata.update({
    where,
    data,
  });
};

export const getCVEMetadata = async (key: { cveId: string }) => {
  return await prisma.cVEMetadata.findUnique({
    where: key,
  });
};

export const deleteCVEMetadata = async (key: { cveId: string }) => {
  return await prisma.cVEMetadata.delete({
    where: key,
  });
};

export const listCVEMetadata = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.cVEMetadata.findMany({
    skip,
    take: limit,
  });
};