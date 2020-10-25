import pandas as pd

census = pd.read_csv('Census_3_Corrected SED.csv')
census.sort_values(by=['Electorate'])
safety = pd.read_csv('electorate_safety.csv')
projects = pd.read_csv('projectscsv.csv')

projects['Electorate'] = projects['Electorate'].str.upper()
safety['Electorate'] = safety['Electorate'].str.upper()

#censusComplete = census1.join(census2.set_index('Electorate'), on='Electorate')

projectSum = projects.groupby('Electorate').sum()

for electorate in census[0]:
    if electorate not in projectSum[1]:
        new_row = {'Electorate': electorate, 'TotalEstimatedCost': 0}
        projectSum = projectSum.append(new_row, ignore_index=True)

projectSeat = projectSum.join(safety.set_index('Electorate'), on='Electorate')

#projectSeat['MarginPower'] = projectSeat.apply(projectSeat['Margin'])

projectSeat.loc[projectSeat['Party'] == 'ALP', 'MarginPower'] = projectSeat['Margin']
projectSeat.loc[projectSeat['Party'] != 'ALP', 'MarginPower'] = projectSeat['Margin']*-1

complete = projectSeat.join(census.set_index('Electorate'), on='Electorate')
#complete = complete.drop(['SED_CODE_2016'], axis=1)
complete.to_csv('combined2.csv')
