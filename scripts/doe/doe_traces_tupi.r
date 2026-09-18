library(tidyverse)

n <- 40000
b <- 1000

design <- tribble(
  ~precision, ~algorithm,     ~n, ~b, ~runtime, ~scheduler, ~rep,
  "FP64",     "potrf",        n,  b,  "starpu", "dmda",     1,
  "FP64",     "potrf",        n,  b,  "starpu", "dmdas",    1,
  "FP64",     "potrf",        n,  b,  "parsec", "gd",       1,
  "FP64",     "potrf",        n,  b,  "parsec", "lfq",      1,
  "FP64",     "getrf_nopiv",  n,  b,  "starpu", "dmda",     1,
  "FP64",     "getrf_nopiv",  n,  b,  "starpu", "dmdas",    1,
  "FP64",     "getrf_nopiv",  n,  b,  "parsec", "gd",       1,
  "FP64",     "getrf_nopiv",  n,  b,  "parsec", "lfq",      1,
)

out_dir <- "doe"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
write_csv(design, file.path(out_dir, "doe_traces_tupi.csv"), progress = FALSE)
