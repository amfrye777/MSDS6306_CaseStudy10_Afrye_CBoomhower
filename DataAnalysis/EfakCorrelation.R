# ---- EfakCor_Business ----
par(mfrow=c(1,2))

plot(EfakAsIs , col="red",main="EfakAsIs")
plot(EfakPlan , col="red",main="EfakPlan")

# ---- EfakCor_Correlation ----
cor(EfakAsIs , EfakPlan, method = "pearson")

# ----
EfakAsIs_lm <- lm(EfakAsIs ~ EfakPlan , data = EfakAsIs)
summary(EfakAsIs_lm)

# ---- EfakCor_Accuracy ----
EfakAsIs_tslm <- tslm(EfakAsIs ~ EfakPlan )
summary(EfakAsIs_tslm)
