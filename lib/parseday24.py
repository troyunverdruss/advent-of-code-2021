with open("../input/day24.txt") as f:
    string_data = f.read()

string_data = string_data.replace("inp", "\ninp")
groups = string_data.split("\n\n")

groups = map(lambda x: x.split("\n"), groups)
# groups =map(lambda x: x.split("\n"), groups)
# print(list(groups)[0])
# print()
# groups=filter(lambda x: len(x) !=0, groups)

# for g in filter(lambda x: len(x) !=0, groups):
#    print(g)
#    print()

list_groups = list(groups)
groups2 = [
    list(filter(lambda y: len(y) != 0, x)) for x in list_groups
]



# print(list(groups))
# print(groups2)
z=zip(*groups2)
# print(list(z))
for line in z:
    for item in line:
        print(item.rjust(10), end='')
    print()
    print()
