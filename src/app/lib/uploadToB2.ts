// lib/r2.ts
import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3'

export const r2 = new S3Client({
  region: `${process.env.B2_REGION}`,
  endpoint: `${process.env.B2_ENDPOINT}`,
  credentials: {
    accessKeyId: process.env.B2_ACCESS_KEY_ID!,
    secretAccessKey: process.env.B2_SECRET_ACCESS_KEY!,
  },
})

export const uploadToB2 = async (file: File, filename: string, bucket: string) => {
  const arrayBuffer = await file.arrayBuffer()

  const command = new PutObjectCommand({
    Bucket: bucket,
    Key: filename,
    Body: Buffer.from(arrayBuffer),
    ContentType: file.type,
  })

  await r2.send(command)

  return `${process.env.PUBLIC_B2_PUBLIC_URL}${filename}`
}
