library(tidyverse)

#import and filter
vcf <- readr::read_delim(file = "data/filtrado.vcf",
                         comment = "##")
vcf <- vcf %>% rename("CHROM" = `#CHROM`)


tidyselect::all_of(as.character(1:8))

select(vcf, all_of(as.character(1:8)))





vcf %>%
  mutate(
  across(all_of(as.character(1:8)),
         fn_zBz,
         .names = "sample_{.col}0/1")) %>%
  select(starts_with('sample_'))

vcf %>%
  mutate(
    across(
      all_of(as.character(1:8)),
      vcf_gt)
    )

str_split_i(vcf$`1`,pattern = ":",1)
