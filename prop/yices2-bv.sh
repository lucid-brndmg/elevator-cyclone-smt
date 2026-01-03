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

echo "(set-logic QF_BV)" > y2bv5.smt2
cat l5_dyn_l01m0123_4.cyclone.bv.smt2 >> y2bv5.smt2
yices-smt2 -t 7200 -s y2bv5.smt2 &>> out_y2bv5.txt
echo "fin l5_dyn_l01m0123_4.cyclone.bv.smt2" >> out_y2bv5.txt

echo "done l5_dyn_l01m0123_4.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv5.smt2
cat l5_dyn_l01m0123_8.cyclone.bv.smt2 >> y2bv5.smt2
yices-smt2 -t 7200 -s y2bv5.smt2 &>> out_y2bv5.txt
echo "fin l5_dyn_l01m0123_8.cyclone.bv.smt2" >> out_y2bv5.txt

echo "done l5_dyn_l01m0123_8.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv5.smt2
cat l5_dyn_l01m0123_16.cyclone.bv.smt2 >> y2bv5.smt2
yices-smt2 -t 7200 -s y2bv5.smt2 &>> out_y2bv5.txt
echo "fin l5_dyn_l01m0123_16.cyclone.bv.smt2" >> out_y2bv5.txt

echo "done l5_dyn_l01m0123_16.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv5.smt2
cat l5_dyn_l01m0123_32.cyclone.bv.smt2 >> y2bv5.smt2
yices-smt2 -t 7200 -s y2bv5.smt2 &>> out_y2bv5.txt
echo "fin l5_dyn_l01m0123_32.cyclone.bv.smt2" >> out_y2bv5.txt

echo "done l5_dyn_l01m0123_32.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv5.smt2
cat l5_stc_l01.cyclone.bv.smt2 >> y2bv5.smt2
yices-smt2 -t 7200 -s y2bv5.smt2 &>> out_y2bv5.txt
echo "fin l5_stc_l01.cyclone.bv.smt2" >> out_y2bv5.txt

echo "done l5_stc_l01.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv5.smt2
cat l5_stc_m0123.cyclone.bv.smt2 >> y2bv5.smt2
yices-smt2 -t 7200 -s y2bv5.smt2 &>> out_y2bv5.txt
echo "fin l5_stc_m0123.cyclone.bv.smt2" >> out_y2bv5.txt

echo "done l5_stc_m0123.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv5.smt2
cat l5_stc_l01m0123.cyclone.bv.smt2 >> y2bv5.smt2
yices-smt2 -t 7200 -s y2bv5.smt2 &>> out_y2bv5.txt
echo "fin l5_stc_l01m0123.cyclone.bv.smt2" >> out_y2bv5.txt

echo "done l5_stc_l01m0123.cyclone.bv.smt2"

echo "(set-logic QF_BV)" > y2bv10.smt2
cat l10_dyn_l01m0123_4.cyclone.bv.smt2 >> y2bv10.smt2
yices-smt2 -t 7200 -s y2bv10.smt2 &>> out_y2bv10.txt
echo "fin l10_dyn_l01m0123_4.cyclone.bv.smt2" >> out_y2bv10.txt

echo "done l10_dyn_l01m0123_4.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv10.smt2
cat l10_dyn_l01m0123_8.cyclone.bv.smt2 >> y2bv10.smt2
yices-smt2 -t 7200 -s y2bv10.smt2 &>> out_y2bv10.txt
echo "fin l10_dyn_l01m0123_8.cyclone.bv.smt2" >> out_y2bv10.txt

echo "done l10_dyn_l01m0123_8.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv10.smt2
cat l10_dyn_l01m0123_16.cyclone.bv.smt2 >> y2bv10.smt2
yices-smt2 -t 7200 -s y2bv10.smt2 &>> out_y2bv10.txt
echo "fin l10_dyn_l01m0123_16.cyclone.bv.smt2" >> out_y2bv10.txt

echo "done l10_dyn_l01m0123_16.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv10.smt2
cat l10_dyn_l01m0123_32.cyclone.bv.smt2 >> y2bv10.smt2
yices-smt2 -t 7200 -s y2bv10.smt2 &>> out_y2bv10.txt
echo "fin l10_dyn_l01m0123_32.cyclone.bv.smt2" >> out_y2bv10.txt

echo "done l10_dyn_l01m0123_32.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv10.smt2
cat l10_stc_l01.cyclone.bv.smt2 >> y2bv10.smt2
yices-smt2 -t 7200 -s y2bv10.smt2 &>> out_y2bv10.txt
echo "fin l10_stc_l01.cyclone.bv.smt2" >> out_y2bv10.txt

echo "done l10_stc_l01.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv10.smt2
cat l10_stc_m0123.cyclone.bv.smt2 >> y2bv10.smt2
yices-smt2 -t 7200 -s y2bv10.smt2 &>> out_y2bv10.txt
echo "fin l10_stc_m0123.cyclone.bv.smt2" >> out_y2bv10.txt

echo "done l10_stc_m0123.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv10.smt2
cat l10_stc_l01m0123.cyclone.bv.smt2 >> y2bv10.smt2
yices-smt2 -t 7200 -s y2bv10.smt2 &>> out_y2bv10.txt
echo "fin l10_stc_l01m0123.cyclone.bv.smt2" >> out_y2bv10.txt

echo "done l10_stc_l01m0123.cyclone.bv.smt2"

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
