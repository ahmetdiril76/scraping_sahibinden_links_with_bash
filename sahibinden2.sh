#!/usr/bin/env bash

# I think I will just get links in the pages and follow these links and scrape them
# Probably there won't be any data loss

#show 50 per page  

rm emlaklinks.txt

for i in {0..19}
do
	if [ $i -eq 0 ]
	then
		curl "https://www.sahibinden.com/satilik/aydin-kusadasi-davutlar?pagingSize=50&sorting=price_asc&query_text_mf=davutlar" >> tmp.txt

	else
		let "page = $i * 50"
		curl "https://www.sahibinden.com/satilik/aydin-kusadasi-davutlar?pagingOffset=$page&pagingSize=50&sorting=price_asc&query_text_mf=davutlar" >> tmp.txt
	fi

	cat tmp.txt |
	grep -Eoi '<a [^>]+>' | 
	grep -Eo 'href="/ilan/emlak[^\"]+"' | 

	sed "s/href=\"/https\:\/\/www\.sahibinden\.com/" |

	# removes last character
	sed 's/.$//' |
	uniq
done > emlaklinks.txt


