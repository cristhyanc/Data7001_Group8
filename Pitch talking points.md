
**1. Data science problem**

I am a concerned taxpayer and an engaged voter. How can I inform myself about how the government is spending its budget? Is it allocating capital farily according to societal need and to maximise the benefit to people? Or do electoral pressures mean that some places get more than their share - e.g. marginal electorates? How can I map the dozens of government projects, worth billions of dollars, across 93 electorates (in Queensland state government alone), to keep an eye out for pork barreling?

**2. Datasets we'll use**

Core:
- Electoral boundaries. Available as shape files on QSpatial website for 2017 boundaries.
- Electoral results. (To determine safe ALP / safe LNP / marginal for each electorate.) Available on ECQ website by electorate for 2017 and previous elections.
- Queensland State Infrastrucutre Plan. (For spending.) Available from DSDTI website as pdf document.
- Basic census data. (E.g. to use population to translate spending into per capita spending, and more.)

Enrichment:
- Expanded census data. (E.g. income, wealth, population densitry, growth rates.)
- Tender data. (E.g. to identify contractors/party patterns.)
- Stated policy objectives of government: e.g. declared priority development areas, Office of Northern Australia plans.
- Others we identify as we go.

**3. What we'll do**
- Ingest the spending data, work out into which electorate it falls where possible.
- Ingest the electoral results, categories into safe ALP / safe LNP / marginal.
- Visualise the results, see what we find. Spatial exploratory data analysis.
- Mix in from the enrichment data sources.

**4. How we'll tell the story**
- Build a user friendly web tool allowing citizens to explore/visualise government spending and any spatial relationships to electoral status, in the context of other possible explanations for variation.
- We may look broadly e.g. Queensland and focus our enrichment effort on a narrower area e.g. SEQ or Brisbane.
