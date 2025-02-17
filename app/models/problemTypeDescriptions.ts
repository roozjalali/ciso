import { prisma } from '@/lib/prisma';

export const createProblemTypeDescriptions = async (data) => {
    return await prisma.problemTypeDescriptions.create({
    data,
  });
};

export const updateProblemTypeDescriptions = async ({ where, data }) => {
    return await prisma.problemTypeDescriptions.update({
    where,
    data,
  });
};

export const getProblemTypeDescriptions = async (key: { problemTypeDescriptionId: number }) => {
    return await prisma.problemTypeDescriptions.findUnique({
    where: key,
  });
};

export const deleteProblemTypeDescriptions = async (key: { problemTypeDescriptionId: number }) => {
  return await prisma.problemTypeDescriptions.delete({
    where: key,
  });
};

export const listDescriptions = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.problemTypeDescriptions.findMany({
    skip,
    take: limit,
  });
};