# Day 3: Making Decisions - If/Then/Else## Learning Goal (3-4 hours)Make your scripts smart! Learn to make decisions based on conditions.## What You'll Learn Today- If/then/else statements- Testing conditions- File and string comparisons- Building logic into scripts## Today's Concepts to Master```bashif, then, else, elif, fi, test, [, [[, -f, -d, -z, -n```## Learning Path### Step 1: Basic Conditionals (45 min)```bash./exercises/basic_conditionals.sh```### Step 2: File Testing (45 min)```bash./exercises/file_tests.sh```### Step 3: String Comparisons (45 min)```bash./exercises/string_tests.sh```### Step 4: Number Comparisons (30 min)```bash./exercises/number_tests.sh```### Step 5: Build a Security Checker (60 min)```bash./scripts/basic_security_check.sh```### Step 6: Daily Challenge (45 min)```bash./exercises/daily_challenge.sh```## Success Criteria- [ ] Can write if/then/else statements- [ ] Understand file testing (-f, -d, -r, -w)- [ ] Can compare strings and numbers- [ ] Built a decision-making script- [ ] Combined multiple conditions## Tomorrow PreviewDay 4: Loops - Making scripts do repetitive tasks!---
## Conditional Quick Reference

| Test | Purpose | Example |
|------|---------|---------|
| -f file | File exists | if [ -f "config.txt" ] |
| -d dir | Directory exists | if [ -d "logs" ] |
| -r file | File readable | if [ -r "data.txt" ] |
| -w file | File writable | if [ -w "output.log" ] |
| -z string | String empty | if [ -z "$name" ] |
| -n string | String not empty | if [ -n "$input" ] |
| str1 = str2 | Strings equal | if [ "$a" = "$b" ] |
| num1 -eq num2 | Numbers equal | if [ $count -eq 5 ] |
| num1 -gt num2 | Greater than | if [ $age -gt 18 ] |
| num1 -lt num2 | Less than | if [ $score -lt 100 ] |
