#!/bin/bash

USAGE="USAGE: ldapdumper.sh [ip address of LDAP server] [search base] [path to output directory (including slash)]"

if [[ $# -ne 3 ]]
then
	echo $USAGE
else
	echo "Running ldap queries..."
	${ldapsearch -x -h $1 -b $2 "(&(objectClass=user)(objectClass=person))" > $3}
fi
