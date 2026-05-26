const fs = require('fs');
const path = require('path');

const sqlPath = path.join(__dirname, '../backup.cleaned.sql');
const sql = fs.readFileSync(sqlPath, 'utf8');

// The functions start with CREATE FUNCTION or CREATE OR REPLACE FUNCTION
const regex = /CREATE(?: OR REPLACE)? FUNCTION([\s\S]*?)LANGUAGE plpgsql/gi;
let match;
while ((match = regex.exec(sql)) !== null) {
  console.log(match[0] + ";\n");
}
