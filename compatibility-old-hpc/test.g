Read("compatibility-old-hpc/read.g");
Read("tst/testfunctions.g");

success := true;
success := success
    and GAUSS_BasicTestEchelonMatTransformationBlockwise(180, 6, 6, 5, true);
success := success
    and GAUSS_BasicTestEchelonMatTransformationBlockwise(180, 6, 6, 5, false);

if not success then
    FORCE_QUIT_GAP(1);
fi;
QUIT_GAP(0);
