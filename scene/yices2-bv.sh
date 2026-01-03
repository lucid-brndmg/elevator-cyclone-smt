echo "(set-logic QF_BV)" > y2bv.smt2
cat s1_a.cyclone.bv.smt2 >> y2bv.smt2
yices-smt2 -t 7200 -s y2bv.smt2 &>> out_y2bv.txt
echo "fin s1_a.cyclone.bv.smt2" >> out_y2bv.txt

echo "done s1_a.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv.smt2
cat s2_a.cyclone.bv.smt2 >> y2bv.smt2
yices-smt2 -t 7200 -s y2bv.smt2 &>> out_y2bv.txt
echo "fin s2_a.cyclone.bv.smt2" >> out_y2bv.txt

echo "done s2_a.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv.smt2
cat s3_a.cyclone.bv.smt2 >> y2bv.smt2
yices-smt2 -t 7200 -s y2bv.smt2 &>> out_y2bv.txt
echo "fin s3_a.cyclone.bv.smt2" >> out_y2bv.txt

echo "done s3_a.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv.smt2
cat s4_a.cyclone.bv.smt2 >> y2bv.smt2
yices-smt2 -t 7200 -s y2bv.smt2 &>> out_y2bv.txt
echo "fin s4_a.cyclone.bv.smt2" >> out_y2bv.txt

echo "done s4_a.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv.smt2
cat s5_a.cyclone.bv.smt2 >> y2bv.smt2
yices-smt2 -t 7200 -s y2bv.smt2 &>> out_y2bv.txt
echo "fin s5_a.cyclone.bv.smt2" >> out_y2bv.txt

echo "done s5_a.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv.smt2
cat s6_a.cyclone.bv.smt2 >> y2bv.smt2
yices-smt2 -t 7200 -s y2bv.smt2 &>> out_y2bv.txt
echo "fin s6_a.cyclone.bv.smt2" >> out_y2bv.txt

echo "done s6_a.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv.smt2
cat s7_a.cyclone.bv.smt2 >> y2bv.smt2
yices-smt2 -t 7200 -s y2bv.smt2 &>> out_y2bv.txt
echo "fin s7_a.cyclone.bv.smt2" >> out_y2bv.txt

echo "done s7_a.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv.smt2
cat s8_a.cyclone.bv.smt2 >> y2bv.smt2
yices-smt2 -t 7200 -s y2bv.smt2 &>> out_y2bv.txt
echo "fin s8_a.cyclone.bv.smt2" >> out_y2bv.txt

echo "done s8_a.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv.smt2
cat s9_a.cyclone.bv.smt2 >> y2bv.smt2
yices-smt2 -t 7200 -s y2bv.smt2 &>> out_y2bv.txt
echo "fin s9_a.cyclone.bv.smt2" >> out_y2bv.txt

echo "done s9_a.cyclone.bv.smt2"
echo "(set-logic QF_BV)" > y2bv.smt2
cat s10_a.cyclone.bv.smt2 >> y2bv.smt2
yices-smt2 -t 7200 -s y2bv.smt2 &>> out_y2bv.txt
echo "fin s10_a.cyclone.bv.smt2" >> out_y2bv.txt

echo "done s10_a.cyclone.bv.smt2"