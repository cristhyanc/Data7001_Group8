from requests import Session
import re
import numpy
import time
import sys
import csv
import datetime
import random
import string

def get_letter(letter, follow_subsequent=True):
	print("get_letter(\"{}\").".format(letter))
	s = Session() # this session will hold the cookies

	headers = {"User-Agent":  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1.2 Safari/605.1.15",
			   "Origin" : "https://auspost.com.au/postcode",
			   "Referer": "https://auspost.com.au/postcode",
			   "Accept-Language" : "en-au",
			   "Host" : "auspost.com.au",
			   "Accept-Encoding" : "gzip, deflate",
			   "X-Requested-With" : "XMLHttpRequest",
	"Accept": "*/*",
	"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
	"Connection": "keep-alive",
	}

	target_url = "https://auspost.com.au/postcode/suburb-index/{}".format(letter)

	response = s.get(target_url, headers = headers)

	result_list = []
	subsequent_page_list = []

	for i in range(len(response.text.splitlines())):

		line = response.text.splitlines()[i]

		this_result_tuple = ()

		# lid = re.search( r'html', line, flags=re.IGNORECASE)
		# if lid:
		# 	# pass
		# 	print("found html")

		lid = re.match( r'.*class=\"pol-suburb-index-link js-pol-suburb-index-link\">(.+)</a>', line, flags=re.IGNORECASE)
		if lid:
			# print("Found suburb: {}".format(lid.group(1)))
			this_result = lid.group(1)#.encode('utf-8')
			result_list.append(this_result)

		lid = re.match( r'.*<a href=\"/postcode/suburb-index/({}\d)\">\d</a>'.format(letter), line, flags=re.IGNORECASE)
		if lid:
			print("Found subs page: {}".format(lid.group(1)))
			this_subsequent_page = lid.group(1)#.encode('utf-8')
			subsequent_page_list.append(this_subsequent_page)

	if follow_subsequent:
		for subsequent_page in subsequent_page_list:
			result_list.extend(get_letter(subsequent_page, False))

	return result_list



def main():
	# oall_result_list = get_letter("b"))

	target_letter_list = list(string.ascii_lowercase)
	# target_letter_list = ["c", "d"]
	random.shuffle(target_letter_list)
	number_of_target_letters = len(target_letter_list)

	i = 0
	oall_result_list = []
	#
	for this_target_letter in target_letter_list:
		i += 1
		print("Doing letter {} of {}.".format(i, number_of_target_letters)) ########
		if (1 < i):
			delay = numpy.random.exponential(1, 1)[0]
			print("Delaying {} s.".format(delay))
			sys.stdout.flush()
			time.sleep(delay)
		oall_result_list.extend(get_letter(this_target_letter))
	oall_result_list.sort()
	print(oall_result_list)

	with open('AP_suburb_list.csv','w') as out:
	    csv_out=csv.writer(out)
	    csv_out.writerow(['name'])
	    for item in oall_result_list:
	        csv_out.writerow([item])

if __name__ == "__main__":
	main()
