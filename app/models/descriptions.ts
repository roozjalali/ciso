import { prisma } from '@/lib/prisma';

export const createDescriptions = async (data) => {
    return await prisma.descriptions.create({
    data,
  });
};

export const updateDescriptions = async ({ where, data }) => {
  return await prisma.descriptions.update({
    where,
    data,
  });
};

export const getDescriptions = async (key: { descriptionId: number }) => {
    return await prisma.descriptions.findUnique({
    where: key,
  });
};

export const deleteDescriptions = async (key: { descriptionId: number }) => {
  return await prisma.descriptions.delete({
    where: key,
  });
};

export const listDescriptions = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.descriptions.findMany({
    skip,
    take: limit,
  });
};