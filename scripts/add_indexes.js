const { Client } = require('pg');
const fs = require('fs');
const path = require('path');

const envContent = fs.readFileSync(path.join(__dirname, '../.env'), 'utf8');
envContent.split('\n').forEach(line => {
  const [key, ...values] = line.split('=');
  if (key && values.length > 0) process.env[key.trim()] = values.join('=').trim();
});

async function main() {
  const client = new Client({
    connectionString: process.env.DATABASE_URL.replace('?sslmode=require', ''),
    ssl: { rejectUnauthorized: false }
  });
  
  try {
    await client.connect();
    console.log('Connected to DB. Adding indexes...');
    
    await client.query("CREATE INDEX IF NOT EXISTS idx_evidence_date ON evidence(evidence_date);");
    await client.query("CREATE INDEX IF NOT EXISTS idx_evidence_user_email ON evidence(user_email);");
    
    console.log('Indexes added successfully!');
  } catch (error) {
    console.error('Error adding indexes:', error);
  } finally {
    await client.end();
  }
}

main();
