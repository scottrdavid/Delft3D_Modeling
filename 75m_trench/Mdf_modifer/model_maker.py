
## Booleans
domakemdf=True
domaketcefile=True
domakesedfile=True
domakebctfile=True

### Remember to adjust your .bcq file and dep in the 
### base mdf before running this code to create variants

##input file name Data
Taucrit='2_303' # tau critical for the mud
Tout='2.3030000E+00'
Q='600' #discharge
Qout='6.0000000e+002'
S='12' #slope--- only used for filenaming


## Data to be replaced in base files (base files below)
Qin='1.0000000e+002'
Tin='1.1230000E+00'

## input basefiles
basename='base'
basesed=basename+'.sed'
basetce=basename+'.tce'
basebct=basename+'.bct'
basemdf=basename+'.mdf'

##outputfiles (without extension)
filename='S'+S+'Q'+Q+'T'+Taucrit
sedout=filename+'.sed'
tceout=filename+'.tce'
bctout=filename+'.bct'
mdfout=filename+'.mdf'



##### create tce file
f1 = open(basetce, 'r')
f2 = open(tceout, 'w')
for line in f1:
    f2.write(line.replace(Tin, Tout))
f1.close()
f2.close()

##### create sed file
f1 = open(basesed, 'r')
f2 = open(sedout, 'w')
for line in f1:
    f2.write(line.replace(basetce, tceout))
f1.close()
f2.close()

##### create bct file
f1 = open(basebct, 'r')
f2 = open(bctout, 'w')
for line in f1:
    f2.write(line.replace(Qin, Qout))
f1.close()
f2.close()

##### create mdf file
f1 = open(basemdf, 'r')
f2 = open(mdfout, 'w')
for line in f1:
    f2.write(line.replace(basename, filename))
f1.close()
f2.close()
