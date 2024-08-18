# PrRS_MDD-ADRD: This function is used to calculate the proteomic risk score (PrRS) for Alzheimer's disease
# and related dementias (ADRD) for individuals with a history of major depressive disorder (MDD)

PrRS <- function(data){
  
  shape=0.119105449135298 # shape from the Gompertz model with 19 proteins selected by a LASSO Cox regression model for ADRD   
  rate=0.000666895340593535 # rate from the Gompertz model with 19 proteins selected by a LASSO Cox regression model for ADRD
  
  # 19 proteins to calculate PrRS_MDD-ADRD
  predictors=c("adgrg1", "apoe", "bcan", "c1qtnf6", "egfr",
               "eln", "gdf15", "get3", "gfap", "havcr1",
               "hpgds", "kit", "nefl", "nppb", "nptxr",
               "ntprobnp", "psg1", "serpini1","vgf")  
  
  # Gompertz coefficients associated with age and 19 proteins in "predictors"
  betas=c(0.059036197, -0.603036756, -0.079613412, -0.700590385, 0.033301588,
          0.572332965, 0.19523052, -0.468906433, 0.785975076, 0.23689573,
          -0.473589248, -0.538931921, 0.653088577, 0.10399516, -0.806494892,
          -0.013467792, 0.185405824, -0.83906618, -1.106027299)
          
  colnames(data) <- tolower(colnames(data)) # convert column names of the data to lowercase
  data <- data[,which(colnames(data)%in%predictors)] # keep predictors only in the data
  if(sum(!predictors%in%colnames(data))==0){
  
  # match the variable names in "predictors" and the input data
  betas=betas[match(colnames(data), predictors)]
  
  # b(x)=b*exp(x*beta)
  b_x <- as.matrix(data)%*%as.matrix(betas)
  rate_new <- rate*exp(b_x)
  
  # 10-year ADRD risk 
  cdf_10_year=1-exp(-(rate_new/shape)*(exp(shape*10)-1))
  
  # PrRS_MDD-ADRD
  rs=cdf_10_year
  colnames(rs) <- "PrRS_MDD-ADRD"
  return(rs)
  }else{  
    cat("Missing predictors:\n",predictors[which(!predictors%in%colnames(data))])
  }
}
