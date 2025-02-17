import { prisma } from '@/lib/prisma';

export const createProviderMetadataCNA = async (data) => {
    return await prisma.providerMetadataCNA.create({
    data,
  });
};

export const updateProviderMetadataCNA = async ({ where, data }) => {
    return await prisma.providerMetadataCNA.update({
    where,
    data,
  });
};

export const getProviderMetadataCNA = async (key: { providerMetadataCNAId: number }) => {
    return await prisma.providerMetadataCNA.findUnique({
    where: key,
  });
};

export const deleteProviderMetadataCNA = async (key: { providerMetadataCNAId: number }) => {
  return await prisma.providerMetadataCNA.delete({
    where: key,
  });
};

export const listDescriptions = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.providerMetadataCNA.findMany({
    skip,
    take: limit,
  });
};