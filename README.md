## Proteomic risk score to predict ADRD in MDD (PrRS_MDD-ADRD)

## Preprint
Coming soon!

## Setup
Users are required to download and install R but no R package is needed to calculate the proteomic risk score to predict ADRD in MDD (PrRS_MDD-ADRD).

## Input file
The input file, as shown in "PrRS_mdd_adrd_example_data.csv", should have the first column designated as the ID column, with any arbitrary column name. This should be followed by columns containing the required proteins. The input file may include additional proteins beyond those needed, and the protein column names will be converted to lowercase.

## Example
The R code below shows you how to load the "PrRS" function in "PrRS_MDD-ADRD.R" to calculate PrRS_MDD-ADRDs for five subjects with input data in "PrRS_mdd_adrd_example_data.csv".
```
source("PrRS_MDD-ADRD.R")
PrRS_input=read.csv("PrRS_mdd_adrd_example_data.csv")
PrRS(PrRS_input)
```
