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
                 cbind(ModelType = "Simple Exponential Smoothing",                 as.data.frame(cbind(SESMLESplit[1],SESMLESplit[2],SESMLESplit[3]))),
                 cbind(ModelType = "Holt's Linear Trend",                          as.data.frame(cbind(Holt_1MLESplit[1],Holt_1MLESplit[2],Holt_1MLESplit[3]))),
                 cbind(ModelType = "Holt's Exponential Trend",                     as.data.frame(cbind(Holt_2MLESplit[1],Holt_2MLESplit[2],Holt_2MLESplit[3]))),
                 cbind(ModelType = "Holt's Damped Linear Trend",                   as.data.frame(cbind(Holt_3MLESplit[1],Holt_3MLESplit[2],Holt_3MLESplit[3]))),
                 cbind(ModelType = "Holt's Damped Exponential Trend",              as.data.frame(cbind(Holt_4MLESplit[1],Holt_4MLESplit[2],Holt_4MLESplit[3]))),
                 cbind(ModelType = "Holt Winters' Seasonal Additive Model",        as.data.frame(cbind(hw_1MLESplit[1],hw_1MLESplit[2],hw_1MLESplit[3]))),
                 cbind(ModelType = "Holt Winters' Seasonal Multiplicative Model",  as.data.frame(cbind(hw_2MLESplit[1],hw_2MLESplit[2],hw_2MLESplit[3])))
                )
row.names(ModelError)<-NULL #reset row.names, so they will not display in formattable output
names(ModelMLE)<-c("ModelType","AIC", "AICc", "BIC")
formattable(ModelMLE)

# ---- ComputeModelError ----
  ## Compute Error Values for All Models
ModelError<- rbind(
                   cbind(ModelType = "Simple Exponential Smoothing",                 as.data.frame(accuracy(Model_ses))),
                   cbind(ModelType = "Holt's Linear Trend",                          as.data.frame(accuracy(Model_holt_1))),
                   cbind(ModelType = "Holt's Exponential Trend",                     as.data.frame(accuracy(Model_holt_2))),
                   cbind(ModelType = "Holt's Damped Linear Trend",                   as.data.frame(accuracy(Model_holt_3))),
                   cbind(ModelType = "Holt's Damped Exponential Trend",              as.data.frame(accuracy(Model_holt_4))),
                   cbind(ModelType = "Holt Winters' Seasonal Additive Model",        as.data.frame(accuracy(Model_hw_1))),
                   cbind(ModelType = "Holt Winters' Seasonal Multiplicative Model",  as.data.frame(accuracy(Model_hw_2)))
                  )
row.names(ModelError)<-NULL #reset row.names, so they will not display in formattable output
formattable(ModelError)

# ---- SimpleExponential ----
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

# ----

# level and slope can be plotted individually for each model. 
plot(Model_holt_1$model$state)
plot(Model_holt_2$model$state)
plot(Model_holt_3$model$state)
plot(Model_holt_4$model$state)

plot(Model_holt_1, plot.conf=FALSE, ylab="Exports Chulwalar  )", xlab="Year", main="", fcol="white", type="o")
lines(fitted(Model_ses), col="purple", type="o")
lines(fitted(Model_holt_1), col="blue", type="o")
lines(fitted(Model_holt_2), col="red", type="o")
lines(fitted(Model_holt_3), col="green", type="o")
lines(fitted(Model_holt_4), col="orange", type="o")
lines(Model_ses$mean, col="purple", type="o")
lines(Model_holt_1$mean, col="blue", type="o")
lines(Model_holt_2$mean, col="red", type="o")
lines(Model_holt_3$mean, col="green", type="o")
lines(Model_holt_4$mean, col="orange", type="o")
legend("topleft",lty=1, col=c(1,"purple","blue","red","green","orange"), c("data", "SES","Holts auto", "Exponential", "Additive Damped", "Multiplicative Damped"),pch=1)

plot(Model_hw_1, ylab="Exports Chulwalar  ", plot.conf=FALSE, type="o", fcol="white", xlab="Year")
lines(fitted(Model_hw_1), col="red", lty=2)
lines(fitted(Model_hw_2), col="green", lty=2)
lines(Model_hw_1$mean, type="o", col="red")
lines(Model_hw_2$mean, type="o", col="green")
legend("topleft",lty=1, pch=1, col=1:3, c("data","Holt Winters' Additive","Holt Winters' Multiplicative"))

