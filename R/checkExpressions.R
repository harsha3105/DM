checkExpressions <-
function( names=NULL, expressions=NULL ){ 
  if(!is.null(names) & !is.null(expressions)){ 
    if(length(names)!=length(expressions)){ 
      stop("There seems to be an error in the submission correctness test. Please contact the course creator.")
    }
    to.print = equal = NULL;
    for(i in 1:length(names)){
      equal[i] <- get(names[i]) == eval(parse(text=expressions[i]));
      if(!equal[i]){ to.print <- paste("Did you assign the expression:", expressions[i],"to the variable:", names[i],"?")  }
    }
    if(any(!equal)){ return( list(FALSE,to.print) ) }
  } 
}
