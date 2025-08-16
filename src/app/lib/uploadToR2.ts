// lib/r2.ts
import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3'

export const r2 = new S3Client({
  region: 'auto',
  endpoint: `${process.env.R2_ENDPOINT}`, // contoh: https://<account_id>.r2.cloudflarestorage.com
  credentials: {
    accessKeyId: process.env.R2_ACCESS_KEY_ID!,
    secretAccessKey: process.env.R2_SECRET_ACCESS_KEY!,
  },
})

export const uploadToR2 = async (file: File, filename: string, bucket: string) => {
  const arrayBuffer = await file.arrayBuffer()

  const command = new PutObjectCommand({
    Bucket: bucket,
    Key: filename,
    Body: Buffer.from(arrayBuffer),
    ContentType: file.type,
  })

  await r2.send(command)

  return `https://image.axellfumioo.my.id/humas/${filename}`
}
