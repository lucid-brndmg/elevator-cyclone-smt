echo "(set-logic QF_BV)" > y2bv3.smt2
cat l3_dyn_l01m0123_4.cyclone.bv.smt2 >> y2bv3.smt2
yices-smt2 -t 7200 -s y2bv3.smt2 &>> out_y2bv3.txt
echo "fin l3_dyn_l01m0123_4.cyclone.bv.smt2" >> out_y2bv3.txt

echo "done l3_dyn_l01m0123_4.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv3.smt2
cat l3_dyn_l01m0123_8.cyclone.bv.smt2 >> y2bv3.smt2
yices-smt2 -t 7200 -s y2bv3.smt2 &>> out_y2bv3.txt
echo "fin l3_dyn_l01m0123_8.cyclone.bv.smt2" >> out_y2bv3.txt

echo "done l3_dyn_l01m0123_8.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv3.smt2
cat l3_dyn_l01m0123_16.cyclone.bv.smt2 >> y2bv3.smt2
yices-smt2 -t 7200 -s y2bv3.smt2 &>> out_y2bv3.txt
echo "fin l3_dyn_l01m0123_16.cyclone.bv.smt2" >> out_y2bv3.txt

echo "done l3_dyn_l01m0123_16.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv3.smt2
cat l3_dyn_l01m0123_32.cyclone.bv.smt2 >> y2bv3.smt2
yices-smt2 -t 7200 -s y2bv3.smt2 &>> out_y2bv3.txt
echo "fin l3_dyn_l01m0123_32.cyclone.bv.smt2" >> out_y2bv3.txt

echo "done l3_dyn_l01m0123_32.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv3.smt2
cat l3_stc_l01.cyclone.bv.smt2 >> y2bv3.smt2
yices-smt2 -t 7200 -s y2bv3.smt2 &>> out_y2bv3.txt
echo "fin l3_stc_l01.cyclone.bv.smt2" >> out_y2bv3.txt

echo "done l3_stc_l01.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv3.smt2
cat l3_stc_m0123.cyclone.bv.smt2 >> y2bv3.smt2
yices-smt2 -t 7200 -s y2bv3.smt2 &>> out_y2bv3.txt
echo "fin l3_stc_m0123.cyclone.bv.smt2" >> out_y2bv3.txt

echo "done l3_stc_m0123.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv3.smt2
cat l3_stc_l01m0123.cyclone.bv.smt2 >> y2bv3.smt2
yices-smt2 -t 7200 -s y2bv3.smt2 &>> out_y2bv3.txt
echo "fin l3_stc_l01m0123.cyclone.bv.smt2" >> out_y2bv3.txt

echo "done l3_stc_l01m0123.cyclone.bv.smt2"