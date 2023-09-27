# plots -------------------------------------------------------------------

vcf %>%
  mutate(
    across(
      all_of(as.character(1:8)),
      vcf_gt)
  ) %>%
  select(all_of(as.character(1:8))) %>%
  pivot_longer(cols = everything(),names_to = "Sample",
               values_to = "Genotype") %>%
  pull(Genotype) %>%
  unique()
