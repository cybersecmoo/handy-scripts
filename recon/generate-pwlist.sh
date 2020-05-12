#!/bin/bash
USAGE="USAGE: ./generate-pwlist [base wordlist] [optional min password length (inclusive)] [optional max password length (inclusive)]"

if [ $# -lt 1 ]
then
	echo $USAGE
else
	BASE_LIST=$1
	CURRENT_YEAR=$(date +"%Y")
	
	for i in $(cat $BASE_LIST)
	do
		echo ${i} >> tmp1
		echo ${i}${CURRENT_YEAR} >> tmp1
	done
	
	hashcat --force --stdout tmp1 -r /usr/share/hashcat/rules/best64.rule -r /usr/share/hashcat/rules/toggles1.rule > tmp2
	sort -u tmp2 > tmp3
	
	if [ $# -gt 1 ]
	then
		MIN=$2
		echo "Removing words with fewer than $MIN characters..."
		awk -v MIN="$MIN" 'length($0) >= MIN' tmp3 > tmp4
		if [ $# -gt 2 ]
		then
			MAX=$3
			echo "Removing words with more that $MAX characters..."
			awk -v MAX="$MAX" 'length($0) <= MAX' tmp4 > generated-wordlist.txt
		else
			cat tmp4 > generated-wordlist.txt
		fi
	else
		cat tmp3 > generated-wordlist.txt
	fi
	
	echo "Wordlist created!"
	NUM_WORDS=$(wc -l generated-wordlist.txt)
	echo "There are $NUM_WORDS words in the list"
	rm -f tmp1
	rm -f tmp2
	rm -f tmp3
	rm -f tmp4
	rm -f tmp5
fi
