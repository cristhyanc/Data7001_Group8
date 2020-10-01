import PyPDF2
from glob import glob
import re
from bs4 import BeautifulSoup as bs
import requests
from time import sleep
import csv

# %% Download all files

def download_pdf_results(year):
    webpage = requests.get('https://www.ecq.qld.gov.au/elections/election-results-and-statistics/' + year + 
                           '-state-election')
    soup =  bs(webpage.content,'html.parser')
    
    for a in soup.find_all('a', href=True):
        url = a['href']
        if url[-4:] == '.pdf':
            
            # Repeated accesses in a short period can result in rejection by server
            for attempts in range(5):
                try:
                    response = requests.get(url)
                    with open(year+url.split('/')[-1], 'wb') as f:
                        f.write(response.content)
                except:
                    sleep(5)
                    print('Failed: ' + year + url.split('/')[-1])
    
for year in ['2017','2015', '2012','2009']:
    'Usually comment this to prevent long runtimes'
    # download_pdf_results(year)
    # if year!= 2009:
    #     sleep(60)

# %% Open PDFs and pull final vote tallies
files = glob('*.pdf')

def read_pdf(file):
    with open(file, 'rb') as pdf:
        pdfReader = PyPDF2.PdfFileReader(pdf)
        return [pdfReader.getPage(page).extractText() for page in range(pdfReader.getNumPages())]
    
two_cand_results = []
errorList = []
for file in files:
    print(file)
    pdf = read_pdf(file)
    first_page = pdf[0]
    final_page = pdf[-1]
    
    raw_tally_str = final_page.split('Final Preference Votes')[-1].split(' ')[0]
    raw_tally_str = re.split('[a-zA-Z]',raw_tally_str)[0]

    if raw_tally_str[-4:] in ['2017','2015','2012','2009']:
        raw_tally_str = raw_tally_str[0:-4]
        
    tally_str = re.split('..\...',raw_tally_str)
    
    tally = []
    tally.append(int(tally_str[0].replace(',','')))
    tally.append(int(tally_str[1].replace(',','')))
    # Find exhausted and total votes
    temp = tally_str[2].split(',')
    
    total = ''.join([temp[-2][-2:],temp[-1]])
    
    if len(temp)==2:
        tally.append(int(temp[0][0:-2]))
    else:
        tally.append(int(''.join([temp[0],temp[1][0:-2]])))
        
    tally.append(int(total))
    
    if sum(tally[0:-1]) != tally[-1]:
        errorList.append(errorList)
    
    year = [file[0:4]]*4
    
    raw_candidate_str = first_page.split('%VotesVotes%')[1][0:6]
    candidates = [raw_candidate_str[0:3],raw_candidate_str[3:6], 'Exhausted', 'Total']
    
    electorate = [re.split('\d', re.split('\d\. ',first_page)[1])[0].replace('Enrolled ','')]*4
    
    two_cand_results += list(zip(year,electorate,candidates,tally))

print('Errors for the following files:\n',errorList)

with open('election_results_two_preferred.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    for row in two_cand_results:
        writer.writerow(row)
    
    
