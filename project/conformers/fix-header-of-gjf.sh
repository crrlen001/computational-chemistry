#If you have multiple conformers, z is the number of conformers below
for i in {1..z}; do sed -i "s/%chk=conf-x.chk/%chk=conf-${i}.chk/" conf-${i}.gjf; sed -i "s/ 4-methylimidazole.log/4-methylimidazole (${i})/" conf-${i}.gjf; sed -i 's/-1  1/-1 1/' conf-${i}.gjf; done
