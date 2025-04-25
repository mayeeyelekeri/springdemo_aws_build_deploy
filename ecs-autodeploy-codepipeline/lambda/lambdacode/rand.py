from __future__ import print_function
from random import randint

print('Loading function')

def lambda_handler(event, context):
  myNumber = randint(1000,2000)
  print("Random No. [ %s ]" % myNumber)
  return myNumber
