closedTest <- function( names=NULL, values=NULL, messages=NULL, check.existence=NULL){
  if(is.null(check.existence)){ check.existence = rep(TRUE,length(names)) }
  
  # Do the variables to check exist in user workspace?
  check <- checkExistence(names[check.existence])
  
  if(!is.null(check)){ return(check) }
  
  if(!is.null(names) & !is.null(values)){   # Check wheter arguments were supplied
    if( length(names) != length(values) ){ 
      stop("There seems to be an error in the submission correctness test. Please contact the course creator.")
    } 
    
    to.print   <- equal <- NULL; 
    the.names  <- lapply( names,  function(zzzzA){ eval(parse(text=zzzzA))} )
    the.values <- lapply( values, function(zzzzA){ eval(parse(text=zzzzA))} )
    n          <- length(names)

    for(i in 1:n){ 
      the.value <- the.values[[i]]
      the.name  <- the.names[[i]]
      equal[i]  <- checkEqual(the.name,the.value)
      
      # Print message:
      if( !equal[i] ){  
        to.print <- capture.output( cat("Did you set the value of",names[[i]],"equal to:", values[[i]],"? ") ) 
      }
      
      }
    if(any(!equal)){ return( list(FALSE,to.print) ) } 
  }
  return(TRUE)
}