`?` <- function (e1, e2) 
{
  if (missing(e2)) {
    type <- NULL
    topicExpr <- substitute(e1)
  }
  else {
    type <- substitute(e1)
    topicExpr <- substitute(e2)
  }
  help(as.character(topicExpr))
}

help <- function (topic, package = NULL, lib.loc = NULL, verbose = getOption("verbose"), 
                  try.all.packages = getOption("help.try.all.packages"), help_type = getOption("help_type")) 
{
  types <- c("text", "html", "pdf")
  if (!missing(package)) {
  if (missing(topic)) {
    if (!missing(package)) {
      DM.help <<- list(package=package,FUN="00index")
      return()
    }
  }
  }
  ischar <- tryCatch(is.character(topic) && length(topic) == 
                       1L, error = identity)
  if (inherits(ischar, "error")) 
    ischar <- FALSE
  if (!ischar) {
    reserved <- c("TRUE", "FALSE", "NULL", "Inf", "NaN", 
                  "NA", "NA_integer_", "NA_real_", "NA_complex_", "NA_character_")
    stopic <- deparse(substitute(topic))
    if (!is.name(substitute(topic)) && !stopic %in% reserved) 
      stop("'topic' should be a name, length-one character vector or reserved word")
    topic <- stopic
  }
  help_type <- if (!length(help_type)){ "text"
  }else{ match.arg(tolower(help_type), types) }
  paths <-   utils:::index.search(topic, find.package(package, lib.loc, verbose = verbose))
  
  if( length(paths) == 0){ 
    DM.help <<- list(package="",FUN="")
    message(paste("No documentation for ‘",topic," ’ in specified packages and libraries: you could try ‘??",topic,"’. (But not yet on DataMind, since that's not implemented yet ;-).",sep=""))    
    }else{
    splitted.path  <- strsplit(paths,"/")
    L <- length( splitted.path[[1]] )    
    DM.help <<- list( package=splitted.path[[1]][L-2], FUN=splitted.path[[1]][L] )
    utils:::help(topic)
    return()
  }
}
