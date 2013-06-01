# # Inspiration from the knitR inventor blogger: http://yihui.name/en/2012/10/build-static-html-help/
# setwd("~/Dropbox/DataMind/website/playground/")
# ## From Hadley: http://hadley.github.io/staticdocs/
# library("tools");library("testthat");library("evaluate");library("whisker");library("highlight");library("highlight");library("devtools");
# #install_github("staticdocs","hadley"); # DOES NOT WORK AT ALL!
# #library("staticdocs");library("R2HTML")
# 
# # Dirty code, use at your own risk!
# ########### START HELP FUNCTIONS ########### 
# all_help_functions = function(pkg){
#   links = tools::findHTMLlinks()
#   pkgRdDB = tools:::fetchRdDB(file.path(find.package(pkg), 'help', pkg))
#   force(links); topics = names(pkgRdDB)
#   spec_dest_path = paste(dest_path,"/",pkg,"/html/",sep="")
#   dir.create( paste(dest_path,"/",pkg,sep=""), showWarnings = FALSE);
#   dir.create( spec_dest_path, showWarnings = FALSE);  
#   setwd(spec_dest_path);
#   for (p in topics){
#     tools::Rd2HTML(pkgRdDB[[p]], paste(p, 'html', sep = '.'),
#                    package = pkg, Links = links, no_links = is.null(links))
#   }
# }
# 
# grab_package_index = function(pkg){
#   file.name = paste( find.package(pkg),"/html/00index.html",sep="")
#   it.does.exist = file.exists( file.name )
#   if(it.does.exist){ 
#     file.copy(from=file.name,to="00Index.html" )
#   }else{ warning(paste("No index found for package",pkg))}
# }
# 
# grab_description_file = function(pkg,dest_path){
#   file.name = paste( find.package(pkg),"/DESCRIPTION",sep="")
#   it.does.exist = file.exists( file.name )
#   if(it.does.exist){ 
#     file.copy(from=file.name,to=paste(dest_path,"/",pkg,"/DESCRIPTION",sep="") )
#   }else{ warning(paste("No DESCRIPTION found for package",pkg))}
# }
# 
# grab_vignettes = function(pkg,dest_path,lib_path){
#   dest.dir <- paste( dest_path,"/",pkg,"/doc/",sep="")
#   path <- as.package(find.package(pkg))$path; 
#   src.dir  <- paste( path,"/doc/",sep="" )   
#   dir.create(dest.dir)
#   buildVignettes(dir = path, tangle = TRUE) #Build package vignettes to be sure they are there
#   file.names <- dir(src.dir)
#   sapply( file.names, function(x) { file.copy( from=paste(src.dir, x, sep=''),
#                                                to=paste(dest.dir, x, sep=''), overwrite = FALSE) })
#   dir.create( paste(lib_path,"/",pkg,sep=''))
#   dir.create( paste(lib_path,"/",pkg,"/doc",sep=''))
#   sapply( file.names, function(x) { file.copy( from=paste(src.dir, x, sep=''), 
#                                                to=paste(lib_path,"/",pkg,"/doc/",x,sep=''), overwrite = FALSE) })
# }
# 
# grab_news_file = function(pkg,dest_path){
#   file.name = paste( find.package(pkg),"/NEWS",sep="")
#   it.does.exist = file.exists( file.name )
#   if(it.does.exist){ 
#     file.copy(from=file.name,to=paste(dest_path,"/",pkg,"/NEWS",sep="") )
#   }else{ warning(paste("No DESCRIPTION found for package",pkg))}
# }
# 
# copy_htmls = function(pkg,dest_path, lib_path){
#   dir.create( paste(lib_path,"/",pkg,sep=''))
#   dest.dir <- paste(lib_path,"/",pkg,"/html/",sep='')
#   dir.create( dest.dir )
#   src.dir <- paste(dest_path,"/",pkg,"/html/",sep="")
#   file.names <- list.files( src.dir )
#   sapply( file.names, function(x) { file.copy( from=paste(src.dir, x, sep=''), 
#                                                to=paste( dest.dir,x,sep=''), overwrite = TRUE) })
# }
# 
# grab_demo_files = function(pkg,dest_path){ 
#   dest.dir <- paste( dest_path,"/",pkg,"/demo/",sep="")
#   path <- as.package(find.package(pkg))$path; 
#   src.dir  <- paste( path,"/demo/",sep="");   
#   dir.create(dest.dir); 
#   file.names <- dir(src.dir)
#   sapply( file.names, function(x) { file.copy( from=paste(src.dir, x, sep=''),
#                                                to=paste(dest.dir, x, sep=''), overwrite = FALSE) })
# }
# 
# static_help = function(pkg,dest_path,lib_path){
#   # 1. Generate help file for all functions in a package:
#   all_help_functions(pkg)
#   
#   # 2. Generate help file for the index:
#   # Just grab the index file: apparently, it always (???) exists
#   grab_package_index(pkg)
#   
#   # 3. Generate help file for the description
#   grab_description_file(pkg,dest_path) 
#   
#   # 4. Generate and grab the vignettes & other extra info/...  
#   grab_vignettes(pkg=pkg,dest_path=dest_path,lib_path=lib_path)
#   
#   # 5. Move news file in case present: 
#   grab_news_file(pkg,dest_path)
#   
#   # 6. Move the demo files (see e.g. base package)
#   grab_demo_files(pkg,dest_path)
#   # TODO ADD HERE INDEX FILE FOR THE DEMO'S SO THEY BECOME FINDABLE, LINKS REFER TO DEMO FOLDER, SO CALL FILE INDEX
#   # start="<li><a href..."qa
#   # HTML(x, file=paste(lib_path,"/",pkg,"/demo/index.html",sep="")) 
#   
#   # 7. Copy HTML folder also to lib - god knows why links in general R refer here-to
#   copy_htmls(pkg,dest_path, lib_path) 
# }
# 
# ######### TRY IT OUT ######### 
# dest_path = "~/Dropbox/DataMind/website/playground/package_htmls" 
# lib_path  = "~/Dropbox/DataMind/website/playground/library" 
# dir.create(lib_path); dir.create(dest_path); 
# # For 1 package: 
# static_help( pkg="stats", dest_path, lib_path ); 
# static_help( pkg="utils", dest_path, lib_path ); 
# 
# # For multiple packages: (default uses all packages that are installed)
# static_help_all = function(packages=.packages(TRUE),dest_path, lib_path){
#   force(packages)
#   for(p in packages){
#     message('* Making static html help pages for ', p)
#     static_help(p, dest_path, lib_path)
#   } 
# }
# 
# ###########################################
# # 1. Try out for multiple packages: 
# dest_path = "~/Dropbox/DataMind/website/playground/package_htmls" 
# lib_path  = "~/Dropbox/DataMind/website/playground/library" 
# dir.create(dest_path);dir.create(lib_path) 
# static_help_all( dest_path=dest_path, lib_path=lib_path ) 
# 
# # 2. COPY THE MAIN R help files and manuals folder: 
# copy_all_files = function( src.folder, dest.folder ){
#   dir.create(dest.folder) 
#   all.files = .packages(TRUE);#list.files(src.folder);
#   src.paths <- paste(src.folder,all.files,sep="") 
#   dest.paths <- paste(dest.folder,all.files,sep="") 
#   for(i in 1:length(all.files)){
#     file.copy( from = src.paths[i], to = dest.paths[i], overwrite = TRUE) 
#   }
# }
# 
#  src.folder <- "/Library/Frameworks/R.framework/Versions/3.0/Resources/" 
#  dest.folder <- "~/Dropbox/DataMind/website/playground/doc/" 
#  copy_all_files(src.folder, dest.folder)
#  src.folder <- "/Library/Frameworks/R.framework/Versions/3.0/Resources/doc/html/" 
#  dest.folder <- "~/Dropbox/DataMind/website/playground/doc/html/" 
#  copy_all_files(src.folder, dest.folder)
#  src.folder <- "/Library/Frameworks/R.framework/Versions/3.0/Resources/doc/manual/" 
#  dest.folder <- "~/Dropbox/DataMind/website/playground/doc/manual/" 
#  copy_all_files(src.folder, dest.folder)
# 
#  # Put correct CSS file for main help-files: 
#  dest.file <- "~/Dropbox/DataMind/website/playground/doc/html/R.css"
#  src.css.path = "~/Dropbox/DataMind/website/playground/R.css"
#  file.copy( from=src.css.path, to=dest.file, overwrite=TRUE)
# 
# # Put the css files in the right place: NEW LAYOUT
#  src.css.path = "~/Dropbox/DataMind/website/playground/R.css"
#  paths = list.files("~/Dropbox/DataMind/website/playground/package_htmls")
#  dest.paths = paste("~/Dropbox/DataMind/website/playground/package_htmls/",paths,"/html/R.css",sep="")
#  sapply(dest.paths, function(x){ file.copy( from = src.css.path, to =x, overwrite = TRUE) } )  
#  paths = list.files("~/Dropbox/DataMind/website/playground/library")
#  dest.paths = paste("~/Dropbox/DataMind/website/playground/library/",paths,"/html/R.css",sep="")
#  sapply(dest.paths, function(x){ file.copy( from = src.css.path, to =x, overwrite = TRUE) } )  
#  dest.paths = paste("~/Dropbox/DataMind/website/playground/library/",paths,"/doc/R.css",sep="")
#  sapply(dest.paths, function(x){ file.copy( from = src.css.path, to =x, overwrite = TRUE) } )  
#  dest.paths = paste("~/Dropbox/DataMind/website/playground/package_htmls/",paths,"/doc/R.css",sep="")
#  sapply(dest.paths, function(x){ file.copy( from = src.css.path, to =x, overwrite = TRUE) } )  
