
#@title 準備
from hashlib import sha256
import random
import itertools
import re
import sys

x = 0xfbf47a8f81a770b6e4135fdd13e9b1dd4be86c09578cae2cc8fe64fbae6174c4
k = 0xeed3fb81e541de2fe47350dab1349db7fc909df50ce33c93272f8db397775e7f

#r = int(input("R : "), 16)
#s = int(input("S : "), 16)
#z = int(input("Z : "), 16)

p = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F
n = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141
r = 0x84ce4a88775d59e3563901ac8025c806a3f34f669623c91ebd2e6bbe5b6404eb
s = 0xca33f2110c4d77c9cfb71106af5c046fd136698509dd53f0c24b3dd1ace8c18
z = 0x2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824
GN = GF(n)
GP = GF(p)

answer = 0
chars = "rsz*+-/np%()"
chars = sys.argv[1]
result_formula = ""
vals = itertools.product(chars, repeat = len(chars))
nr = len(chars) ** len(chars)
print(f"Try     {nr} patterns")
i = 0
file = open("formula.txt", "a")

for val in vals:
    try:
        val = "".join(val)
        
        print(f"Pattern {i} {val}", end = "\r")
        i += 1
        # pow  = skip
        if("**" in val): 
            continue
        answer =  eval(val)
        if(answer == k):
            print()
            print(answer)
            message = f"found formula. k = {val}"
            print(message)
            # Memo : private_key = (((((s * k) % n) - z) % n)*pow(r, n-2, n)) % n
            file.writelines(message)
    except Exception:
        pass
print() 
print("Done.")