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