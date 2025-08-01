# Day 2: Variables and Your First Script

## Learning Goal (2-3 hours)
Master variables and create your first interactive script. Today you'll make the computer remember things!

## What You'll Learn Today
- Create and use variables
- Get input from users
- Build your first interactive script
- Understand basic script structure

## Today's Concepts to Master
```bash
Variables, $USER, $HOME, read, echo, command substitution $()
```

## Learning Path

### Step 1: Simple Variables (30 min)
```bash
./exercises/simple_variables.sh
```

### Step 2: User Input Basics (45 min)
```bash
./exercises/user_input.sh
```

### Step 3: Command Substitution (30 min)
```bash
./exercises/command_substitution.sh
```

### Step 4: Build Your First Tool (60 min)
```bash
./scripts/first_script.sh
```

### Step 5: Daily Challenge (30 min)
```bash
./exercises/daily_challenge.sh
```

## Success Criteria
- [ ] Can create and use variables
- [ ] Can get user input with read
- [ ] Understand the difference between $variable and ${variable}
- [ ] Can use command substitution $(command)
- [ ] Built your first interactive script

## Tomorrow Preview
Day 3: Making decisions with if/then statements!

---

## Variable Quick Reference

| Concept | Purpose | Example |
|---------|---------|---------|
| name="value" | Create variable | username="admin" |
| $name | Use variable | echo $name |
| ${name} | Safe variable use | echo ${name}_suffix |
| read name | Get user input | read -p "Name: " username |
| $(command) | Command substitution | date=$(date) |
| $USER | Current user | echo $USER |
| $HOME | Home directory | echo $HOME |
| $PWD | Current directory | echo $PWD |
