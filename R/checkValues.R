checkValues <- function(names=NULL, values=NULL,eval.names=FALSE){ 
  if(!is.null(names) & !is.null(values)){
    if(length(names)!=length(values)){
      stop("There seems to be an error in the submission correctness test. Please contact the course creator.")
    }
    to.print = equal = NULL;
    for(i in 1:length(names)){
      if(!eval.names){
        if( any(is.na(values[[i]])) ){ equal[i] <- any(is.na(get(names[i])));          
        }else{  equal[i] <- all(get(names[i]) == values[[i]]) }
        if(!equal[i]){
          to.print <- capture.output( cat("Did you set the value of the variable",names[i],"equal to:", values[[i]],"? ") );
        }  
      }
      if(eval.names){
        equal[i] <- all(eval(parse(text=names[i])) == values[[i]])
        if(!equal[i]){
          to.print <- capture.output( cat("Did you set the value of",names[i],"equal to:", values[[i]],"? ") );
        }          
      }  
    }
    if(any(!equal)){ return( list(FALSE,to.print) ) }
  } 
} 