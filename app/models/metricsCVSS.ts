import { prisma } from '@/lib/prisma';

export const createMetricsCVSS = async (data) => {
    return await prisma.metricsCVSS.create({
    data,
  });
};

export const updateMetricsCVSS = async ({ where, data }) => {
    return await prisma.metricsCVSS.update({
    where,
    data,
  });
};

export const getMetricsCVSS = async (key: { metricsCVSSId: number }) => {
    return await prisma.metricsCVSS.findUnique({
    where: key,
  });
};

export const deleteMetricsCVSS = async (key: { metricsCVSSId: number }) => {
  return await prisma.metricsCVSS.delete({
    where: key,
  });
};

export const listProblemTypeDescriptionsADP = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.metricsCVSS.findMany({
    skip,
    take: limit,
  });
};