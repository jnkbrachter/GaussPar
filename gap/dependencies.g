# This file contains the help functions that manage the parallelization of the
# algorithm. In particular, the functions in this file manage the dependencies
# of the algorithm's subprograms between each other.

# This function is temporary until it is not necessary anymore to find
# a number of blocks that divides the width or height.
# When different chop sizes are possible, we will presumably find the perfect
# chop size and divide in blocks of this size.
GAUSS_calculateBlocks := function( a )
    # a is either height or width of the matrix
    local i;
    i := 13;

    while (i > 1) do
        if (a mod i = 0) then
            return a/i;
        fi;
        i := i - 1;
    od;

    return 1;
end;

# Function in step 1
GAUSS_ClearDownDependencies := function( i, j, TaskListClearDown, TaskListUpdateR )
    local list; 
    list := [RunTask( function() return []; end )];
    if not (i = 1) then
        Add(list, TaskListClearDown[i-1][j]);
    fi;
    if not (j = 1) then
        Add(list, TaskListUpdateR[i][j-1][j]);
    fi;

    return list; 
end;

GAUSS_ExtendDependencies := function(i, j, TaskListClearDown, TaskListE )
    local list;
    if (j = 1) then
        list := [ TaskListClearDown[i][j] ];
    else
        list := [ TaskListClearDown[i][j], TaskListE[i][j-1] ];
    fi;

    return list;
end;

GAUSS_UpdateRowDependencies := function(i, j, k, TaskListClearDown, TaskListUpdateR )
    local list;
    list := [ TaskListClearDown[i][j] ];
    if not (j = 1) then
        Add(list, TaskListUpdateR[i][j-1][k]);
    fi;
    if not (i = 1) then
        Add(list, TaskListUpdateR[i-1][j][k]);
    fi;

    return  list;
end;

GAUSS_UpdateRowTrafoDependencies := function(i, j, k, TaskListClearDown, TaskListE, TaskListUpdateM )
    local list;
    Info(InfoGauss, 4, "Start UpdateRowTrafoParameters", i, " ", j, " ", k);
    list := [ TaskListClearDown[i][j], TaskListE[k][j] ];
    if not (i = 1) then
        Add(list, TaskListUpdateM[i-1][j][k]);
    fi;
    if not (j = 1) then
        Add(list, TaskListUpdateM[i][j-1][k]);
    fi;

    return list; 
end;
