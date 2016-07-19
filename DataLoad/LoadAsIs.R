# ---- LoadAsIs ----
AsIsChulwar<-read.csv(paste0(DataLoad,"/ImportedAsIsDataChulwalar.csv"), header = FALSE,sep = ";")

# ---- AsIsLoadStructure ----
##Review Structure
str(AsIsChulwar)

##Review Head 30 Records
formattable(head(AsIsChulwar,30))

##Review Tail 30 Records
formattable(tail(AsIsChulwar,30))
