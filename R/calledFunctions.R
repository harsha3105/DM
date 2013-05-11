calledFunctions <- function( user.code, recursive = FALSE, checked.functions = NULL){
  
  # break code up into sections preceding left brackets:
  left.brackets <- c(unlist( strsplit(user.code, split="[[:space:]]*\\(")) )
  
  called.functions <- unique(c(unlist(sapply(left.brackets, 
                                             function (x) {
                                               
                                               # Split up according to anything that can't be in a function name.
                                               # split = not alphanumeric, not '_', and not '.'
                                               words <- c(unlist(strsplit(x, split="[^[:alnum:]_.]")))
                                               
                                               last.word <- tail(words, 1)
                                               last.word.is.function <- tryCatch(is.function(get(last.word)),
                                                                                 error=function(e) return(FALSE))
                                               return(last.word[last.word.is.function])
                                             }))))
  
  if (recursive){
    
    # checked.functions: We need to keep track of which functions 
    # we've checked to avoid infinite loops.
    functs.to.check <- called.functions[!(called.functions %in%
                                            checked.functions)]
    
    called.functions <- unique(c(called.functions,
                                 do.call(c, lapply(functs.to.check, function(x) {
                                   listFunctions(x, recursive = T,
                                                 checked.functions = c(checked.functions,          
                                                                       called.functions))
                                 }))))
  }
  return(called.functions)
}
