library(boot)
library(tidyverse)

data <- "../data/processed/"
model <- "../results/models/models_ols.rds"

data <- read_csv(
  file.path(data, "data_bersih.csv"),
  show_col_types = FALSE
)

model <- readRDS(model)
koef_model <- coef(model)

model <- lm(
  laju_pertumbuhan_penduduk_per_tahun ~
    log_kepadatan +
    rasio_jenis_kelamin_penduduk,
  data = data
)
statistic <- function(data, indicies) {
  # Resampling observasi
  d <- data[indicies, ]

  # Estimasi model OLS
  model_boot <- lm(
    formula(model),
    data = d
  )
  # Mengambil koefesien
  coef(model_boot)
}

y <- data$laju_pertumbuhan_penduduk_per_tahun
x1 <- data$log_kepadatan
x2 <- data$rasio_jenis_kelamin_penduduk



set.seed(42)


hasil_boot <- boot(
  data = data,
  statistic = statistic,
  R = 1000
)
print(hasil_boot$t0)

# Intercept
boot.ci(hasil_boot, type = "perc", index = 1)

# Log kepadatan
boot.ci(hasil_boot, type = "perc", index = 2)

# Rasio jenis kelamin
boot.ci(hasil_boot, type = "perc", index = 3)
