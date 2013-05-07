checkEqual = function(the.name,the.value){
  NAS       <-  any(is.na(the.value))   |  any(is.na(the.name))
  NULLS     <-  any(is.null(the.value)) |  any(is.null(the.name))
  
  if(NAS){ #TODO: make NA handling better
    equal <- any(is.na(the.value)) &  any(is.na(the.name))  
  } else if(NULLS){  #TODO make NULL handling better   
    equal <- any(is.null(the.value)) &  any(is.null(the.name))
  }else{ equal <- all(the.name == the.value) }
  
  return(equal)
}