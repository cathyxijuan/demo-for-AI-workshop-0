# RSES Confirmatory Factor Analysis

This repository contains a Confirmatory Factor Analysis (CFA) of the Rosenberg Self-Esteem Scale (RSES) across different experimental conditions.

## Overview

The analysis examines how well a one-factor model of self-esteem fits the RSES data across six different conditions:
- RevisedU
- ItemSpecificL
- Expanded
- Original
- RevisedB
- ItemSpecificF

## Requirements

- R (version 4.0 or higher recommended)
- R packages:
  - `lavaan` - Structural equation modeling
  - `xtable` - LaTeX table generation

## Installation

Install the required R packages:

```r
install.packages("lavaan")
install.packages("xtable")
```

## Usage

Run the analysis script:

```bash
Rscript "analyze data.R"
```

## Output

The script produces:
1. Overall CFA model results for the complete dataset
2. Condition-specific CFA models with full summaries
3. A comparison table of fit indices (χ², RMSEA, CFI) across conditions
4. LaTeX table code for publication-ready formatting

## Data

**RSES.csv** contains:
- 10 RSES items (RSES_1 through RSES_10)
- Condition variable (RSES_condition)
- 1,909 observations across 6 experimental conditions

## Results Summary

The Expanded condition shows the best model fit (RMSEA = 0.081, CFI = 0.958), while the RevisedU condition shows the poorest fit (RMSEA = 0.152, CFI = 0.863).
