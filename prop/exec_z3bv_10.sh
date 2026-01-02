z3 l10_dyn_l01m0123_4.cyclone.bv.smt2 -st -T:7200 &>> out_z3bv10.txt
echo "fin l10_dyn_l01m0123_4.cyclone.bv.smt2" >> out_z3bv10.txt

echo "done l10_dyn_l01m0123_4.cyclone.bv.smt2"
z3 l10_dyn_l01m0123_8.cyclone.bv.smt2 -st -T:7200 &>> out_z3bv10.txt
echo "fin l10_dyn_l01m0123_8.cyclone.bv.smt2" >> out_z3bv10.txt

echo "done l10_dyn_l01m0123_8.cyclone.bv.smt2"
z3 l10_dyn_l01m0123_16.cyclone.bv.smt2 -st -T:7200 &>> out_z3bv10.txt
echo "fin l10_dyn_l01m0123_16.cyclone.bv.smt2" >> out_z3bv10.txt

echo "done l10_dyn_l01m0123_16.cyclone.bv.smt2"
z3 l10_dyn_l01m0123_32.cyclone.bv.smt2 -st -T:7200 &>> out_z3bv10.txt
echo "fin l10_dyn_l01m0123_32.cyclone.bv.smt2" >> out_z3bv10.txt

echo "done l10_dyn_l01m0123_32.cyclone.bv.smt2"
z3 l10_stc_l01.cyclone.bv.smt2 -st -T:7200 &>> out_z3bv10.txt
echo "fin l10_stc_l01.cyclone.bv.smt2" >> out_z3bv10.txt

echo "done l10_stc_l01.cyclone.bv.smt2"
z3 l10_stc_m0123.cyclone.bv.smt2 -st -T:7200 &>> out_z3bv10.txt
echo "fin l10_stc_m0123.cyclone.bv.smt2" >> out_z3bv10.txt

echo "done l10_stc_m0123.cyclone.bv.smt2"
z3 l10_stc_l01m0123.cyclone.bv.smt2 -st -T:7200 &>> out_z3bv10.txt
echo "fin l10_stc_l01m0123.cyclone.bv.smt2" >> out_z3bv10.txt

echo "done l10_stc_l01m0123.cyclone.bv.smt2"