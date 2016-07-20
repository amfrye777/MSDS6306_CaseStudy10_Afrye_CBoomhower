# ---- EfakSTL_toSTL ----
# The time series can be analysed using the stl function in order to seperate
# the trend, seasonality and remainder (remaining coincidential) components from
# one another.

EfakAsIs_stl <- stl(EfakAsIs , s.window=9)

# Thus the individual time series can be shown graphically and tabularly.

# The trend of the total exports is almost linear. A relatively uniform 
# seaonality can be seen.

par(mfrow=c(3,2))

plot(EfakAsIs_stl, col="black", main="EfakAsIs_stl")
EfakAsIs_stl


# It is interesting to note that the almost linear trend is not seen in the 
# individual segments. The individual trends run partially in opposite 
# directions in the middle of the time scale, which causes the linear trend 
# in the total As Is data.

# ---- EfakSTL_Trend ----
par(mfrow=c(1,1))

plot(EfakAsIs_stl$time.series[,"trend"], col="red")

