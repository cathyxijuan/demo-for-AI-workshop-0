# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains a Confirmatory Factor Analysis (CFA) study of the Rosenberg Self-Esteem Scale (RSES) using R. The analysis examines how a one-factor model of self-esteem fits across different experimental conditions.

## Running the Analysis

```bash
Rscript "analyze data.R"
```

## Required R Packages

- `lavaan` - For CFA model fitting and structural equation modeling
- `xtable` - For generating LaTeX tables

## Data Structure

- **RSES.csv**: Contains 10 RSES items (RSES_1 through RSES_10) and a condition variable (RSES_condition)
- The CSV file uses UTF-8 BOM encoding, which must be specified when reading: `read.csv("RSES.csv", fileEncoding = "UTF-8-BOM")`

## Code Architecture

The analysis script follows this workflow:

1. **Data import and exploration**: Loads RSES.csv and displays structure
2. **Overall model fitting**: Fits a one-factor CFA model to the entire dataset where all 10 RSES items load on a single latent factor called "SelfEsteem"
3. **Condition-specific analysis**: Loops through each unique RSES_condition value, subsets the data, and fits the same one-factor model to each condition separately
4. **Results storage**: All fitted models are stored in `fit_list`, a named list where each element corresponds to a condition
5. **Fit indices extraction**: Extracts chi-square, df, p-value, RMSEA, and CFI for each condition and compiles them into a data frame
6. **LaTeX output**: Generates a publication-ready LaTeX table of fit indices

## Important Conventions

- **Library declarations**: ALWAYS place ALL `library()` calls at the very top of the R script, before any other code. This is a strict requirement - never add library calls in the middle of the code.
- **Model specification**: The lavaan syntax uses `=~` to specify factor loadings (e.g., `SelfEsteem =~ RSES_1 + RSES_2 + ...`)
- **Fit object access**: Individual condition models can be accessed via `fit_list[["ConditionName"]]`
