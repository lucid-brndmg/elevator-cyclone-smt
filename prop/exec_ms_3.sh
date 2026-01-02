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