# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains a Confirmatory Factor Analysis (CFA) study of the Rosenberg Self-Esteem Scale (RSES) using R. The analysis examines how a one-factor model of self-esteem fits across different experimental conditions.

## Running the Analysis

```bash
Rscript analyze.R
```

## Required R Packages

- `lavaan` - For CFA model fitting and structural equation modeling

## Data Structure

- **RSES.csv**: Contains 10 RSES items (RSES_1 through RSES_10) and a condition variable (RSES_condition) with 6 experimental conditions: RevisedU, ItemSpecificL, Expanded, Original, RevisedB, ItemSpecificF
- CSV encoding: The file may use UTF-8 BOM encoding. If you encounter encoding issues when reading, specify: `read.csv("RSES.csv", fileEncoding = "UTF-8-BOM")`

## Code Architecture

The analyze.R script follows this workflow:

1. **Data import**: Loads RSES.csv into `rses_data`
2. **Model specification**: Defines a one-factor CFA model where all 10 RSES items load on a single latent factor called "SelfEsteem"
3. **Overall model fitting**: Fits the CFA model to the entire dataset
4. **Condition-specific analysis**: Loops through each unique RSES_condition value, subsets the data, and fits the same one-factor model to each condition separately
5. **Results storage**: All fitted models are stored in `fit_by_condition`, a named list where each element corresponds to a condition
6. **Fit indices extraction**: Extracts chi-square, df, p-value, RMSEA, and CFI for each condition and compiles them into a `fit_indices` data frame for easy comparison

## Important Conventions

- **Library declarations**: ALWAYS place ALL `library()` calls at the very top of the R script, before any other code
- **Model specification**: The lavaan syntax uses `=~` to specify factor loadings (e.g., `SelfEsteem =~ RSES_1 + RSES_2 + ...`)
- **Fit object access**: Individual condition models can be accessed via `fit_by_condition[["ConditionName"]]`
