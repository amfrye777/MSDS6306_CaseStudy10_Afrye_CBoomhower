Introduction
============

Our client, the prime minister of Chulwalar has recruited our small team
of SMU data scientists to assist in forecasting Efak (A beautiful flower
unique to the region of Chulwalar) exports from his country. He has
provided us with historical, as-is flower export data, planned export
data, and external key indicators unique to Chulwalar (All historical
data provided by month from 2008-2013). It is our duty to best forecast
Chulwalar Efak exports in the upcoming year (2014) based on existing
export data.

There are several steps needed to accomplish this task. These steps are
summarized as follows:

-   Load all data sets
-   Clean and prepare as-is, planned, and external indicator data for
    analysis
-   Observe correlation between as-is and planned exports
-   Plot seasonal and trend decomposition using Loess (STL) for as-is
    export data
-   Plot seasonal trends by month
-   Perform exploratory data analysis (EDA) to better understand effects
    of external indictors
-   Utilize smoothing techniques to forecast future exports

### Required Packages

This RMD requires the following R packages to run:

-   formattable
-   fpp
-   ggplot2
-   reshape2

Data Load
=========

As this analysis consists of historical export data, planned data, and
external indicator data, each data set is stored in one of three CSV
files. These files are:

-   ImportedAsIsDataChulwalar.csv
-   ImportedPlanDataChulwalar.csv
-   ImportedIndicatorsChulwalar.csv

### AsIs Chulwalar Data

To start, we need to load our As Is Chulwar Data. This data has been
sourced from the SMU 2DS platform Unit 10.2 Overview page.

With our data loaded, we reviewed the structure and a small subset of
the data to confirm successful import.

After reviewing this subset of data, we discovered we have some cleanup
to do. It appears we have loaded one column for each year of data by
month(row). All export group information (TotalAsIs, Efak, Wuge,
TotalEtel, BlueEtel, RedEtel, and TotalYearly) has also been combined
into a list by repeating month/year data for each export group in
subsequent rows. We will need to parse this data to create a data
structure that is easier to analyze.

### Plan Chulwalar Data

Similarly, the second data set loaded is the planned export data. These
data are also obtained from SMU 2DS and loaded as follows:

Once again, the data structure and subset rows were reviewed to confirm
succesful import.

Similar to the as-is data set, structure and subset row review indicates
there are multiple groups (TotalPlan, Efak, Wuge, TotalEtel, BlueEtel,
RedEtel, YearPlan, and TotalPlan\_2014) of data within the single CSV
file that need divided accordingly. In order to do so, these data will
need parsed during cleanup and assigned to a data frame for efficient
analysis.

### External Indicator Chulwalar Data

Finally, the third data set loaded is the Chulwar external indicator
data. Again, the data set has been sourced from the SMU 2DS platform
Unit 10.2 Overview page:

Reviewing the external indicator data post-import confirms successful
loading.

As before, review indicates there are multiple groups (Export Price
Changes, Satisfaction Index (Gov), Average Temperature, Births,
Satisfaction Index (Independent), Total Exports from Urbano,
Globalization Party Members, Average Export Price, Etel Production Price
Index, Chulwalar Index, Inflation, Spending for Chulwalar Days,
Chulwalar Days, and Influence of Chulwalar Days) of data within the
single CSV file that need split by group. In order to do so, these data
once again need parsed during cleanup and assigned to a data frame
before analysis.

Data Cleanup
============

Data cleanup is imperative to any data analysis. In our precursory view
into header/footer records, we can tell there are several items needing
to be cleaned across the three datasets. The following sections will
walk through cleaning the data to prep for analysis.

### AsIs Data Cleanup

To clean our as-is Chulwar data, we first separate each export group
(e.g. TotalAsIs, Efak, Wuge, etc.) into individual vectors. Following
this, we convert each new vector into a time series. Finally, we review
each time series output to ensure they match our expectations.

### Plan Data Cleanup

To clean our planned Chulwar data, we once again separate each planned
export group into individual vectors. After this, we convert each new
vector into a time series and then review each time series output to
ensure they match our expectations. The time series output was as
expected.

### External Indicators Data Cleanup

Finally, to clean the external indicators data, we separate each
indicator group into individual vectors. Then, as done previously, we
convert each new vector into a time series. Lastly, we review each time
series output to ensure they match what we expect to see.

Data Analysis
=============

With the data cleaned, we are ready to proceed with our analysis. To
recap, while we are interested in forecasting Efak exports for 2014, we
are also interested in performing exploratory data analysis to identify
potential trends, seasonal fluctuation, and the strength of various
correlations.

### Efak Correlation

The first approach to EDA is to review historical exports against
Chulwalar's planned exports. This correlation will validate the prime
minister's planning committee estimates for previous years, identify
gaps in planning efforts, and will help us to better forecast 2014
exports. This will essentially provide a baseline by which we may
measure our own estimate accuracy.

Based on the as-is and planned export data plotted below, it appears
there may be inconsistencies regarding planning methodology. It looks as
though extreme adjustments were made between 2011 and 2012 to realign
plans with true exports. The plots suggest adjustments were too extreme,
resulting in some oscillations through the end of 2013.

    par(mfrow=c(1,2))

    plot(EfakAsIs , col="red",main="EfakAsIs")
    plot(EfakPlan , col="red",main="EfakPlan")

![](CaseStudy10_Paper_files/figure-markdown_strict/EfakCor_Business-1.png)<!-- -->

The next step is to observe the association between planned and as-is
exports. Pearson's r is therefore calculated and the resulting r value
is `0.906`. This indicates there is a strong, positive correlation
between both types of Efak exports. We aknowledge that `0.906`, though
strong, presents some room for improvement.

    cor(EfakAsIs , EfakPlan, method = "pearson")

    ## [1] 0.9055081

Though Pearson's r does suggest a strong association between planned and
as-is exports, a hypostheses test provides added insight into the
correlation's statistical significance. Our null hypotheis is that the
slope of our linear model is 0, whereas our alternative hypothesis is
that it is not 0. Based on the results presented below, the p-value is
equal to &lt;2e-16, meaning we reject the null hypothesis. There is
sufficient evidence to suggest the slope of the linear model between
planned and as-is exports is not equal to 0.

    EfakAsIs_tslm <- tslm(EfakAsIs ~ EfakPlan )
    summary(EfakAsIs_tslm)

    ## 
    ## Call:
    ## tslm(formula = EfakAsIs ~ EfakPlan)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -223437  -90637    8593   83869  322479 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 7.555e+04  4.005e+04   1.886   0.0634 .  
    ## EfakPlan    9.236e-01  5.173e-02  17.854   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 113600 on 70 degrees of freedom
    ## Multiple R-squared:  0.8199, Adjusted R-squared:  0.8174 
    ## F-statistic: 318.8 on 1 and 70 DF,  p-value: < 2.2e-16

### Efak STL

Now having a clearer understanding of the association between as-is and
planned Efak export, the next step is to review the as-is export trend,
seasonality, and remaining coincidential componenents. Utilizing the STL
function, we are able to seperate these components and plot them one
after the other.

Refering to the trend segment below, it is clear there is a nearly
linear increase in exports over time. The seasonality component
indicates a large number of exports toward the beginning of each year.
There appears to be a consistent decrease in exports during the Summer
months before steadily increasing again each year. Finally, the
remainder plot displays anomalies beyond observed Efak export trend and
seasonal behaviors.

    EfakAsIs_stl <- stl(EfakAsIs , s.window=9)

    par(mfrow=c(1,1))

    plot(EfakAsIs_stl, col="black", main="EfakAsIs_stl")

![](CaseStudy10_Paper_files/figure-markdown_strict/EfakSTL_toSTL-1.png)<!-- -->

### Efak Monthly Seasonal

    knitr::read_chunk(paste0(DataAnalysis,'/EfakSeasonal.R'))

To further clarify the seasonal trend observed for our data, the
seasonality component is plotted by month. The plot below confirms our
previous observations that exports are high around the month of March,
fluctuate between April and May, and then consistently drop during the
Summer months. This monthly plot also shows the gradual increase in
exports from July through the end of the year. It is worth mentioning a
sharp decrease in September exports is observed between 2008-2013.
Similarly, a substantial increase in exports is observed for the month
of November. Since the September drop in exports is alarming, it is
worth notifying the Chulwalar Prime Minister so that improvements can be
made.

    monthplot(EfakAsIs_stl$time.series[,"seasonal"], main="", ylab="Seasonal")

![](CaseStudy10_Paper_files/figure-markdown_strict/EfakSeasonal_Monthly-1.png)<!-- -->

### Efak External Indicator Correlation

    knitr::read_chunk(paste0(DataAnalysis,'/EfakExtCorrelation.R'))

After extensive EDA on several external indicator factors, two
indicators have been identified as noteworthy. The first indicator is
monthly change in export price index (CEPI) and the second is climate
temperature.

The CEPI plot below indicates a strong, nearly linear, increase in price
index between 2008 and 2013. This results in a strong Pearson's r value
of `0.93`, representing significant association with increase in
exports.

    # Monthly Change in Export Price Index (CEPI)
    plot(CEPI, main="CEPI")

![](CaseStudy10_Paper_files/figure-markdown_strict/EfakExtCorrelation_CEPI-1.png)<!-- -->

    cor(EfakAsIs , CEPI)

    ## [1] 0.9303543

Because strong correlation is observed, it is beneficial to also compare
the seasonal component from CEPI and Efak Exports. Based on the
following plots, it is apparent that prices are highest during months
when Efak exports are lowest and vice-versa. Modifications to export
pricing strategies may mitigate the effects of seasonal oscillations
throughout the year.

    par(mfrow=c(2,1))
    CEPI_stl <- stl(CEPI , s.window=9)
    plot(CEPI_stl$time.series[,"seasonal"], col="black", ylab = "CEPI", main = "Seasonal CEPI")
    plot(EfakAsIs_stl$time.series[,"seasonal"], col="black", ylab = "Exports", main = "Seasonal Efak Exports")

![](CaseStudy10_Paper_files/figure-markdown_strict/EfakExtCorrelation_CEPI_seasonal-1.png)<!-- -->

The second indicator of interest is temperature. One would expect
changes in temperature throughout the year to play a significant role in
flower yields and thus impact the number of exports. In reviewing the
correlation between temparature and Efak exports, a Pearson's r of
`-0.08` is produced. This is rather surprising given our aforementioned
assumption.

    # Average monthly temperatures in Chulwalar
    cor(EfakAsIs , Temperature)

    ## [1] -0.07951179

Further investigation yields the following STL plots. The raw data and
seasonal component follow the same pattern as expected and there is no
observable increase in temperature over the years. The steady
temperature trend is likely great cause for our low Pearson's r value.

    par(mfrow=c(1,1))
    Temperature_stl <- stl(Temperature , s.window=9)
    plot(Temperature_stl, main = "Temperature_STL")

![](CaseStudy10_Paper_files/figure-markdown_strict/EfakExtCorrelation_Temp_STL-1.png)<!-- -->

Because of the seasonal nature of the export and temperature data, it
makes sense to compare the seasonal component for Efak exports to the
changing temperature. The following plots confirm our original
assumptions that temperature likely has a negative impact on exports
during high temperature months.

    par(mfrow=c(2,1))
    plot(Temperature, main="Temperature")
    plot(EfakAsIs_stl$time.series[,"seasonal"], col="black", ylab = "Exports", main = "Seasonal Efak Exports")

![](CaseStudy10_Paper_files/figure-markdown_strict/EfakExtCorrelation_Temp_Seasonal-1.png)<!-- -->

    # The temperatures have a negative correlation, exports                      
    # increase in the colder months. However, the relationship is only stronger 
    # with blue Etels.

### Forecasting Efak models with smoothing and related approaches

    knitr::read_chunk(paste0(DataAnalysis,'/EfakSmoothing.R'))

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

    ## [1] "1978.710" "1979.619" "1990.093"

    hw_1MLE<-capture.output(summary(Model_hw_1))
    hw_1MLESplit<-unlist(strsplit(hw_1MLE[24], split=" "))

    hw_2MLE<-capture.output(summary(Model_hw_2))
    hw_2MLESplit<-unlist(strsplit(hw_2MLE[24], split=" "))


    ModelMLE<- rbind(
                     cbind(ModelType = "Simple Exponential Smoothing",                 ModelTypeAbbr = "SES",       as.data.frame(cbind(SESMLESplit[1],SESMLESplit[2],SESMLESplit[3]))),
                     cbind(ModelType = "Holt's Linear Trend",                          ModelTypeAbbr = "HLT",       as.data.frame(cbind(Holt_1MLESplit[1],Holt_1MLESplit[2],Holt_1MLESplit[3]))),
                     cbind(ModelType = "Holt's Exponential Trend",                     ModelTypeAbbr = "HET",       as.data.frame(cbind(Holt_2MLESplit[1],Holt_2MLESplit[2],Holt_2MLESplit[3]))),
                     cbind(ModelType = "Holt's Damped Linear Trend",                   ModelTypeAbbr = "HDLT",      as.data.frame(cbind(Holt_3MLESplit[1],Holt_3MLESplit[2],Holt_3MLESplit[3]))),
                     cbind(ModelType = "Holt's Damped Exponential Trend",              ModelTypeAbbr = "HDET",      as.data.frame(cbind(Holt_4MLESplit[1],Holt_4MLESplit[2],Holt_4MLESplit[3]))),
                     cbind(ModelType = "Holt Winters' Seasonal Additive Model",        ModelTypeAbbr = "HWSA",      as.data.frame(cbind(hw_1MLESplit[1],hw_1MLESplit[2],hw_1MLESplit[3]))),
                     cbind(ModelType = "Holt Winters' Seasonal Multiplicative Model",  ModelTypeAbbr = "HWSM",      as.data.frame(cbind(hw_2MLESplit[1],hw_2MLESplit[2],hw_2MLESplit[3])))
                    )
    row.names(ModelMLE)<-NULL #reset row.names, so they will not display in formattable output
    names(ModelMLE)<-c("ModelType","ModelTypeAbbr","AIC", "AICc", "BIC")
    formattable(ModelMLE)

<table style="width:125%;">
<colgroup>
<col width="62%" />
<col width="20%" />
<col width="13%" />
<col width="13%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="right">ModelType</th>
<th align="right">ModelTypeAbbr</th>
<th align="right">AIC</th>
<th align="right">AICc</th>
<th align="right">BIC</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">Simple Exponential Smoothing</td>
<td align="right">SES</td>
<td align="right">1977.827</td>
<td align="right">1978.001</td>
<td align="right">1982.380</td>
</tr>
<tr class="even">
<td align="right">Holt's Linear Trend</td>
<td align="right">HLT</td>
<td align="right">1975.610</td>
<td align="right">1976.207</td>
<td align="right">1984.717</td>
</tr>
<tr class="odd">
<td align="right">Holt's Exponential Trend</td>
<td align="right">HET</td>
<td align="right">1975.029</td>
<td align="right">1975.626</td>
<td align="right">1984.136</td>
</tr>
<tr class="even">
<td align="right">Holt's Damped Linear Trend</td>
<td align="right">HDLT</td>
<td align="right">1979.044</td>
<td align="right">1979.953</td>
<td align="right">1990.427</td>
</tr>
<tr class="odd">
<td align="right">Holt's Damped Exponential Trend</td>
<td align="right">HDET</td>
<td align="right">1978.710</td>
<td align="right">1979.619</td>
<td align="right">1990.093</td>
</tr>
<tr class="even">
<td align="right">Holt Winters' Seasonal Additive Model</td>
<td align="right">HWSA</td>
<td align="right">1958.925</td>
<td align="right">1968.816</td>
<td align="right">1995.352</td>
</tr>
<tr class="odd">
<td align="right">Holt Winters' Seasonal Multiplicative Model</td>
<td align="right">HWSM</td>
<td align="right">1964.418</td>
<td align="right">1974.309</td>
<td align="right">2000.844</td>
</tr>
</tbody>
</table>

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

    MEFORMAT<-formatter("span", style = ~ ifelse(ME < 10000, "background-color:LightGreen", NA))
    RMSEFORMAT<-formatter("span", style = ~ ifelse(RMSE < 100000, "background-color:LightGreen", NA))

    formattable(ModelError,list(ME=MEFORMAT, RMSE=RMSEFORMAT))       

<table style="width:347%;">
<colgroup>
<col width="62%" />
<col width="20%" />
<col width="93%" />
<col width="93%" />
<col width="13%" />
<col width="16%" />
<col width="15%" />
<col width="15%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="right">ModelType</th>
<th align="right">ModelTypeAbbr</th>
<th align="right">ME</th>
<th align="right">RMSE</th>
<th align="right">MAE</th>
<th align="right">MPE</th>
<th align="right">MAPE</th>
<th align="right">MASE</th>
<th align="right">ACF1</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">Simple Exponential Smoothing</td>
<td align="right">SES</td>
<td align="right"><span>28255.5686974526</span></td>
<td align="right"><span>105746.360129531</span></td>
<td align="right">83785.28</td>
<td align="right">1.6185322</td>
<td align="right">12.240714</td>
<td align="right">0.5987073</td>
<td align="right">-0.1644141</td>
</tr>
<tr class="even">
<td align="right">Holt's Linear Trend</td>
<td align="right">HLT</td>
<td align="right"><span>12981.2433596182</span></td>
<td align="right"><span>101278.188624904</span></td>
<td align="right">78180.91</td>
<td align="right">-0.3405668</td>
<td align="right">11.623790</td>
<td align="right">0.5586599</td>
<td align="right">-0.0379501</td>
</tr>
<tr class="odd">
<td align="right">Holt's Exponential Trend</td>
<td align="right">HET</td>
<td align="right"><span style="background-color:LightGreen">1027.78652647737</span></td>
<td align="right"><span style="background-color:LightGreen">99625.5017561852</span></td>
<td align="right">76933.69</td>
<td align="right">-2.0695411</td>
<td align="right">11.565285</td>
<td align="right">0.5497476</td>
<td align="right">-0.0136902</td>
</tr>
<tr class="even">
<td align="right">Holt's Damped Linear Trend</td>
<td align="right">HDLT</td>
<td align="right"><span>15606.5778392227</span></td>
<td align="right"><span>102291.450636505</span></td>
<td align="right">78689.55</td>
<td align="right">0.0337458</td>
<td align="right">11.662257</td>
<td align="right">0.5622945</td>
<td align="right">-0.0341930</td>
</tr>
<tr class="odd">
<td align="right">Holt's Damped Exponential Trend</td>
<td align="right">HDET</td>
<td align="right"><span style="background-color:LightGreen">3135.94744889523</span></td>
<td align="right"><span>101334.425371825</span></td>
<td align="right">77773.93</td>
<td align="right">-2.4240518</td>
<td align="right">11.858425</td>
<td align="right">0.5557518</td>
<td align="right">-0.0744258</td>
</tr>
<tr class="even">
<td align="right">Holt Winters' Seasonal Additive Model</td>
<td align="right">HWSA</td>
<td align="right"><span style="background-color:LightGreen">8710.85874215872</span></td>
<td align="right"><span style="background-color:LightGreen">76350.8064264007</span></td>
<td align="right">61147.93</td>
<td align="right">-0.2519017</td>
<td align="right">8.973478</td>
<td align="right">0.4369468</td>
<td align="right">-0.0912664</td>
</tr>
<tr class="odd">
<td align="right">Holt Winters' Seasonal Multiplicative Model</td>
<td align="right">HWSM</td>
<td align="right"><span style="background-color:LightGreen">6211.72593543445</span></td>
<td align="right"><span style="background-color:LightGreen">83390.079343758</span></td>
<td align="right">64171.99</td>
<td align="right">-0.6174998</td>
<td align="right">9.086466</td>
<td align="right">0.4585560</td>
<td align="right">-0.1381724</td>
</tr>
</tbody>
</table>

    plot(Model_ses, plot.conf=FALSE, ylab="Exports Chulwalar  )", xlab="Year", main="", fcol="white", type="o")
    lines(fitted(Model_ses), col="green", type="o")
    lines(Model_ses$mean, col="blue", type="o")
    legend("topleft",lty=1, col=c(1,"green"), c("data", expression(alpha == 0.671)),pch=1)

![](CaseStudy10_Paper_files/figure-markdown_strict/SimpleExponential-1.png)<!-- -->

    plot(Model_holt_1)

![](CaseStudy10_Paper_files/figure-markdown_strict/HoltLinear-1.png)<!-- -->

    plot(Model_holt_2)

![](CaseStudy10_Paper_files/figure-markdown_strict/HoltExponential-1.png)<!-- -->

    plot(Model_holt_3)

![](CaseStudy10_Paper_files/figure-markdown_strict/HoltDampedLinear-1.png)<!-- -->

    plot(Model_holt_4)

![](CaseStudy10_Paper_files/figure-markdown_strict/HoltDampedExponential-1.png)<!-- -->

    plot(Model_hw_1)

![](CaseStudy10_Paper_files/figure-markdown_strict/HoltWinterSeasonalAdd-1.png)<!-- -->

    plot(Model_hw_2)

![](CaseStudy10_Paper_files/figure-markdown_strict/HoltWinterSeasonalMult-1.png)<!-- -->

Conclusion
==========

Conclusion Text Goes Here....
