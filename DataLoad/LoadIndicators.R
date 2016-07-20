# ---- LoadIndicators ----
ImportedIndicators <-read.csv(paste0(DataLoad,"/ImportedIndicatorsChulwalar.csv"), header = FALSE,sep = ";")

# ---- IndicatorsStructure ----
##Review Structure
str(ImportedIndicators)

##Review Head 30 Records
formattable(head(ImportedIndicators,30))

##Review Tail 30 Records
formattable(tail(ImportedIndicators,30))
