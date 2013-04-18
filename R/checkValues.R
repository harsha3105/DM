checkValues <-
function(names=NULL, values=NULL){ 
  if(!is.null(names) & !is.null(values)){
    if(length(names)!=length(values)){
      stop("There seems to be an error in the submission correctness test. Please contact the course creator.")
    }
    to.print = equal = NULL;
    for(i in 1:length(names)){
      if(is.na(values[i])){ equal[i] <- is.na(names[i]);          
      }else{  equal[i] <- names[i] == values[i] }
      
      if(!equal[i]){           
        to.print <- paste("Did you set the value of the variable",names[i]," equal to:", values[i],"? ")
      }
      
    }
    if(any(!equal)){ return( list(FALSE,to.print) ) }
  } 
}
