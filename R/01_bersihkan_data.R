library(tidyverse)
library(janitor)

df <- read_csv("../data/raw/data.csv") |>
  clean_names()

# Cek baris
print(df$kabupaten_kota)

glimpse(df)

# Ternyata ada baris total di akhir, keputisan di buang
df <- df |>
  filter(!str_detect(str_to_lower(kabupaten_kota), "^lampung$"))


# Masalah umum
colSums(is.na(df))
sum(duplicated(df$kabupaten_kota))
summary(df)

# Susun dataset akhir (sesuaikan nama kolom dengan hasil glimps)
df_bersih <- df |>
  drop_na() |>
  mutate(log_kepadatan = log(kepadatan_penduduk_per_km_persegi_km2))

print(df_bersih$kabupaten_kota)


write_csv(df_bersih, "../data/processed/data_bersih.csv")
