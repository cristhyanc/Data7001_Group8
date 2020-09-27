from bs4 import BeautifulSoup as bs
import requests
import csv

with open('election_results.csv', 'w', newline='') as f:
    writer = csv.writer(f)

    for year in ['State2017', 'State2015']:

        status_code_next = 0
        district_no = 1
        
        webpage = requests.get('https://results.ecq.qld.gov.au/elections/state/' + year + '/results/district' + str(district_no) + '.html')
        
        while webpage.status_code != 404:
            
            soup =  bs(webpage.content,'html.parser')
            
            meta = soup.find('title').get_text().split(' - ')
            election = meta[1]
            district = meta[2]
            
            resultstbl = soup.find_all('table')[4]
            candidate_fields = resultstbl.find_all('a')
            
            for candidate in candidate_fields:
                next_row = []
                next_row.append(election)
                next_row.append(district)
                candidate_row = candidate.find_parent().find_parent()
                for num, td in enumerate(candidate_row.find_all('td')):
                    if num < 3:
                        next_row.append(td.get_text().strip())
                identifier = candidate.find_parent().find('img')
                if identifier:
                    if identifier['src'] == 'tick.gif':
                        next_row.append('winner')
                    if identifier['src'] == 'sitting.gif':
                        next_row.append('sitting')
                    
                writer.writerow(next_row)
            
            district_no += 1
            webpage = requests.get('https://results.ecq.qld.gov.au/elections/state/' + year + '/results/district' + str(district_no) + '.html')
        
    
    