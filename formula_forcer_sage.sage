
#@title 準備
from hashlib import sha256
from ecdsa import ecdsa
import random
import itertools
import re
import sys

g = ecdsa.generator_secp256k1
n = g.order()

x = 0xfbf47a8f81a770b6e4135fdd13e9b1dd4be86c09578cae2cc8fe64fbae6174c4
pub = ecdsa.Public_key(g, x*g)
pri = ecdsa.Private_key(pub, x)
k = 0xeed3fb81e541de2fe47350dab1349db7fc909df50ce33c93272f8db397775e7f

nonce = ecdsa.Public_key(g, k*g)
m1 = 'hello'  # @param {type:"string"}
print('\033[34m'+'秘密鍵(x)：0x{:x}'.format(x)+'\033[0m')
print('公開鍵(P)：(0x{:x},0x{:x})'.format(pub.point.x(), pub.point.y()))
print('\033[35m'+'ナンス(k)：0x{:x}'.format(k)+'\033[0m')
print('ナンスポイント(R)：(0x{:x},0x{:x})'.format(nonce.point.x(), nonce.point.y()))
print('メッセージ１：{}'.format(m1))

#r = int(input("R : "), 16)
#s = int(input("S : "), 16)
#z = int(input("Z : "), 16)

p = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F
n = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141
e1 = int.from_bytes(sha256(m1.encode('utf-8')).digest(), 'big')
sig1 = pri.sign(e1, k)
r = sig1.r
s = sig1.s
z = e1
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