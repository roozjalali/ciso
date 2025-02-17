import { prisma } from '@/lib/prisma';

export const createaDPTitle = async (data) => {
    return await prisma.aDPTitle.create({
    data,
  });
};

export const updateaDPTitle = async ({ where, data }) => {
    return await prisma.aDPTitle.update({
    where,
    data,
  });
};

export const getaDPTitle = async (key: { adpTitleId: number }) => {
    return await prisma.aDPTitle.findUnique({
    where: key,
  });
};

export const deleteaDPTitle = async (key: { adpTitleId: number }) => {
  return await prisma.aDPTitle.delete({
    where: key,
  });
};

export const listaDPTitle = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.aDPTitle.findMany({
    skip,
    take: limit,
  });
};