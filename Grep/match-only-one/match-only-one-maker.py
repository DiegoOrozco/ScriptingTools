#! /usr/bin/env python
import sys
import random
import string

"""match-only-one-maker prints output according to the type and style for
regular expression matching."""

def print_output(all_output):
  """Prints out each output in all_output"""
  for output in all_output:
    print output

def make_numbers(num_outputs, style):
  """Generates num_outputs phone numbers in the specified style.  
  Style will generate the following formats:
    1: +12345678901
    2:  12345678901
    3:   2345678901"""
  numbers = []
  for i in range(num_outputs):
    number = ''
    if style == 1:
      number += '+'
    if style < 3:
      number += str(random.randrange(0, 10))
    for j in range(11):
      number += str(random.randrange(0, 10))
    numbers.append(number)
  return numbers

def make_group_references(num_outputs, style):
  """Makes strings in one of three formats:
    1: axx (any letter followed by two of the same letter)
    2: byyy (any letter followed by three of the same letter)
    3: cxy (any letter followed by two letters that are not the same)."""
  all_output = []
  for i in range(num_outputs):
    output = ''
    output += random.choice(string.ascii_letters)
    first_letter_index = random.randrange(0, len(string.ascii_letters))
    second_letter_index = -1
    while first_letter_index == second_letter_index or second_letter_index < 0:
      second_letter_index = random.randrange(0, len(string.ascii_letters))
    if style == 1:
      output += string.ascii_letters[first_letter_index] * 2
    elif style == 2:
      output += string.ascii_letters[first_letter_index] * 3
    else:
      output += string.ascii_letters[first_letter_index]
      output += string.ascii_letters[second_letter_index]
    all_output.append(output)
  return all_output

def main():
  if len(sys.argv) < 4:
    print ("Usage: python make-phone-numbers.py num_outputs type(1,2) "
          "style(1,2,3)")
    print "Type 1: phone numbers.  Type 2: group_references"
    sys.exit(-1)
  num_outputs = int(sys.argv[1])
  output_type = int(sys.argv[2])
  style = int(sys.argv[3])
  if output_type == 1:
    output = make_numbers(num_outputs, style)
  elif output_type == 2:
    output = make_group_references(num_outputs, style)
  print_output(output)

if __name__ == '__main__':
  main()
