
test_rmds <- c(
  redoc_example_rmd(),
  list.files(test_path("test_rmds"), "\\.Rmd$", full.names = TRUE)
)




for(rmd in test_rmds) {

  rmdir <- test_roundtrip(rmd, artifacts_dir)

  test_that(paste0("Rendering succeeds:", basename(rmd)), {
    outdoc <- file.path(rmdir, paste0(basename(tools::file_path_sans_ext(rmd)), ".docx"))
    expect_true(file.exists(outdoc))
  })

  test_that(paste0("All embedded files match:", basename(rmd)), {
  to_embed <- sort(list.files(rmdir, "(md|yml)$", include.dirs = FALSE, full.names = TRUE))
  embedded <- sort(list.files(
     file.path(rmdir, "docx_unzipped", "redoc"),
     "(md|yml)$",
     include.dirs = FALSE, full.names = TRUE
   ))
   expect_identical(basename(embedded), basename(to_embed))
   for (i in seq_along(embedded)) {
     expect_identical(
       readLines(embedded[i], warn = FALSE),
       readLines(to_embed[i], warn = FALSE)
     )
  }
})

  test_that(paste0("R Markdown is preserved in the roundtrip:", basename(rmd)), {
    roundtrip <- file.path(rmdir, paste0(basename(tools::file_path_sans_ext(rmd)), ".roundtrip.Rmd"))
    lines_comparison <- waldo::compare(
      readLines(rmd, warn = FALSE),
      readLines(roundtrip, warn = FALSE),
      max_diffs = 3
    )
    ast_comparison <- waldo::compare(
      pandoc_ast(rmd),
      pandoc_ast(roundtrip),
      max_diffs = 3)
  # Function to truncate output to first few lines
  truncate_comparison <- function(comparison, max_lines = 10) {
    if (length(comparison) == 0) return("")

    # Capture the output when printing the comparison
    captured <- capture.output(cat(comparison, sep = "\n"))

    # Take only the first few lines
    if (length(captured) > max_lines) {
      truncated <- c(head(captured, max_lines), paste("... [", length(captured) - max_lines, "more lines truncated]"))
    } else {
      truncated <- captured
    }

    paste(truncated, collapse = "\n")
  }

  expect(length(lines_comparison) == 0,
         failure_message = truncate_comparison(lines_comparison, max_lines = 8))
  expect(length(ast_comparison) == 0,
         failure_message = truncate_comparison(ast_comparison, max_lines = 8))
  })

  }

if (nzchar(Sys.getenv("REDOC_ARTIFACTS_DIR"))) {
  dir.create(dirname(Sys.getenv("REDOC_ARTIFACTS_DIR")), recursive = TRUE, showWarnings = FALSE)
  file.rename(artifacts_dir, Sys.getenv("REDOC_ARTIFACTS_DIR"))
}
