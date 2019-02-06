n := 180;; q := 5;;
n := 60;; q := 5;;
A := RandomMat(n, n, GF(q));;
numberBlocksHeight := 3;; 
numberBlocksWidth := 3;; 
SetInfoLevel(InfoGauss, 2);
Read("tst/testfunctions.g");
Read("tst/testdata/matrices.g");
#GAUSS_BasicTestEchelonMatTransformationBlockwise(100, 10, 10, 11, true);
#result := DoEchelonMatTransformationBlockwise(A, rec( galoisField := GF(q), IsHPC := true, numberBlocksHeight := numberBlocksHeight, numberBlocksWidth := numberBlocksWidth ));;