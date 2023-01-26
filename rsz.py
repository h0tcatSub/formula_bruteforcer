
#@title 準備
from hashlib import sha256
from ecdsa import ecdsa
import random
import itertools
import re
import sys

g = ecdsa.generator_secp256k1
n = g.order()

x = 1
pub = ecdsa.Public_key(g, x*g)
pri = ecdsa.Private_key(pub, x)
k = 2
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
answer = 0
print(f"R = {hex(r)}")
print(f"S = {hex(s)}")
print(f"Z = {hex(z)}")