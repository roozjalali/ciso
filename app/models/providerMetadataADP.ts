import { prisma } from '@/lib/prisma';

export const createProviderMetadataADP = async (data) => {
    return await prisma.providerMetadataADP.create({
    data,
  });
};

export const updateProviderMetadataADP = async ({ where, data }) => {
    return await prisma.providerMetadataADP.update({
    where,
    data,
  });
};

export const getProviderMetadataADP = async (key: { providerMetadataADPId: number }) => {
    return await prisma.providerMetadataADP.findUnique({
    where: key,
  });
};

export const deleteProviderMetadataADP = async (key: { providerMetadataADPId: number }) => {
  return await prisma.providerMetadataADP.delete({
    where: key,
  });
};

export const listProviderMetadataADP = async (page: number = 1, limit: number = 10) => {
  const skip = (page - 1) * limit;
  return await prisma.providerMetadataADP.findMany({
    skip,
    take: limit,
  });
};