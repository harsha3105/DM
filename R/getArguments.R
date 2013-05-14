getArguments = function(function.name, user.code=DM.user.code){
  my.regex <- paste( function.name, "\\(.*?\\)",sep="") # Make reg ex pattern
  where.is.regex <- regexpr(pattern=my.regex,text=user.code)  
  if( where.is.regex == (-1) ){ return(FALSE) } # No match for the reg ex 
  
  # Get all.arguments vector
  regex.start <- where.is.regex[1] + nchar(function.name)+1 #Start after functionname and bracket
  regex.end <- regex.start + attr(where.is.regex,"match.length")-nchar(function.name) -3
  all.arguments <- substr( user.code, regex.start, regex.end ) # Extract the part with the arguments

  # Get overview of the separate arguments: in matrix, rows are arguments, 
  # Vector with supplied arguments and the names of the vector is the name of the argument
  arguments <- strsplit(all.arguments,",")[[1]]
  official.arguments <- names(formals(function.name));
  arguments.vector <- names.vector <- c();

  for(i in 1:length(arguments)){
    split.argument = strsplit(arguments[i],"=")[[1]]
    if(length(split.argument)==1){ # Only the variable supplied, not attached to name
      arguments.vector[i] <- split.argument
      names.vector[i] <- official.arguments[i]
    } else if (length(split.argument)==2){ # Argument name used by student
      arguments.vector[i] <- split.argument[2]
      names.vector[i] <- split.argument[1]            
    }
  }
  names(arguments.vector) <- names.vector
  return(arguments.vector)
}