import { prisma } from '@/lib/prisma';

export const createReferences = async (data) => {
    return await prisma.references.create({
    data,
  });
};

export const updateReferences = async ({ where, data }) => {
    return await prisma.references.update({
    where,
    data,
  });
};

export const getReferences = async (key: { referenceId: number }) => {
    return await prisma.references.findUnique({
    where: key,
  });
};

export const deleteReferences = async (key: { referenceId: number }) => {
  return await prisma.references.delete({
    where: key,
  });
};

export const listDescriptions = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.references.findMany({
    skip,
    take: limit,
  });
};