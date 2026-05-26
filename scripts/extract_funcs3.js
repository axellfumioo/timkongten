const fs = require('fs');
const path = require('path');

const sqlPath = path.join(__dirname, '../backup.sql');
const lines = fs.readFileSync(sqlPath, 'utf8').split('\n');

for (let i = 0; i < lines.length; i++) {
  if (lines[i].includes('CREATE FUNCTION public.get_statistics')) {
    console.log(lines.slice(i, i + 30).join('\n'));
    break;
  }
}
for (let i = 0; i < lines.length; i++) {
  if (lines[i].includes('CREATE FUNCTION public.get_content')) {
    console.log(lines.slice(i, i + 30).join('\n'));
    break;
  }
}
