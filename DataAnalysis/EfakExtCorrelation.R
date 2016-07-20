# ---- EfakExtCorrelation_CEPI ----
# Monthly Change in Export Price Index (CEPI)
plot(CEPI, main="CEPI")

cor(EfakAsIs , CEPI)

# The CEPI correlates very well with the efak exports.

# ---- EfakExtCorrelation_SI ----
# Monthly Satisfaction Index (SI) government based data
plot(SIGov, main="SIGov")

cor(EfakAsIs , SIGov)

# The Satisfaction Index does not show any particular correlation with any of 
# the exports data.

# ---- EfakExtCorrelation_Temp ----
# Average monthly temperatures in Chulwalar
plot(Temperature, main="Temperature")

cor(EfakAsIs , Temperature)

# The temperatures have a negative correlation, exports                      
# increase in the colder months. However, the relationship is only stronger 
# with blue Etels.

# ---- EfakExtCorrelation_Births ----
# Monthly births in Chulwalar 
plot(Births, main="Births")

cor(EfakAsIs , Births)

# The consideration by Chulwalar's experts was that expecting new parents to try to export more products to pay for the 
# cost of a new child. However, this could not be confirmed.  

# ---- EfakExtCorrelation_SIExtern ----
# Monthly Satisfaction Index (SI) external index 
plot(SIExtern, main="SIExtern")

cor(EfakAsIs , SIExtern)

# This indicator also has a high correlation with Efak exports. 

# ---- EfakExtCorrelation_Urbano ----
# Yearly exports from Urbano
plot(UrbanoExports, main="UrbanoExports")

cor(EfakAsIs , UrbanoExports)

# This indicator also has a high correlation with Efak exports. The Wuge 
# exports also show a correlation. Unfortunatly it was not possible to find
# other useful indicators based on exports from Urbano, due to possible 
# informers being very restrictive with information. 

# ---- EfakExtCorrelation_PartyM ----
# Yearly number of Globalisation Party members in Chulwalar
plot(GlobalisationPartyMembers, main="GlobalisationPartyMembers")

cor(EfakAsIs , GlobalisationPartyMembers)

# There is a similar picture here to that of Urbano Exports.
# It should however be noted that there is a continuos growth here and that
# the yearly view could lead to the data appearing to correlate, although this 
# could just be due to an increase in trend. Although this could also be true
# for the Urbano Exports, the trend seems logical due to the Chulwalar's 
# exports growing in accordance with the Urbano's Exports.

# ---- EfakExtCorrelation_AEPI ----
# Monthly Average Export Price Index for Chulwalar
plot(AEPI, main="AEPI")

cor(EfakAsIs , AEPI)

# The continuous growth leads to a good correlation here too.
# See Above

# ---- EfakExtCorrelation_PPI ----
# Monthly Producer Price Index (PPI) for Etel in Chulwalar
plot(PPIEtel, main="PPIEtel")

cor(EfakAsIs , PPIEtel)

# This indicator does not give the expected results. It does not show any 
# correlation worth mentioning, not even with the Etel segment. 

# ---- EfakExtCorrelation_Holidays ----
# National Holidays
plot(NationalHolidays, main="NationalHolidays")

cor(EfakAsIs , NationalHolidays)

# The months April and December do not correlate well with the exports data. 
# However later tests will show that these are worth considering. 
# The missing correlation is just due to the sparse structure of the NationalHolidays time series.

# ---- EfakExtCorrelation_Index ----
# Chulwalar Index (Total value of all companies in Chulwalar)
plot(ChulwalarIndex, main="ChulwalarIndex")

cor(EfakAsIs , ChulwalarIndex)

# No particular findings

# ---- EfakExtCorrelation_Inflation ----
# Monthly Inflation rate in Chulwalar 
plot(Inflation, main="Inflation")

cor(EfakAsIs , Inflation)

# No particular findings

# ---- EfakExtCorrelation_Independence ----
# Proposed spending for Independence day presents
plot(IndependenceDayPresents, main="IndependenceDayPresents")

cor(EfakAsIs , IndependenceDayPresents)

# No particular findings

# ---- EfakExtCorrelation_HolidayInf ----
# Influence of National Holidays :
# This indicator is an experiment where the influence of National Holidays is 
# extended into the months leading up to the holiday. 
# However later tests show that this indicator is no better for forecasting than the
# orignial National Holidays indicator.    
plot(InfluenceNationalHolidays, main="InfluenceNationalHolidays")

cor(EfakAsIs , InfluenceNationalHolidays)