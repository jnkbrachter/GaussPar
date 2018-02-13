GET_REAL_TIME_OF_FUNCTION_CALL := function ( method, args, options... )
  local first_time, firstSeconds,
    firstMicroSeconds, result, second_time, secondSeconds,
  secondMicroSeconds, total, seconds, microSeconds;

  if options = [] then
    options := rec();
  else
    options := options[1];
  fi;
  if not IsBound( options.passResult ) then
    options.passResult := false;
  fi;

  first_time := IO_gettimeofday(  );
  firstSeconds := first_time.tv_sec;
  firstMicroSeconds := first_time.tv_usec;

  result := CallFuncList( method, args );

  second_time := IO_gettimeofday(  );
  secondSeconds := second_time.tv_sec;
  secondMicroSeconds := second_time.tv_usec;

  seconds := (secondSeconds - firstSeconds);
  microSeconds := secondMicroSeconds - firstMicroSeconds;
  total := seconds * 10^6 + microSeconds;
  return rec( result := result, time := total );
end;
