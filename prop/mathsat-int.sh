echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_dyn_l01m0123_4.cyclone.lia.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_dyn_l01m0123_4.cyclone.lia.smt2" >> out_ms3.txt

echo "done l3_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_dyn_l01m0123_4.cyclone_gen.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_dyn_l01m0123_4.cyclone_gen.smt2" >> out_ms3.txt

echo "done l3_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_dyn_l01m0123_8.cyclone.lia.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_dyn_l01m0123_8.cyclone.lia.smt2" >> out_ms3.txt

echo "done l3_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_dyn_l01m0123_8.cyclone_gen.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_dyn_l01m0123_8.cyclone_gen.smt2" >> out_ms3.txt

echo "done l3_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_dyn_l01m0123_16.cyclone.lia.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_dyn_l01m0123_16.cyclone.lia.smt2" >> out_ms3.txt

echo "done l3_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_dyn_l01m0123_16.cyclone_gen.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_dyn_l01m0123_16.cyclone_gen.smt2" >> out_ms3.txt

echo "done l3_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_dyn_l01m0123_32.cyclone.lia.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_dyn_l01m0123_32.cyclone.lia.smt2" >> out_ms3.txt

echo "done l3_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_dyn_l01m0123_32.cyclone_gen.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_dyn_l01m0123_32.cyclone_gen.smt2" >> out_ms3.txt

echo "done l3_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_stc_l01.cyclone.lia.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_stc_l01.cyclone.lia.smt2" >> out_ms3.txt

echo "done l3_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_stc_l01.cyclone_gen.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_stc_l01.cyclone_gen.smt2" >> out_ms3.txt

echo "done l3_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_stc_m0123.cyclone.lia.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_stc_m0123.cyclone.lia.smt2" >> out_ms3.txt

echo "done l3_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_stc_m0123.cyclone_gen.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_stc_m0123.cyclone_gen.smt2" >> out_ms3.txt

echo "done l3_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_stc_l01m0123.cyclone.lia.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_stc_l01m0123.cyclone.lia.smt2" >> out_ms3.txt

echo "done l3_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms3.smt2
cat l3_stc_l01m0123.cyclone_gen.smt2 >> ms3.smt2
timeout 7200 mathsat -stats ms3.smt2 &>> out_ms3.txt
echo "fin l3_stc_l01m0123.cyclone_gen.smt2" >> out_ms3.txt

echo "done l3_stc_l01m0123.cyclone_gen.smt2"

echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_dyn_l01m0123_4.cyclone.lia.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_dyn_l01m0123_4.cyclone.lia.smt2" >> out_ms5.txt

echo "done l5_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_dyn_l01m0123_4.cyclone_gen.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_dyn_l01m0123_4.cyclone_gen.smt2" >> out_ms5.txt

echo "done l5_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_dyn_l01m0123_8.cyclone.lia.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_dyn_l01m0123_8.cyclone.lia.smt2" >> out_ms5.txt

echo "done l5_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_dyn_l01m0123_8.cyclone_gen.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_dyn_l01m0123_8.cyclone_gen.smt2" >> out_ms5.txt

echo "done l5_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_dyn_l01m0123_16.cyclone.lia.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_dyn_l01m0123_16.cyclone.lia.smt2" >> out_ms5.txt

echo "done l5_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_dyn_l01m0123_16.cyclone_gen.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_dyn_l01m0123_16.cyclone_gen.smt2" >> out_ms5.txt

echo "done l5_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_dyn_l01m0123_32.cyclone.lia.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_dyn_l01m0123_32.cyclone.lia.smt2" >> out_ms5.txt

echo "done l5_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_dyn_l01m0123_32.cyclone_gen.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_dyn_l01m0123_32.cyclone_gen.smt2" >> out_ms5.txt

echo "done l5_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_stc_l01.cyclone.lia.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_stc_l01.cyclone.lia.smt2" >> out_ms5.txt

echo "done l5_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_stc_l01.cyclone_gen.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_stc_l01.cyclone_gen.smt2" >> out_ms5.txt

echo "done l5_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_stc_m0123.cyclone.lia.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_stc_m0123.cyclone.lia.smt2" >> out_ms5.txt

echo "done l5_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_stc_m0123.cyclone_gen.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_stc_m0123.cyclone_gen.smt2" >> out_ms5.txt

echo "done l5_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_stc_l01m0123.cyclone.lia.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_stc_l01m0123.cyclone.lia.smt2" >> out_ms5.txt

echo "done l5_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms5.smt2
cat l5_stc_l01m0123.cyclone_gen.smt2 >> ms5.smt2
timeout 7200 mathsat -stats ms5.smt2 &>> out_ms5.txt
echo "fin l5_stc_l01m0123.cyclone_gen.smt2" >> out_ms5.txt

echo "done l5_stc_l01m0123.cyclone_gen.smt2"

echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_dyn_l01m0123_4.cyclone.lia.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_dyn_l01m0123_4.cyclone.lia.smt2" >> out_ms10.txt

echo "done l10_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_dyn_l01m0123_4.cyclone_gen.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_dyn_l01m0123_4.cyclone_gen.smt2" >> out_ms10.txt

echo "done l10_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_dyn_l01m0123_8.cyclone.lia.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_dyn_l01m0123_8.cyclone.lia.smt2" >> out_ms10.txt

echo "done l10_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_dyn_l01m0123_8.cyclone_gen.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_dyn_l01m0123_8.cyclone_gen.smt2" >> out_ms10.txt

echo "done l10_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_dyn_l01m0123_16.cyclone.lia.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_dyn_l01m0123_16.cyclone.lia.smt2" >> out_ms10.txt

echo "done l10_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_dyn_l01m0123_16.cyclone_gen.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_dyn_l01m0123_16.cyclone_gen.smt2" >> out_ms10.txt

echo "done l10_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_dyn_l01m0123_32.cyclone.lia.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_dyn_l01m0123_32.cyclone.lia.smt2" >> out_ms10.txt

echo "done l10_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_dyn_l01m0123_32.cyclone_gen.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_dyn_l01m0123_32.cyclone_gen.smt2" >> out_ms10.txt

echo "done l10_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_stc_l01.cyclone.lia.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_stc_l01.cyclone.lia.smt2" >> out_ms10.txt

echo "done l10_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_stc_l01.cyclone_gen.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_stc_l01.cyclone_gen.smt2" >> out_ms10.txt

echo "done l10_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_stc_m0123.cyclone.lia.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_stc_m0123.cyclone.lia.smt2" >> out_ms10.txt

echo "done l10_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_stc_m0123.cyclone_gen.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_stc_m0123.cyclone_gen.smt2" >> out_ms10.txt

echo "done l10_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_stc_l01m0123.cyclone.lia.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_stc_l01m0123.cyclone.lia.smt2" >> out_ms10.txt

echo "done l10_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms10.smt2
cat l10_stc_l01m0123.cyclone_gen.smt2 >> ms10.smt2
timeout 7200 mathsat -stats ms10.smt2 &>> out_ms10.txt
echo "fin l10_stc_l01m0123.cyclone_gen.smt2" >> out_ms10.txt

echo "done l10_stc_l01m0123.cyclone_gen.smt2"

echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_dyn_l01m0123_4.cyclone.lia.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_dyn_l01m0123_4.cyclone.lia.smt2" >> out_ms15.txt

echo "done l15_dyn_l01m0123_4.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_dyn_l01m0123_4.cyclone_gen.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_dyn_l01m0123_4.cyclone_gen.smt2" >> out_ms15.txt

echo "done l15_dyn_l01m0123_4.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_dyn_l01m0123_8.cyclone.lia.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_dyn_l01m0123_8.cyclone.lia.smt2" >> out_ms15.txt

echo "done l15_dyn_l01m0123_8.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_dyn_l01m0123_8.cyclone_gen.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_dyn_l01m0123_8.cyclone_gen.smt2" >> out_ms15.txt

echo "done l15_dyn_l01m0123_8.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_dyn_l01m0123_16.cyclone.lia.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_dyn_l01m0123_16.cyclone.lia.smt2" >> out_ms15.txt

echo "done l15_dyn_l01m0123_16.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_dyn_l01m0123_16.cyclone_gen.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_dyn_l01m0123_16.cyclone_gen.smt2" >> out_ms15.txt

echo "done l15_dyn_l01m0123_16.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_dyn_l01m0123_32.cyclone.lia.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_dyn_l01m0123_32.cyclone.lia.smt2" >> out_ms15.txt

echo "done l15_dyn_l01m0123_32.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_dyn_l01m0123_32.cyclone_gen.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_dyn_l01m0123_32.cyclone_gen.smt2" >> out_ms15.txt

echo "done l15_dyn_l01m0123_32.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_stc_l01.cyclone.lia.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_stc_l01.cyclone.lia.smt2" >> out_ms15.txt

echo "done l15_stc_l01.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_stc_l01.cyclone_gen.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_stc_l01.cyclone_gen.smt2" >> out_ms15.txt

echo "done l15_stc_l01.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_stc_m0123.cyclone.lia.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_stc_m0123.cyclone.lia.smt2" >> out_ms15.txt

echo "done l15_stc_m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_stc_m0123.cyclone_gen.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_stc_m0123.cyclone_gen.smt2" >> out_ms15.txt

echo "done l15_stc_m0123.cyclone_gen.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_stc_l01m0123.cyclone.lia.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_stc_l01m0123.cyclone.lia.smt2" >> out_ms15.txt

echo "done l15_stc_l01m0123.cyclone.lia.smt2"
echo "(set-logic QF_LIA)" > ms15.smt2
cat l15_stc_l01m0123.cyclone_gen.smt2 >> ms15.smt2
timeout 7200 mathsat -stats ms15.smt2 &>> out_ms15.txt
echo "fin l15_stc_l01m0123.cyclone_gen.smt2" >> out_ms15.txt

echo "done l15_stc_l01m0123.cyclone_gen.smt2"