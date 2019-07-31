#!/bin/bash

obabel -ig09 4-methylimidazole.log -omol -O4-methylimidazole.mol

# MAKE SURE TO ADD TO THE FOLLOWING SECTION IF YOU ARE DEALING WITH ANION/CATION SPECIES (ACETATE SHOWN IN EXAMPLE):
# M  CHG  1   1   1 # Postive Charge on Carbonyl Carbon
# M  CHG  1   2  -1 # Negative Charge on Oxygen Atom
# M  CHG  1   4  -1 # Negative Charge on Oxygen Atom
# M  END # Overall Charge is -1 for acetate

# Since we do not have anions/cations here, we ignore the insertion and skip to the following:

python << EOF

import openbabel
mol = openbabel.OBMol()
filename = '4-methylimidazole.mol' # .mol file
cv = openbabel.OBConversion()
cv.SetInAndOutFormats('mol', 'sdf') # .sdf file is where all conformers will be written to
cv.ReadFile(mol, filename) # .mol file is read
ff = openbabel.OBForceField.FindForceField("MMFF94") # Here we choose the MMFF94 force field
ff.SetLogLevel(openbabel.OBFF_LOGLVL_LOW)
ff.SetLogToStdErr()
ff.Setup(mol)
ff.WeightedRotorSearch(25,500) #25 conformers are searched per 500 geometric steps
ff.GetConformers(mol)
cv.WriteFile(mol, 'CONF.sdf') # Conformers are written

EOF
