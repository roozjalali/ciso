import { prisma } from '@/lib/prisma';

export const createAffectedProducts = async (data) => {
  return await prisma.affectedProducts.create({
    data,
  });
};

export const updateAffectedProducts = async ({ where, data }) => {
  return await prisma.affectedProducts.update({
    where,
    data,
  });
};

export const getAffectedProducts = async (key: { affectedId: number }) => {
  return await prisma.affectedProducts.findUnique({
    where: key,
  });
};

export const deleteAffectedProducts = async (key: { affectedId: number }) => {
  return await prisma.affectedProducts.delete({
    where: key,
  });
};

export const listCVEMetadata = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.affectedProducts.findMany({
    skip,
    take: limit,
  });
};