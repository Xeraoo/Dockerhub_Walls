import ifcopenshell.util.element
import pprint as pp

#Tymoteusz Maj
#Geoinformacja
#401370

# Użyty plik : #231110AC-11-Smiley-West-04-07-2007.ifc

#Obliczenia kubatury ścian 

m = ifcopenshell.open("231110AC-11-Smiley-West-04-07-2007.ifc")
walls = m.by_type("IfcWall")
#print(len(walls))

print(f'Liczba ścian w modelu: {len(walls)}')

walls = m.by_type("IfcWall")
ext_walls = []
for w in walls:
    psets = ifcopenshell.util.element.get_psets(w)
    if psets.get("Pset_WallCommon"):
        if bool(psets.get("Pset_WallCommon").get("IsExternal")):
            ext_walls.append(w)
            
print(f'Liczba ścian zewnętrznych: {len(ext_walls)}')

totalvolume = 0

for w in ext_walls:
    psets = ifcopenshell.util.element.get_psets(w)
    for psetname, pset_dict in psets.items():
        for name, value in pset_dict.items():
            # print (f"{name}: {value}")
            if name == "NetVolume":
                totalvolume += float(value)
print(f'TotalVolume: {totalvolume:.2f}')