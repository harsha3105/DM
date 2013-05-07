checkList = function(name,value){
  check <- checkExistence(name)
  if(!is.null(check)){ return(check) }
  
  the.name  <- eval(parse(text=name));
  the.value <- eval(parse(text=value));
  
  # Check whether list has correct length: 
  if( length(the.name) != length(the.value) ){ 
    to.print <- paste("The list",name,"does not seem to have the correct lenght:",length(the.value))
    return(list(FALSE,to.print))
  }
  
  n <- length(the.value); equal <- NULL;
  
  for(i in 1:n){
    equal[i] <- checkEqual(the.name[[i]],the.value[[i]])
    if( !equal[i] ){  to.print <- capture.output( cat("Did you set the value of",names[[i]],"equal to:", values[[i]],"? ") ) }
  }
  
  if(any(!equal)){ return( list(FALSE,to.print) ) } else { return( TRUE ) }  
}