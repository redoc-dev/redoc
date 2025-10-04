# Various functions for bootstrapping testing
 
test_roundtrip <- function(test_rmd, dir = tempfile("redoc-artifacts")) {
     
  rmdname <- basename(tools::file_path_sans_ext(test_rmd))   
  rmdir <- file.path(dir, rmdname)
  ddir <- file.path(rmdir, "diffs")
  dir.create(ddir, recursive = TRUE, showWarnings = FALSE)
  trmd <- file.path(rmdir, basename(test_rmd))
  file.copy(test_rmd, trmd, overwrite = TRUE)
   
  rmarkdown::render(
      input = trmd,
      output_format = redoc(),
      output_dir = rmdir,
      intermediates_dir = rmdir,
      output_file = paste0(rmdname, ".docx"),
      quiet = TRUE,
      clean = FALSE
   )

   unzip(file.path(rmdir, paste0(rmdname, ".docx")),
      exdir = file.path(rmdir, "docx_unzipped")
   )

  roundtrip <- file.path(rmdir, paste0(rmdname, ".roundtrip.Rmd"))
  
  drmd <- diffobj::diffFile(test_rmd, roundtrip,
    mode = "sidebyside", context = "auto", format = "html",
    tar.banner = "Original", cur.banner = "Current",
    pager = list(file.path = tempfile(fileext = ".html"))
  )
   
  cat(as.character(drmd), file = file.path(ddir, "roundtrip-rmd.html"))

  orig_ast <- pandoc_ast(trmd)
  roundtrip_ast <- pandoc_ast(roundtrip)
  dast <- diffobj::diffObj(orig_ast, roundtrip_ast,
    mode = "sidebyside", pager = "on", format = "html",
    tar.banner = "Original", cur.banner = "Current"
  )
  cat(as.character(dast),
    file = file.path(ddir, "roundtrip-ast.html")
  )

  rmdir
}
