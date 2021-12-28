with open("../input/day24.txt") as f:
    stringdata = f.read()
    
stringdata=stringdata.replace("inp", "\ninp")
groups =stringdata.split("\n\n")


groups =map(lambda x: x.split("\n"), groups)
groups=filter(lambda x: len(x) !=0, groups)

for g in filter(lambda x: len(x) !=0, groups):
    print(g)
    print()

groups2=map(lambda x: filter(lambda y: len(y)!=0), groups)
#print(list(groups))

z=zip(*groups2)
print(list(z))
