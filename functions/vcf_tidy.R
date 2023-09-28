if (!require("pacman",quietly = TRUE)) {
  install.packages("pacman")
}
pacman::p_load(readr, vcfR)

# Define a function to display usage instructions
print_usage <- function() {
  cat("Usage: Rscript vcf_tidy.R <input_file>\n")
  cat("  <input_file>: Path to the input VCF file\n")
  cat("\n\n")
  cat("output will be three different txt files:\n")
  cat("> metadata.txt\n")
  cat("> quality.txt\n")
  cat("> genotyping.txt\n")
  cat("\n\n")
}

# Define a function to read VCF and write metadata, quality, and genotyping files
process_vcf <- function(input_file) {
  VCF <- vcfR::read.vcfR(file = input_file)
  tidy <- vcfR::vcfR2tidy(VCF)
  readr::write_delim(tidy$meta, file = "metadata.txt", delim = "\t")
  readr::write_delim(tidy$fix, file = "quality.txt", delim = "\t")
  readr::write_delim(tidy$gt, file = "genotyping.txt", delim = "\t")
}

# Check for the number of command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check if the help option is provided
if ("--help" %in% args || "-h" %in% args) {
  print_usage()
  quit(status = 0)
}

# Check if the correct number of arguments is provided
if (length(args) != 1) {
  cat("Error: Incorrect number of arguments.\n")
  print_usage()
  quit(status = 1)
}

# Get the input file from command-line arguments
input_file <- args[1]

# Call the process_vcf function with the specified input file
process_vcf(input_file)
