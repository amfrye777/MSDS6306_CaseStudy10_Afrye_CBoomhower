# ---- ExecAllSmooth ----

  # Simple Exponential Smoothing
Model_ses <- ses(EfakAsIs, h=12)

  # Holt's Linear Trend
Model_holt_1 <- holt(EfakAsIs,h=12)

  # Holt's Exponential Trend
Model_holt_2<- holt(EfakAsIs, exponential=TRUE,h=12)

  # Holt's Damped Linear Trend
Model_holt_3 <- holt(EfakAsIs, damped=TRUE,h=12)

  # Holt's Damped Exponential Trend
Model_holt_4 <- holt(EfakAsIs, exponential=TRUE, damped=TRUE,h=12)

  # Holt Winters' Seasonal Additive Model
Model_hw_1 <- hw(EfakAsIs ,seasonal="additive",h=12)

  # Holt Winters' Seasonal Multiplicative Model
Model_hw_2 <- hw(EfakAsIs ,seasonal="multiplicative",h=12)

# ---- ComputeModelMLE ----
  ## Compute Maximum Likelihood Estimation (AIC/AICc/BIC) Values for All Models
SESMLE<-capture.output(summary(Model_ses))
SESMLESplit<-unlist(strsplit(SESMLE[19], split=" "))

Holt_1MLE<-capture.output(summary(Model_holt_1))
Holt_1MLESplit<-unlist(strsplit(Holt_1MLE[21], split=" "))

Holt_2MLE<-capture.output(summary(Model_holt_2))
Holt_2MLESplit<-unlist(strsplit(Holt_2MLE[21], split=" "))

Holt_3MLE<-capture.output(summary(Model_holt_3))
Holt_3MLESplit<-unlist(strsplit(Holt_3MLE[22], split=" "))

Holt_4MLE<-capture.output(summary(Model_holt_4))
Holt_4MLESplit<-unlist(strsplit(Holt_4MLE[22], split=" "))
Holt_4MLESplit

hw_1MLE<-capture.output(summary(Model_hw_1))
hw_1MLESplit<-unlist(strsplit(hw_1MLE[24], split=" "))

hw_2MLE<-capture.output(summary(Model_hw_2))
hw_2MLESplit<-unlist(strsplit(hw_2MLE[24], split=" "))


ModelMLE<- rbind(
                 cbind(ModelType = "Simple Exponential Smoothing",                 ModelTypeAbbr = "SES",       as.data.frame(cbind(as.numeric(SESMLESplit[1]),as.numeric(SESMLESplit[2]),as.numeric(SESMLESplit[3])))),
                 cbind(ModelType = "Holt's Linear Trend",                          ModelTypeAbbr = "HLT",       as.data.frame(cbind(as.numeric(Holt_1MLESplit[1]),as.numeric(Holt_1MLESplit[2]),as.numeric(Holt_1MLESplit[3])))),
                 cbind(ModelType = "Holt's Exponential Trend",                     ModelTypeAbbr = "HET",       as.data.frame(cbind(as.numeric(Holt_2MLESplit[1]),as.numeric(Holt_2MLESplit[2]),as.numeric(Holt_2MLESplit[3])))),
                 cbind(ModelType = "Holt's Damped Linear Trend",                   ModelTypeAbbr = "HDLT",      as.data.frame(cbind(as.numeric(Holt_3MLESplit[1]),as.numeric(Holt_3MLESplit[2]),as.numeric(Holt_3MLESplit[3])))),
                 cbind(ModelType = "Holt's Damped Exponential Trend",              ModelTypeAbbr = "HDET",      as.data.frame(cbind(as.numeric(Holt_4MLESplit[1]),as.numeric(Holt_4MLESplit[2]),as.numeric(Holt_4MLESplit[3])))),
                 cbind(ModelType = "Holt Winters' Seasonal Additive Model",        ModelTypeAbbr = "HWSA",      as.data.frame(cbind(as.numeric(hw_1MLESplit[1]),as.numeric(hw_1MLESplit[2]),as.numeric(hw_1MLESplit[3])))),
                 cbind(ModelType = "Holt Winters' Seasonal Multiplicative Model",  ModelTypeAbbr = "HWSM",      as.data.frame(cbind(as.numeric(hw_2MLESplit[1]),as.numeric(hw_2MLESplit[2]),as.numeric(hw_2MLESplit[3]))))
                )
row.names(ModelMLE)<-NULL #reset row.names, so they will not display in formattable output
names(ModelMLE)<-c("ModelType","ModelTypeAbbr","AIC", "AICc", "BIC")

# ---- ComputeModelMLEtable ----
AICMinVal  <- min(ModelMLE$AIC)
AICcMinVal <- min(ModelMLE$AICc)
BICMinVal  <- min(ModelMLE$BIC)

AICFORMAT  <- formatter("span", style = x ~ ifelse(x == AICMinVal, style(color = "green", font.weight = "bold"), NA))
AICcFORMAT <- formatter("span", style = x ~ ifelse(x == AICcMinVal, style(color = "green", font.weight = "bold"), NA))
BICFORMAT  <- formatter("span", style = x ~ ifelse(x == BICMinVal, style(color = "green", font.weight = "bold"), NA))

formattable(ModelMLE, list(
                           AIC  = AICFORMAT,
                           AICc = AICcFORMAT, 
                           BIC  = BICFORMAT 
                          ))

# ---- ComputeModelError ----
  ## Compute Error Values for All Models
ModelError<- rbind(
                   cbind(ModelType = "Simple Exponential Smoothing",                 ModelTypeAbbr = "SES",       as.data.frame(accuracy(Model_ses))),
                   cbind(ModelType = "Holt's Linear Trend",                          ModelTypeAbbr = "HLT",       as.data.frame(accuracy(Model_holt_1))),
                   cbind(ModelType = "Holt's Exponential Trend",                     ModelTypeAbbr = "HET",       as.data.frame(accuracy(Model_holt_2))),
                   cbind(ModelType = "Holt's Damped Linear Trend",                   ModelTypeAbbr = "HDLT",      as.data.frame(accuracy(Model_holt_3))),
                   cbind(ModelType = "Holt's Damped Exponential Trend",              ModelTypeAbbr = "HDET",      as.data.frame(accuracy(Model_holt_4))),
                   cbind(ModelType = "Holt Winters' Seasonal Additive Model",        ModelTypeAbbr = "HWSA",      as.data.frame(accuracy(Model_hw_1))),
                   cbind(ModelType = "Holt Winters' Seasonal Multiplicative Model",  ModelTypeAbbr = "HWSM",      as.data.frame(accuracy(Model_hw_2)))
                  )
row.names(ModelError)<-NULL #reset row.names, so they will not display in formattable output

# ---- ComputeModelErrorTable ----

MEMinVal   <- min(ModelError$ME)
RMSEMinVal <- min(ModelError$RMSE)
MAEMinVal  <- min(ModelError$MAE)
MPEMinVal  <- min(ModelError$MPE)
MAPEMinVal <- min(ModelError$MAPE)
MASEMinVal <- min(ModelError$MASE)
ACF1MinVal <- min(ModelError$ACF1)

MEFORMAT   <- formatter("span", style = ~ ifelse(ME   == MEMinVal,   "background-color:LightGreen", NA))
RMSEFORMAT <- formatter("span", style = ~ ifelse(RMSE == RMSEMinVal, "background-color:LightGreen", NA))
MAEFORMAT  <- formatter("span", style = ~ ifelse(MAE  == MAEMinVal,  "background-color:LightGreen", NA))
MPEFORMAT  <- formatter("span", style = ~ ifelse(MPE  == MPEMinVal,  "background-color:LightGreen", NA))
MAPEFORMAT <- formatter("span", style = ~ ifelse(MAPE == MAPEMinVal, "background-color:LightGreen", NA))
MASEFORMAT <- formatter("span", style = ~ ifelse(MASE == MASEMinVal, "background-color:LightGreen", NA))
ACF1FORMAT <- formatter("span", style = ~ ifelse(ACF1 == ACF1MinVal, "background-color:LightGreen", NA))

formattable(ModelError, list(
                             ME   = MEFORMAT,
                             RMSE = RMSEFORMAT,
                             MAE  = MAEFORMAT,
                             MPE  = MPEFORMAT,
                             MAPE = MAPEFORMAT,
                             MASE = MASEFORMAT,
                             ACF1 = ACF1FORMAT
                            ))


# ---- PlotModelMLE ----

ModelMLEMelt<-melt(ModelMLE, id.vars = c("ModelType","ModelTypeAbbr"),variable.name="MLEType",value.name = "MLEValue")
#formattable(ModelMLEMelt)

ggplot(ModelMLEMelt, aes(x = ModelTypeAbbr,y=as.factor(MLEValue), fill = MLEType)) +
geom_bar(stat="identity" ,position=position_dodge()) +
theme(axis.text.x = element_text(angle = 90, hjust = 1))


# ---- SimpleExponential ----
par(mfrow=c(1,1))
plot(Model_ses, plot.conf=FALSE, ylab="Exports Chulwalar  )", xlab="Year", main="", fcol="white", type="o")
lines(fitted(Model_ses), col="green", type="o")
lines(Model_ses$mean, col="blue", type="o")
legend("topleft",lty=1, col=c(1,"green"), c("data", expression(alpha == 0.671)),pch=1)

# ---- HoltLinear ----
plot(Model_holt_1)

# ---- HoltExponential ----
plot(Model_holt_2)

# ---- HoltDampedLinear ----
plot(Model_holt_3)

# ---- HoltDampedExponential ----
plot(Model_holt_4)

# ---- HoltWinterSeasonalAdd ----
plot(Model_hw_1)

# ---- HoltWinterSeasonalMult ----
plot(Model_hw_2)

# ---- PlotSES_HWSA ----

plot(Model_holt_1, plot.conf=FALSE, ylab="Exports Chulwalar", xlab="Year", main="", fcol="white", type="o")
lines(fitted(Model_ses), col="purple", type="o")
lines(fitted(Model_hw_1), col="red", type="o")
legend("topleft",lty=1, col=c(1,"purple","red"), c("data", "SES","Holt Winters' Additive"),pch=1)


