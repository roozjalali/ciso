import { prisma } from '@/lib/prisma';

export const createMetricsOtherOptions = async (data) => {
    return await prisma.metricsOtherOptions.create({
    data,
  });
};

export const updateMetricsOtherOptions = async ({ where, data }) => {
    return await prisma.metricsOtherOptions.update({
    where,
    data,
  });
};

export const getMetricsOtherOptions = async (key: { metricsOtherOptionsId: number }) => {
    return await prisma.metricsOtherOptions.findUnique({
    where: key,
  });
};

export const deleteMetricsOtherOptions = async (key: { metricsOtherOptionsId: number }) => {
  return await prisma.metricsOtherOptions.delete({
    where: key,
  });
};

export const listMetricsOtherOptions = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.metricsOtherOptions.findMany({
    skip,
    take: limit,
  });
};