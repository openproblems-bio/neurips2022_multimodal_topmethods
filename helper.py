from sys import argv


run, filename = argv

with open(filename) as f:
    lines = f.readlines()

with open(filename, 'w') as f:
    for line in lines:
        if line.startswith("> "):
            f.write(line[2:])
        else:
            f.write(line)

