import pandas as pd

census1 = pd.read_csv('Census1.csv')
census2 = pd.read_csv('Census2.csv')
safety = pd.read_csv('electorate_safety.csv')
projects = pd.read_csv('projectscsv.csv')

census1['Electorate'] = census1['Electorate'].str.upper()
census2['Electorate'] = census2['Electorate'].str.upper()
projects['Electorate'] = projects['Electorate'].str.upper()
safety['Electorate'] = safety['Electorate'].str.upper()

censusComplete = census1.join(census2.set_index('Electorate'), on='Electorate')

projectSeat = projects.groupby('Electorate').sum().join(safety.set_index('Electorate'), on='Electorate')

#projectSeat['MarginPower'] = projectSeat.apply(projectSeat['Margin'])

projectSeat.loc[projectSeat['Party'] == 'ALP', 'MarginPower'] = projectSeat['Margin']
projectSeat.loc[projectSeat['Party'] != 'ALP', 'MarginPower'] = projectSeat['Margin']*-1

complete = projectSeat.join(censusComplete.set_index('Electorate'), on='Electorate')
complete = complete.drop(['SED_CODE_2016'], axis=1)
complete.to_csv('combined.csv')