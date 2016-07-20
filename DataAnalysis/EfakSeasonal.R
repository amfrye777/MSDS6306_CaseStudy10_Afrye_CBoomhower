# ---- EfakSeasonal_Monthly ----
# The modification of the seasonlity component can also be changed into a
# monthly view. It only makes sense to do this if the seasonality componant as
# the trend looks almost identical and the remainder is then randomly spread. 

monthplot(EfakAsIs_stl$time.series[,"seasonal"], main="", ylab="Seasonal")