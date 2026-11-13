library(tidyverse)

data <- "../data/processed/"

dir.create("../results/", recursive = TRUE, showWarnings = FALSE)
dir.create("../results/models/", recursive = TRUE, showWarnings = FALSE)
pdf(
  "../results/plots/diagnostic_ols.pdf",
  width = 10,
  height = 8
)

data <- read_csv(
  file.path(data, "data_bersih.csv")
)

# choose the dependent and variable
y <- data$laju_pertumbuhan_penduduk_per_tahun
x1 <- data$log_kepadatan
x2 <- data$rasio_jenis_kelamin_penduduk


# Multiple OLS model
model <- lm(y ~ x1 + x2, data = data)

# Menyimpan model agar dapat digunakan di file lain
saveRDS(
  model,
  "../results/models/models_ols.rds"
)

# Kesimpulan
summary(model)
confint(model)

# Bonus: Ploting model
par(mfrow = c(2, 2))
plot(model)

dev.off()
