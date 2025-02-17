import { prisma } from '@/lib/prisma';

export const createMetricsOther = async (data) => {
    return await prisma.metricsOther.create({
    data,
  });
};

export const updateMetricsOther = async ({ where, data }) => {
    return await prisma.metricsOther.update({
    where,
    data,
  });
};

export const getMetricsOther = async (key: { metricsOtherId: number }) => {
    return await prisma.metricsOther.findUnique({
    where: key,
  });
};

export const deleteMetricsOther = async (key: { metricsOtherId: number }) => {
  return await prisma.metricsOther.delete({
    where: key,
  });
};

export const listProblemTypeDescriptionsADP = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.metricsOther.findMany({
    skip,
    take: limit,
  });
};