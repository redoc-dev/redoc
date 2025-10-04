source(test_path("fixtures", "roundtrip.R"))
dir.create(artifacts_dir <- tempfile("redoc-artifacts", tmpdir = dirname(tempdir())), recursive = TRUE)
cli::cli_text("Run {.run {paste0('xopen::xopen(\"', artifacts_dir, '\")')}} to open the artifacts directory.")

