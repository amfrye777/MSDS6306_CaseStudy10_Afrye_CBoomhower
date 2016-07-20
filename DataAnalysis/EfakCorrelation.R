# ---- EfakCor_Business ----
par(mfrow=c(2,1))

plot(EfakAsIs , col="red",main="EfakAsIs")
plot(EfakPlan , col="red",main="EfakPlan")

# ---- EfakCor_Correlation ----
cor(EfakAsIs , EfakPlan)

# ---- EfakCor_Accuracy ----
EfakAsIs_lm <- lm(EfakAsIs ~ EfakPlan , data = EfakAsIs)
summary(EfakAsIs_lm)

EfakAsIs_tslm <- tslm(EfakAsIs ~ EfakPlan )
summary(EfakAsIs_tslm)