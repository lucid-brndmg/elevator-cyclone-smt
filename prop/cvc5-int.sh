echo "(set-logic QF_LIA)" > c53.smt2
cat l3_dyn_l01m0123_4.cyclone.lia.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_dyn_l01m0123_4.cyclone.lia.smt2" >> out_c53.txt

echo "done l3_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_dyn_l01m0123_4.cyclone_gen.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_dyn_l01m0123_4.cyclone_gen.smt2" >> out_c53.txt

echo "done l3_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_dyn_l01m0123_8.cyclone.lia.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_dyn_l01m0123_8.cyclone.lia.smt2" >> out_c53.txt

echo "done l3_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_dyn_l01m0123_8.cyclone_gen.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_dyn_l01m0123_8.cyclone_gen.smt2" >> out_c53.txt

echo "done l3_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_dyn_l01m0123_16.cyclone.lia.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_dyn_l01m0123_16.cyclone.lia.smt2" >> out_c53.txt

echo "done l3_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_dyn_l01m0123_16.cyclone_gen.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_dyn_l01m0123_16.cyclone_gen.smt2" >> out_c53.txt

echo "done l3_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_dyn_l01m0123_32.cyclone.lia.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_dyn_l01m0123_32.cyclone.lia.smt2" >> out_c53.txt

echo "done l3_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_dyn_l01m0123_32.cyclone_gen.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_dyn_l01m0123_32.cyclone_gen.smt2" >> out_c53.txt

echo "done l3_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_stc_l01.cyclone.lia.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_stc_l01.cyclone.lia.smt2" >> out_c53.txt

echo "done l3_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_stc_l01.cyclone_gen.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_stc_l01.cyclone_gen.smt2" >> out_c53.txt

echo "done l3_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_stc_m0123.cyclone.lia.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_stc_m0123.cyclone.lia.smt2" >> out_c53.txt

echo "done l3_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_stc_m0123.cyclone_gen.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_stc_m0123.cyclone_gen.smt2" >> out_c53.txt

echo "done l3_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_stc_l01m0123.cyclone.lia.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_stc_l01m0123.cyclone.lia.smt2" >> out_c53.txt

echo "done l3_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c53.smt2
cat l3_stc_l01m0123.cyclone_gen.smt2 >> c53.smt2
cvc5 --stats --tlimit 7200000 c53.smt2 &>> out_c53.txt
echo "fin l3_stc_l01m0123.cyclone_gen.smt2" >> out_c53.txt

echo "done l3_stc_l01m0123.cyclone_gen.smt2"

echo "(set-logic QF_LIA)" > c55.smt2
cat l5_dyn_l01m0123_4.cyclone.lia.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_dyn_l01m0123_4.cyclone.lia.smt2" >> out_c55.txt

echo "done l5_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_dyn_l01m0123_4.cyclone_gen.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_dyn_l01m0123_4.cyclone_gen.smt2" >> out_c55.txt

echo "done l5_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_dyn_l01m0123_8.cyclone.lia.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_dyn_l01m0123_8.cyclone.lia.smt2" >> out_c55.txt

echo "done l5_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_dyn_l01m0123_8.cyclone_gen.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_dyn_l01m0123_8.cyclone_gen.smt2" >> out_c55.txt

echo "done l5_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_dyn_l01m0123_16.cyclone.lia.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_dyn_l01m0123_16.cyclone.lia.smt2" >> out_c55.txt

echo "done l5_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_dyn_l01m0123_16.cyclone_gen.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_dyn_l01m0123_16.cyclone_gen.smt2" >> out_c55.txt

echo "done l5_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_dyn_l01m0123_32.cyclone.lia.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_dyn_l01m0123_32.cyclone.lia.smt2" >> out_c55.txt

echo "done l5_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_dyn_l01m0123_32.cyclone_gen.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_dyn_l01m0123_32.cyclone_gen.smt2" >> out_c55.txt

echo "done l5_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_stc_l01.cyclone.lia.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_stc_l01.cyclone.lia.smt2" >> out_c55.txt

echo "done l5_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_stc_l01.cyclone_gen.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_stc_l01.cyclone_gen.smt2" >> out_c55.txt

echo "done l5_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_stc_m0123.cyclone.lia.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_stc_m0123.cyclone.lia.smt2" >> out_c55.txt

echo "done l5_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_stc_m0123.cyclone_gen.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_stc_m0123.cyclone_gen.smt2" >> out_c55.txt

echo "done l5_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_stc_l01m0123.cyclone.lia.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_stc_l01m0123.cyclone.lia.smt2" >> out_c55.txt

echo "done l5_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c55.smt2
cat l5_stc_l01m0123.cyclone_gen.smt2 >> c55.smt2
cvc5 --stats --tlimit 7200000 c55.smt2 &>> out_c55.txt
echo "fin l5_stc_l01m0123.cyclone_gen.smt2" >> out_c55.txt

echo "done l5_stc_l01m0123.cyclone_gen.smt2"

echo "(set-logic QF_LIA)" > c510.smt2
cat l10_dyn_l01m0123_4.cyclone.lia.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_dyn_l01m0123_4.cyclone.lia.smt2" >> out_c510.txt

echo "done l10_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_dyn_l01m0123_4.cyclone_gen.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_dyn_l01m0123_4.cyclone_gen.smt2" >> out_c510.txt

echo "done l10_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_dyn_l01m0123_8.cyclone.lia.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_dyn_l01m0123_8.cyclone.lia.smt2" >> out_c510.txt

echo "done l10_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_dyn_l01m0123_8.cyclone_gen.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_dyn_l01m0123_8.cyclone_gen.smt2" >> out_c510.txt

echo "done l10_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_dyn_l01m0123_16.cyclone.lia.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_dyn_l01m0123_16.cyclone.lia.smt2" >> out_c510.txt

echo "done l10_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_dyn_l01m0123_16.cyclone_gen.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_dyn_l01m0123_16.cyclone_gen.smt2" >> out_c510.txt

echo "done l10_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_dyn_l01m0123_32.cyclone.lia.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_dyn_l01m0123_32.cyclone.lia.smt2" >> out_c510.txt

echo "done l10_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_dyn_l01m0123_32.cyclone_gen.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_dyn_l01m0123_32.cyclone_gen.smt2" >> out_c510.txt

echo "done l10_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_stc_l01.cyclone.lia.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_stc_l01.cyclone.lia.smt2" >> out_c510.txt

echo "done l10_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_stc_l01.cyclone_gen.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_stc_l01.cyclone_gen.smt2" >> out_c510.txt

echo "done l10_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_stc_m0123.cyclone.lia.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_stc_m0123.cyclone.lia.smt2" >> out_c510.txt

echo "done l10_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_stc_m0123.cyclone_gen.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_stc_m0123.cyclone_gen.smt2" >> out_c510.txt

echo "done l10_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_stc_l01m0123.cyclone.lia.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_stc_l01m0123.cyclone.lia.smt2" >> out_c510.txt

echo "done l10_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c510.smt2
cat l10_stc_l01m0123.cyclone_gen.smt2 >> c510.smt2
cvc5 --stats --tlimit 7200000 c510.smt2 &>> out_c510.txt
echo "fin l10_stc_l01m0123.cyclone_gen.smt2" >> out_c510.txt

echo "done l10_stc_l01m0123.cyclone_gen.smt2"

echo "(set-logic QF_LIA)" > c515.smt2
cat l15_dyn_l01m0123_4.cyclone.lia.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_dyn_l01m0123_4.cyclone.lia.smt2" >> out_c515.txt

echo "done l15_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_dyn_l01m0123_4.cyclone_gen.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_dyn_l01m0123_4.cyclone_gen.smt2" >> out_c515.txt

echo "done l15_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_dyn_l01m0123_8.cyclone.lia.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_dyn_l01m0123_8.cyclone.lia.smt2" >> out_c515.txt

echo "done l15_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_dyn_l01m0123_8.cyclone_gen.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_dyn_l01m0123_8.cyclone_gen.smt2" >> out_c515.txt

echo "done l15_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_dyn_l01m0123_16.cyclone.lia.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_dyn_l01m0123_16.cyclone.lia.smt2" >> out_c515.txt

echo "done l15_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_dyn_l01m0123_16.cyclone_gen.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_dyn_l01m0123_16.cyclone_gen.smt2" >> out_c515.txt

echo "done l15_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_dyn_l01m0123_32.cyclone.lia.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_dyn_l01m0123_32.cyclone.lia.smt2" >> out_c515.txt

echo "done l15_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_dyn_l01m0123_32.cyclone_gen.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_dyn_l01m0123_32.cyclone_gen.smt2" >> out_c515.txt

echo "done l15_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_stc_l01.cyclone.lia.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_stc_l01.cyclone.lia.smt2" >> out_c515.txt

echo "done l15_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_stc_l01.cyclone_gen.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_stc_l01.cyclone_gen.smt2" >> out_c515.txt

echo "done l15_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_stc_m0123.cyclone.lia.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_stc_m0123.cyclone.lia.smt2" >> out_c515.txt

echo "done l15_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_stc_m0123.cyclone_gen.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_stc_m0123.cyclone_gen.smt2" >> out_c515.txt

echo "done l15_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_stc_l01m0123.cyclone.lia.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_stc_l01m0123.cyclone.lia.smt2" >> out_c515.txt

echo "done l15_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > c515.smt2
cat l15_stc_l01m0123.cyclone_gen.smt2 >> c515.smt2
cvc5 --stats --tlimit 7200000 c515.smt2 &>> out_c515.txt
echo "fin l15_stc_l01m0123.cyclone_gen.smt2" >> out_c515.txt

echo "done l15_stc_l01m0123.cyclone_gen.smt2"