# ---- EfakSTL_toSTL ----
EfakAsIs_stl <- stl(EfakAsIs , s.window=9)

par(mfrow=c(1,1))

plot(EfakAsIs_stl, col="black", main="EfakAsIs_stl")

# ----
EfakAsIs_stl

# ---- EfakSTL_Trend ----
plot(EfakAsIs_stl$time.series[,"trend"], col="red")

