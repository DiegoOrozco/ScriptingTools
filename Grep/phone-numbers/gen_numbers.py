#!/usr/bin/python
import random
import sys

verbose = True
numberQuality = 1
def getRandomNumberWithDelim(curNumbers, delim):
  thisNumber = ''
  while True:
    for x in range (1, 11):
      thisNumber += str(random.randrange(0,10))
      if x%3 == 0 and x <=6 and not (numberQuality == 3 and random.uniform(0,1) > .5):
        thisNumber += delim
    if thisNumber not in curNumbers:
      break
  return thisNumber

def getFancyFormat(curNumbers):
  if (numberQuality >= 2 and random.uniform(0,1) > .85):
    thisNumber = ''
  else:
    thisNumber = '('
  while True:
    for x in range (1, 11):
      thisNumber += str(random.randrange(0,10))
      if x==6 and not (numberQuality == 3 and random.uniform(0,1) > .5) :
        thisNumber += "-"
      if x == 3 and not (numberQuality >=2 and random.uniform(0,1) > .5):
        thisNumber += ")"
    if thisNumber not in curNumbers:
      break
  return thisNumber



def defineRandomPhoneNumbers(numRandom, type):
  numbersList = []
  for x in range (numRandom):
    if type == 1:
      numbersList.append(getRandomNumberWithDelim(numbersList, "-"))
    elif type == 2:
      if random.uniform(0,1) > .5:
        numbersList.append(getRandomNumberWithDelim(numbersList, "-"))
      else:
        numbersList.append(getRandomNumberWithDelim(numbersList, ""))
    elif type >= 3:
      if random.uniform(0,1) > .6:
        numbersList.append(getRandomNumberWithDelim(numbersList, "-"))
      elif random.uniform(0,1) > .3:
        numbersList.append(getRandomNumberWithDelim(numbersList, ""))
      else :
        numbersList.append(getFancyFormat(numbersList))

  return numbersList

def makeAFile(randomPhoneNumbers, numNumbers, lineLen, lineNum, fileNum, dir):
  thisFile = ''
  numsRemaining = numNumbers
  charactersTotal = lineLen*lineNum
  charactersMade = 0;
  curProbability = float(charactersMade)/float(charactersTotal)
  f = open(dir+"/cs1u_file_"+str(fileNum), "w")

  for x in range(lineNum):
    thisLine = ''
    for y in range(lineLen):
      if random.uniform(0,1) > .90:
        thisLine += ' '
      elif random.uniform(0,1) > .95:
        thisLine += '.'
      else:
        thisCh = chr(random.randrange(97, 123))
        thisLine += thisCh
      charactersMade += 1
      curProbability = float(charactersMade)/float(charactersTotal)
      if random.uniform(0,1) < curProbability and numsRemaining > 0:
        thisLine += " "+randomPhoneNumbers.pop()+" "
        numsRemaining -= 1
    thisLine += '\n'
    thisFile += thisLine
  for x in range(numsRemaining):
    thisLine += " "+randomPhoneNumbers.pop()+" "
  f.write(thisFile)
  f.close()
  return thisFile

def makeRandomFiles(randomPhoneNumbers, numRandomNumbers, numTextFiles, lineLen, lineNum, dir):
  for file in range(numTextFiles):
    print "----File "+str(file)+"----"
    if verbose == True :
      print makeAFile(randomPhoneNumbers, numRandomNumbers/numTextFiles, lineLen, lineNum, file, dir)
    else : 
      makeAFile(randomPhoneNumbers, numRandomNumbers/numTextFiles, lineLen, lineNum, file, dir)


if len(sys.argv) < 7:
  print "Please specify two integers for the # of phone numbers, #files, #chars per line, #lines per file, dir to save, and:"
  print "1 - numbers only of form xxx-xxx-xxxx"
  print "2 - numbers of form 1 and xxxxxxxxxx"
  print "3 - numbers of form 2 and (xxx)xxx-xxxx"
  print "4 - numbers of form 3 and some missing parens"
  print "5 - numbers of form 4 and some missing dashes"
  sys.exit(-1)

numRandomNumbers = int(sys.argv[1])
numTextFiles = int(sys.argv[2])
lineLength = int(sys.argv[3])
lineNumbers = int(sys.argv[4])
dir = sys.argv[5]
type = int(sys.argv[6])
verboseParam = sys.argv[7]

if type == 4:
  numberQuality = 2;
elif type == 5:
  numberQuality = 3;

if len(sys.argv) == 8:
  if verboseParam == 'v':
    verbose = True
    print "verbose mode"
  elif verboseParam == '-v':
    verbose = False
    print "quiet mode"

if numRandomNumbers > numTextFiles:
  numRandomNumbers = (numRandomNumbers/numTextFiles)*numTextFiles
else:
  numRandomNumbers = (numTextFiles/numRandomNumbers)*numRandomNumbers

print "Generating "+str(numRandomNumbers)+" phone numbers of type "+str(type)
randomNumbers = defineRandomPhoneNumbers(numRandomNumbers, type)
print randomNumbers

f = open(dir+"/golden", "w")
f.write(repr(randomNumbers))
f.close()

makeRandomFiles(randomNumbers, numRandomNumbers, numTextFiles, lineLength, lineNumbers, dir)
