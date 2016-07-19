# ---- LoadPlan ----
CWplan <- read.csv(paste0(DataLoad, "/ImportedPlanDataChulwalar.csv"), header = FALSE, sep = ";")

# ---- PlanStructure ----
##Review Structure
str(CWplan)

##Review first 30 rows
formattable(head(CWplan, 30))

##Review last 30 rows
formattable(tail(CWplan, 30))
