checkExpressions <- function( names=NULL, expressions=NULL, eval.names=FALSE ){ 
  if(!is.null(names) & !is.null(expressions)){ 
    if(length(names)!=length(expressions)){ 
      stop("There seems to be an error in the submission correctness test. Please contact the course creator.")
    }
    
    to.print = equal = NULL;    
    for(i in 1:length(names)){
      the.value <- eval(parse(text=expressions[i]));
      if(any(is.na(the.value))){
        to.print <- paste("Contact the course creator. The expression in the Submission Correctness Test evalutes to NA")
        return( list(FALSE,to.print) )
      }else{
        if(!eval.names){ the.name <- get(names[i]) }
        if( eval.names){ the.name <- eval(parse(text=names[i])) }
        
        equal[i] <- all( the.name == the.value );
        if(!equal[i]){ to.print <- paste("Did you assign the expression:", expressions[i],"to the variable:", names[i],"?")  }
      } 
    } 
    if(any(!equal)){ return( list(FALSE,to.print) ) }
  } 
} 