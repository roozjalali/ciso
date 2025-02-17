import { prisma } from '@/lib/prisma';

export const createProblemTypes = async (data) => {
  return await prisma.problemTypes.create({
    data,
  });
};

export const updateProblemTypes = async ({ where, data }) => {
  return await prisma.problemTypes.update({
    where,
    data,
  });
};

export const getProblemTypes = async (key: { problemTypeId: number }) => {
  return await prisma.problemTypes.findUnique({
    where: key,
  });
};

export const deleteProblemTypes = async (key: { problemTypeId: number }) => {
  return await prisma.problemTypes.delete({
    where: key,
  });
};

export const listCVEMetadata = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.problemTypes.findMany({
    skip,
    take: limit,
  });
};