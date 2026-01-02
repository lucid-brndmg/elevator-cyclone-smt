echo "(set-logic QF_BV)" > y2bv15.smt2
cat l15_dyn_l01m0123_4.cyclone.bv.smt2 >> y2bv15.smt2
yices-smt2 -t 7200 -s y2bv15.smt2 &>> out_y2bv15.txt
echo "fin l15_dyn_l01m0123_4.cyclone.bv.smt2" >> out_y2bv15.txt

echo "done l15_dyn_l01m0123_4.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv15.smt2
cat l15_dyn_l01m0123_8.cyclone.bv.smt2 >> y2bv15.smt2
yices-smt2 -t 7200 -s y2bv15.smt2 &>> out_y2bv15.txt
echo "fin l15_dyn_l01m0123_8.cyclone.bv.smt2" >> out_y2bv15.txt

echo "done l15_dyn_l01m0123_8.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv15.smt2
cat l15_dyn_l01m0123_16.cyclone.bv.smt2 >> y2bv15.smt2
yices-smt2 -t 7200 -s y2bv15.smt2 &>> out_y2bv15.txt
echo "fin l15_dyn_l01m0123_16.cyclone.bv.smt2" >> out_y2bv15.txt

echo "done l15_dyn_l01m0123_16.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv15.smt2
cat l15_dyn_l01m0123_32.cyclone.bv.smt2 >> y2bv15.smt2
yices-smt2 -t 7200 -s y2bv15.smt2 &>> out_y2bv15.txt
echo "fin l15_dyn_l01m0123_32.cyclone.bv.smt2" >> out_y2bv15.txt

echo "done l15_dyn_l01m0123_32.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv15.smt2
cat l15_stc_l01.cyclone.bv.smt2 >> y2bv15.smt2
yices-smt2 -t 7200 -s y2bv15.smt2 &>> out_y2bv15.txt
echo "fin l15_stc_l01.cyclone.bv.smt2" >> out_y2bv15.txt

echo "done l15_stc_l01.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv15.smt2
cat l15_stc_m0123.cyclone.bv.smt2 >> y2bv15.smt2
yices-smt2 -t 7200 -s y2bv15.smt2 &>> out_y2bv15.txt
echo "fin l15_stc_m0123.cyclone.bv.smt2" >> out_y2bv15.txt

echo "done l15_stc_m0123.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv15.smt2
cat l15_stc_l01m0123.cyclone.bv.smt2 >> y2bv15.smt2
yices-smt2 -t 7200 -s y2bv15.smt2 &>> out_y2bv15.txt
echo "fin l15_stc_l01m0123.cyclone.bv.smt2" >> out_y2bv15.txt

echo "done l15_stc_l01m0123.cyclone.bv.smt2"
