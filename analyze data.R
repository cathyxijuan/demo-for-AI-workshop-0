# Load required packages
library(lavaan)
library(xtable)

# Import RSES dataset
RSES <- read.csv("RSES.csv", fileEncoding = "UTF-8-BOM")

# View the first few rows
head(RSES)

# Check the structure of the data
str(RSES)

# Define one-factor CFA model
# All 10 RSES items load on a single latent factor
model <- '
  # One latent factor
  SelfEsteem =~ RSES_1 + RSES_2 + RSES_3 + RSES_4 + RSES_5 +
                RSES_6 + RSES_7 + RSES_8 + RSES_9 + RSES_10
'

# Fit the CFA model
fit <- cfa(model, data = RSES)

# Display model summary
summary(fit, fit.measures = TRUE, standardized = TRUE)

# Display parameter estimates
parameterEstimates(fit, standardized = TRUE)

# Display fit indices
fitMeasures(fit, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"))

# Loop through different RSES conditions
# Get unique conditions
conditions <- unique(RSES$RSES_condition)

# Initialize list to store fit results
fit_list <- list()

# Loop through each condition and fit the model
for (condition in conditions) {
  # Subset data for current condition
  data_subset <- RSES[RSES$RSES_condition == condition, ]

  # Fit the CFA model for this condition
  fit_list[[condition]] <- cfa(model, data = data_subset)
}

# Display results for each condition
for (condition in names(fit_list)) {
  cat("\n========================================\n")
  cat("Condition:", condition, "\n")
  cat("========================================\n")
  print(summary(fit_list[[condition]], fit.measures = TRUE, standardized = TRUE))
}

# Extract and display fit indices across conditions
fit_indices <- data.frame(
  Condition = character(),
  ChiSquare = numeric(),
  df = numeric(),
  pvalue = numeric(),
  RMSEA = numeric(),
  CFI = numeric(),
  stringsAsFactors = FALSE
)

for (condition in names(fit_list)) {
  fit_measures <- fitMeasures(fit_list[[condition]],
                               c("chisq", "df", "pvalue", "rmsea", "cfi"))
  fit_indices <- rbind(fit_indices,
                       data.frame(Condition = condition,
                                  ChiSquare = fit_measures["chisq"],
                                  df = fit_measures["df"],
                                  pvalue = fit_measures["pvalue"],
                                  RMSEA = fit_measures["rmsea"],
                                  CFI = fit_measures["cfi"]))
}

# Display fit indices table
cat("\n========================================\n")
cat("Fit Indices Across Conditions\n")
cat("========================================\n")
print(fit_indices, row.names = FALSE)

# Output LaTeX table for fit indices
cat("\n========================================\n")
cat("LaTeX Table for Fit Indices\n")
cat("========================================\n")
print(xtable(fit_indices, caption = "Fit Indices Across RSES Conditions",
             label = "tab:fit_indices",
             digits = c(0, 0, 2, 0, 4, 3, 3)),
      include.rownames = FALSE)

