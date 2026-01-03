echo "(set-logic QF_LIA)" > y23.smt2
cat l3_dyn_l01m0123_4.cyclone.lia.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_dyn_l01m0123_4.cyclone.lia.smt2" >> out_y23.txt

echo "done l3_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_dyn_l01m0123_4.cyclone_gen.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_dyn_l01m0123_4.cyclone_gen.smt2" >> out_y23.txt

echo "done l3_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_dyn_l01m0123_8.cyclone.lia.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_dyn_l01m0123_8.cyclone.lia.smt2" >> out_y23.txt

echo "done l3_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_dyn_l01m0123_8.cyclone_gen.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_dyn_l01m0123_8.cyclone_gen.smt2" >> out_y23.txt

echo "done l3_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_dyn_l01m0123_16.cyclone.lia.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_dyn_l01m0123_16.cyclone.lia.smt2" >> out_y23.txt

echo "done l3_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_dyn_l01m0123_16.cyclone_gen.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_dyn_l01m0123_16.cyclone_gen.smt2" >> out_y23.txt

echo "done l3_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_dyn_l01m0123_32.cyclone.lia.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_dyn_l01m0123_32.cyclone.lia.smt2" >> out_y23.txt

echo "done l3_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_dyn_l01m0123_32.cyclone_gen.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_dyn_l01m0123_32.cyclone_gen.smt2" >> out_y23.txt

echo "done l3_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_stc_l01.cyclone.lia.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_stc_l01.cyclone.lia.smt2" >> out_y23.txt

echo "done l3_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_stc_l01.cyclone_gen.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_stc_l01.cyclone_gen.smt2" >> out_y23.txt

echo "done l3_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_stc_m0123.cyclone.lia.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_stc_m0123.cyclone.lia.smt2" >> out_y23.txt

echo "done l3_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_stc_m0123.cyclone_gen.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_stc_m0123.cyclone_gen.smt2" >> out_y23.txt

echo "done l3_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_stc_l01m0123.cyclone.lia.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_stc_l01m0123.cyclone.lia.smt2" >> out_y23.txt

echo "done l3_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y23.smt2
cat l3_stc_l01m0123.cyclone_gen.smt2 >> y23.smt2
yices-smt2 -t 7200 -s y23.smt2 &>> out_y23.txt
echo "fin l3_stc_l01m0123.cyclone_gen.smt2" >> out_y23.txt

echo "done l3_stc_l01m0123.cyclone_gen.smt2"

echo "(set-logic QF_LIA)" > y25.smt2
cat l5_dyn_l01m0123_4.cyclone.lia.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_dyn_l01m0123_4.cyclone.lia.smt2" >> out_y25.txt

echo "done l5_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_dyn_l01m0123_4.cyclone_gen.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_dyn_l01m0123_4.cyclone_gen.smt2" >> out_y25.txt

echo "done l5_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_dyn_l01m0123_8.cyclone.lia.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_dyn_l01m0123_8.cyclone.lia.smt2" >> out_y25.txt

echo "done l5_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_dyn_l01m0123_8.cyclone_gen.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_dyn_l01m0123_8.cyclone_gen.smt2" >> out_y25.txt

echo "done l5_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_dyn_l01m0123_16.cyclone.lia.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_dyn_l01m0123_16.cyclone.lia.smt2" >> out_y25.txt

echo "done l5_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_dyn_l01m0123_16.cyclone_gen.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_dyn_l01m0123_16.cyclone_gen.smt2" >> out_y25.txt

echo "done l5_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_dyn_l01m0123_32.cyclone.lia.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_dyn_l01m0123_32.cyclone.lia.smt2" >> out_y25.txt

echo "done l5_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_dyn_l01m0123_32.cyclone_gen.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_dyn_l01m0123_32.cyclone_gen.smt2" >> out_y25.txt

echo "done l5_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_stc_l01.cyclone.lia.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_stc_l01.cyclone.lia.smt2" >> out_y25.txt

echo "done l5_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_stc_l01.cyclone_gen.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_stc_l01.cyclone_gen.smt2" >> out_y25.txt

echo "done l5_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_stc_m0123.cyclone.lia.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_stc_m0123.cyclone.lia.smt2" >> out_y25.txt

echo "done l5_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_stc_m0123.cyclone_gen.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_stc_m0123.cyclone_gen.smt2" >> out_y25.txt

echo "done l5_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_stc_l01m0123.cyclone.lia.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_stc_l01m0123.cyclone.lia.smt2" >> out_y25.txt

echo "done l5_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y25.smt2
cat l5_stc_l01m0123.cyclone_gen.smt2 >> y25.smt2
yices-smt2 -t 7200 -s y25.smt2 &>> out_y25.txt
echo "fin l5_stc_l01m0123.cyclone_gen.smt2" >> out_y25.txt

echo "done l5_stc_l01m0123.cyclone_gen.smt2"

echo "(set-logic QF_LIA)" > y210.smt2
cat l10_dyn_l01m0123_4.cyclone.lia.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_dyn_l01m0123_4.cyclone.lia.smt2" >> out_y210.txt

echo "done l10_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_dyn_l01m0123_4.cyclone_gen.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_dyn_l01m0123_4.cyclone_gen.smt2" >> out_y210.txt

echo "done l10_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_dyn_l01m0123_8.cyclone.lia.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_dyn_l01m0123_8.cyclone.lia.smt2" >> out_y210.txt

echo "done l10_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_dyn_l01m0123_8.cyclone_gen.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_dyn_l01m0123_8.cyclone_gen.smt2" >> out_y210.txt

echo "done l10_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_dyn_l01m0123_16.cyclone.lia.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_dyn_l01m0123_16.cyclone.lia.smt2" >> out_y210.txt

echo "done l10_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_dyn_l01m0123_16.cyclone_gen.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_dyn_l01m0123_16.cyclone_gen.smt2" >> out_y210.txt

echo "done l10_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_dyn_l01m0123_32.cyclone.lia.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_dyn_l01m0123_32.cyclone.lia.smt2" >> out_y210.txt

echo "done l10_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_dyn_l01m0123_32.cyclone_gen.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_dyn_l01m0123_32.cyclone_gen.smt2" >> out_y210.txt

echo "done l10_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_stc_l01.cyclone.lia.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_stc_l01.cyclone.lia.smt2" >> out_y210.txt

echo "done l10_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_stc_l01.cyclone_gen.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_stc_l01.cyclone_gen.smt2" >> out_y210.txt

echo "done l10_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_stc_m0123.cyclone.lia.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_stc_m0123.cyclone.lia.smt2" >> out_y210.txt

echo "done l10_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_stc_m0123.cyclone_gen.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_stc_m0123.cyclone_gen.smt2" >> out_y210.txt

echo "done l10_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_stc_l01m0123.cyclone.lia.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_stc_l01m0123.cyclone.lia.smt2" >> out_y210.txt

echo "done l10_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y210.smt2
cat l10_stc_l01m0123.cyclone_gen.smt2 >> y210.smt2
yices-smt2 -t 7200 -s y210.smt2 &>> out_y210.txt
echo "fin l10_stc_l01m0123.cyclone_gen.smt2" >> out_y210.txt

echo "done l10_stc_l01m0123.cyclone_gen.smt2"

echo "(set-logic QF_LIA)" > y215.smt2
cat l15_dyn_l01m0123_4.cyclone.lia.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_dyn_l01m0123_4.cyclone.lia.smt2" >> out_y215.txt

echo "done l15_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_dyn_l01m0123_4.cyclone_gen.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_dyn_l01m0123_4.cyclone_gen.smt2" >> out_y215.txt

echo "done l15_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_dyn_l01m0123_8.cyclone.lia.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_dyn_l01m0123_8.cyclone.lia.smt2" >> out_y215.txt

echo "done l15_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_dyn_l01m0123_8.cyclone_gen.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_dyn_l01m0123_8.cyclone_gen.smt2" >> out_y215.txt

echo "done l15_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_dyn_l01m0123_16.cyclone.lia.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_dyn_l01m0123_16.cyclone.lia.smt2" >> out_y215.txt

echo "done l15_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_dyn_l01m0123_16.cyclone_gen.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_dyn_l01m0123_16.cyclone_gen.smt2" >> out_y215.txt

echo "done l15_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_dyn_l01m0123_32.cyclone.lia.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_dyn_l01m0123_32.cyclone.lia.smt2" >> out_y215.txt

echo "done l15_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_dyn_l01m0123_32.cyclone_gen.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_dyn_l01m0123_32.cyclone_gen.smt2" >> out_y215.txt

echo "done l15_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_stc_l01.cyclone.lia.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_stc_l01.cyclone.lia.smt2" >> out_y215.txt

echo "done l15_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_stc_l01.cyclone_gen.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_stc_l01.cyclone_gen.smt2" >> out_y215.txt

echo "done l15_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_stc_m0123.cyclone.lia.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_stc_m0123.cyclone.lia.smt2" >> out_y215.txt

echo "done l15_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_stc_m0123.cyclone_gen.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_stc_m0123.cyclone_gen.smt2" >> out_y215.txt

echo "done l15_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_stc_l01m0123.cyclone.lia.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_stc_l01m0123.cyclone.lia.smt2" >> out_y215.txt

echo "done l15_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > y215.smt2
cat l15_stc_l01m0123.cyclone_gen.smt2 >> y215.smt2
yices-smt2 -t 7200 -s y215.smt2 &>> out_y215.txt
echo "fin l15_stc_l01m0123.cyclone_gen.smt2" >> out_y215.txt

echo "done l15_stc_l01m0123.cyclone_gen.smt2"