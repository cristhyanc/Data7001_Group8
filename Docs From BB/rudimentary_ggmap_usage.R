library(ggmap)
library(maptools)

# read a shape file into an R object shape
# give a warning about depreciated - have not yet looked into
shape <- readShapePoly("QSC_Extracted_Data_20200909_154425067000-18404/State_electoral_boundaries_2008.shp")

# get a map from Google. Note that you need to stuff around with a Google Maps
# account and get an API key to get this to work. This will centre on UQ at
# some default zoom.
ggmap(get_map(location="University of Queensland", source="google", maptype="roadmap", crop=FALSE))

# get a Queensland map
ggmap(get_map(location="Queensland", source="google", maptype="roadmap", crop=FALSE, zoom=5))
        + geom_polygon(data = shape, aes(x = long, y = lat, group = group)) + coord_equal() + theme_map()

# put some locations from descriptions, top of Queensland map
ggmap(get_map(location="Queensland", source="google", maptype="roadmap", crop=FALSE, zoom=5)) + geom_point(data = rbind(geocode("University of Queensland"), geocode("Charleville, Queensland Australia"), geocode("Biloela"), geocode("Birdsville"), geocode("Longreach"), geocode("Mt Isa")), aes(x = lon, y = lat))

# put electorates, from shape file, on top of Queensland map
gmap(get_map(location="Queensland", source="google", maptype="roadmap", crop=FALSE, zoom=5)) + geom_polygon(data = shape, aes(x = long, y = lat, group = group))