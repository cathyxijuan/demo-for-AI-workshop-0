# R Analysis Script

# Load required package
library(lavaan)

# Import RSES data
rses_data <- read.csv("RSES.csv")

# Define one-factor CFA model
one_factor_model <- '
  # One latent factor
  SelfEsteem =~ RSES_1 + RSES_2 + RSES_3 + RSES_4 + RSES_5 +
                RSES_6 + RSES_7 + RSES_8 + RSES_9 + RSES_10
'

# Fit the CFA model
fit_one_factor <- cfa(one_factor_model, data = rses_data)

# Display model summary
summary(fit_one_factor, fit.measures = TRUE, standardized = TRUE)

# Loop through different RSES conditions and fit models
# Get unique conditions
conditions <- unique(rses_data$RSES_condition)

# Initialize list to store results
fit_by_condition <- list()

# Loop through each condition
for (condition in conditions) {
  # Subset data for current condition
  condition_data <- rses_data[rses_data$RSES_condition == condition, ]

  # Fit one-factor model for this condition
  fit_by_condition[[condition]] <- cfa(one_factor_model, data = condition_data)
}

# Display results for each condition
for (condition in names(fit_by_condition)) {
  cat("\n\n======================================\n")
  cat("Condition:", condition, "\n")
  cat("======================================\n")
  print(summary(fit_by_condition[[condition]], fit.measures = TRUE, standardized = TRUE))
}

# Extract and display fit indices across conditions
cat("\n\n======================================\n")
cat("Fit Indices Across Conditions\n")
cat("======================================\n\n")

# Create data frame to store fit indices
fit_indices <- data.frame(
  Condition = character(),
  ChiSquare = numeric(),
  df = numeric(),
  p_value = numeric(),
  RMSEA = numeric(),
  CFI = numeric(),
  stringsAsFactors = FALSE
)

# Extract fit indices for each condition
for (condition in names(fit_by_condition)) {
  fit_measures <- fitMeasures(fit_by_condition[[condition]])

  fit_indices <- rbind(fit_indices, data.frame(
    Condition = condition,
    ChiSquare = fit_measures["chisq"],
    df = fit_measures["df"],
    p_value = fit_measures["pvalue"],
    RMSEA = fit_measures["rmsea"],
    CFI = fit_measures["cfi"]
  ))
}

# Display the fit indices table
print(fit_indices, row.names = FALSE)
