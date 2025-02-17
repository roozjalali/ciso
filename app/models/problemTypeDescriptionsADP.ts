import { prisma } from '@/lib/prisma';

export const createProblemTypeDescriptionsADP = async (data) => {
    return await prisma.problemTypeDescriptionsADP.create({
    data,
  });
};

export const updateProblemTypeDescriptionsADP = async ({ where, data }) => {
    return await prisma.problemTypeDescriptionsADP.update({
    where,
    data,
  });
};

export const getProblemTypeDescriptionsADP = async (key: { problemTypeDescriptionIdADP: number }) => {
    return await prisma.problemTypeDescriptionsADP.findUnique({
    where: key,
  });
};

export const deleteProblemTypeDescriptionsADP = async (key: { problemTypeDescriptionIdADP: number }) => {
  return await prisma.problemTypeDescriptionsADP.delete({
    where: key,
  });
};

export const listProblemTypeDescriptionsADP = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.problemTypeDescriptionsADP.findMany({
    skip,
    take: limit,
  });
};