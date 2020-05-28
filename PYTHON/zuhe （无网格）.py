from geopy.geocoders import Nominatim 
import shapely
import pyproj
import math
import pandas as pd
import numpy as np
import os
import folium
from folium import plugins
import webbrowser
import geopandas as gp
#Latitude and longitude acquisition
full1 = pd.read_excel('Calcarius_ornatus1.xlsx')
full1 = full1.dropna()
lat=int(full1['lat'].mean())
lon=int(full1['lon'].mean())
berlin_center=(lat,lon)





#Generate a map
map_berlin = folium.Map(location=berlin_center, zoom_start=13)

#Creating a map object：
marker_cluster = plugins.MarkerCluster().add_to(map_berlin) 
map_berlin.add_child(folium.LatLngPopup())
#Annotated data points：
route = []
for name,row in full1.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='orange').add_to(map_berlin)


full2 = pd.read_excel('Calcarius_pictus1.xlsx')
full2 = full2.dropna()
lat=int(full2['lat'].mean())
lon=int(full2['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full2.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='red').add_to(map_berlin)


full3 = pd.read_excel('Calidris_maritima1.xlsx')
full3 = full3.dropna()
lat=int(full3['lat'].mean())
lon=int(full3['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full3.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='black').add_to(map_berlin)



full4 = pd.read_excel('Catharus_bicknelli1.xlsx')
full4 = full4.dropna()
lat=int(full4['lat'].mean())
lon=int(full4['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full4.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='green').add_to(map_berlin)


full5 = pd.read_excel('Calidris_subruficollis1.xlsx')
full5 = full5.dropna()
lat=int(full5['lat'].mean())
lon=int(full5['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full5.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='green').add_to(map_berlin)



full6 = pd.read_excel('Elaenia_albiceps1.xlsx')
full6 = full6.dropna()
lat=int(full6['lat'].mean())
lon=int(full6['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full6.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='pink').add_to(map_berlin)



full7 = pd.read_excel('Calcarius_lapponicus1.xlsx')
full7 = full7.dropna()
lat=int(full7['lat'].mean())
lon=int(full7['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full7.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='red').add_to(map_berlin)




full8 = pd.read_excel('Calidris_bairdii1.xlsx')
full8 = full8.dropna()
lat=int(full8['lat'].mean())
lon=int(full8['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full8.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='black').add_to(map_berlin)



full9 = pd.read_excel('Empidonomus_aurantioatrocristatus1.xlsx')
full9 = full9.dropna()
lat=int(full9['lat'].mean())
lon=int(full9['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full9.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='black').add_to(map_berlin)

full10= pd.read_excel('Muscisaxicola_albilora1.xlsx')
full10 = full10.dropna()
lat=int(full10['lat'].mean())
lon=int(full10['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full10.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='green').add_to(map_berlin)

    
full11= pd.read_excel('Muscisaxicola_flavinucha1.xlsx')
full11 = full11.dropna()
lat=int(full11['lat'].mean())
lon=int(full11['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full11.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='blue').add_to(map_berlin)


full12= pd.read_excel('Oporornis_agilis1.xlsx')
full12 = full12.dropna()
lat=int(full12['lat'].mean())
lon=int(full12['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full12.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='black').add_to(map_berlin)


full13= pd.read_excel('Calidris_fuscicollis1.xlsx')
full13 = full13.dropna()
lat=int(full13['lat'].mean())
lon=int(full13['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full13.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='red').add_to(map_berlin)


full14= pd.read_excel('Progne_elegans1.xlsx')
full14 = full14.dropna()
lat=int(full14['lat'].mean())
lon=int(full14['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full14.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='pink').add_to(map_berlin)
    


full15= pd.read_excel('Progne_tapera1.xlsx')
full15 = full15.dropna()
lat=int(full15['lat'].mean())
lon=int(full15['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full15.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='green').add_to(map_berlin)


full16= pd.read_excel('Thinocorus_rumicivorus1.xlsx')
full16 = full16.dropna()
lat=int(full16['lat'].mean())
lon=int(full16['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full16.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='red').add_to(map_berlin)


    
full17= pd.read_excel('Vireo_flavoviridis1.xlsx')
full17 = full17.dropna()
lat=int(full17['lat'].mean())
lon=int(full17['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full17.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='green').add_to(map_berlin)


full18= pd.read_excel('Anthus_spragueii1.xlsx')
full18 = full18.dropna()
lat=int(full18['lat'].mean())
lon=int(full18['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full18.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='blue').add_to(map_berlin)


full19= pd.read_excel('Arenaria_melanocephala1.xlsx')
full19 = full19.dropna()
lat=int(full19['lat'].mean())
lon=int(full19['lon'].mean())
berlin_center=(lat,lon)

route = []
for name,row in full19.iterrows():

    route.append([row["lat"], row["lon"]])
    folium.PolyLine(route,weight=2,opacity=0.5,color='green').add_to(map_berlin)
map_berlin.save('map_berlin.html') #Save locally
webbrowser.open('map_berlin.html')  #Open in a browser
print("Run the main function")


