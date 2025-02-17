import { prisma } from '@/lib/prisma';

export const createProblemTypesADP = async (data) => {
    return await prisma.problemTypesADP.create({
    data,
  });
};

export const updateProblemTypesADP = async ({ where, data }) => {
    return await prisma.problemTypesADP.update({
    where,
    data,
  });
};

export const getProblemTypesADP = async (key: { problemTypeIdADP: number }) => {
    return await prisma.problemTypesADP.findUnique({
    where: key,
  });
};

export const deleteProblemTypesADP = async (key: { problemTypeIdADP: number }) => {
  return await prisma.problemTypesADP.delete({
    where: key,
  });
};

export const listProblemTypesADP = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.problemTypesADP.findMany({
    skip,
    take: limit,
  });
};