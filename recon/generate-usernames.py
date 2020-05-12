#!/bin/python3
import argparse

parser = argparse.ArgumentParser(description="Enriches a basic list of usernames")
parser.add_argument("users", help="the base list of user names, formatted as [first name] [last name]")
args = parser.parse_args()

with open(args.users, "r") as f:
    names = f.read().splitlines()

with open("enriched-usernames.txt", "w") as f:
    for name in names:
        tokens = name.split(" ")
        f.write("{0}\n".format(name))	                     # FirstName LastName
        f.write("{0}.{1}\n".format(tokens[0], tokens[1]))    # FirstName.LastName
        f.write("{0}.{1}\n".format(tokens[0][0], tokens[1])) # FirstInitial.LastName
        f.write("{0}.{1}\n".format(tokens[0], tokens[1]))    # FirstName.LastInitial
        f.write("{0}{1}\n".format(tokens[0][0], tokens[1]))  # FirstInitialLastName
        f.write("{0}{1}\n".format(tokens[0], tokens[1][0]))  # FirstNameLastInitial
