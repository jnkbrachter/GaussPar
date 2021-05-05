# We can trust the older versions of HPC-GAP to correctly place guards. Thus we
# use the old version to test whether we place objects in the right regions.
# We do not support the timing functions with older HPC-GAP versions.

# Things that are missing in older versions
IsHPCGAP := true;
MakeReadOnlyObj(MakeImmutable(IsHPCGAP));
NrRows := x -> DimensionsMat(x)[1];
NrCols := x -> DimensionsMat(x)[2];
InstallOtherMethod(ExtractSubMatrix, "fallback for a plist and two lists",
  [ IsPlistMatrixRep, IsList, IsList ],
function( m, p, q )
    return m{p}{q};
end);

# Content from init.g
DeclareInfoClass("InfoGauss");
SetInfoLevel(InfoGauss, 1);
Read("gap/main.gd");

# Content from read.g
# The gauss pkg doesn't work under old versions of HPCGAP. But we can take
# the functions we need from the following files we copied.
Read("compatibility-old-hpc/gauss-upwards.gd");
Read("compatibility-old-hpc/gauss-upwards.gi");

Read("gap/RREF.g");
Read("gap/dependencies.g");
Read("gap/thread-local.g");
Read("gap/utils.g");
Read("gap/tasks.g");

Read("gap/main.gi");
Read("gap/echelon-form.g");

# HACK
# We need to overwrite MakeReadOnlyOrImmutableObj
if IsHPCGAP then
     # In older hpcgap
     #      MakeReadOnly is recursive
     #      MakeReadOnlyObj is not recursive
     # In current hpcgap
     #      MakeReadOnlyObj is recursive
     #      MakeReadOnlySingleObj is not recursive
     MakeReadOnlyOrImmutableObj := MakeReadOnly;
else
     MakeReadOnlyOrImmutableObj := MakeImmutable;
fi;
