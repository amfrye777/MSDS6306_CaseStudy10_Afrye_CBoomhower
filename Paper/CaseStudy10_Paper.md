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

    knitr::read_chunk(paste0(DataAnalysis,'/EfakSTL.R'))

*Discuss STL plot and extract comments from .R code chunk*

    # The time series can be analysed using the stl function in order to seperate
    # the trend, seasonality and remainder (remaining coincidential) components from
    # one another.

    EfakAsIs_stl <- stl(EfakAsIs , s.window=9)

    # Thus the individual time series can be shown graphically and tabularly.

    # The trend of the total exports is almost linear. A relatively uniform 
    # seaonality can be seen.

    par(mfrow=c(3,2))

    plot(EfakAsIs_stl, col="black", main="EfakAsIs_stl")

![](CaseStudy10_Paper_files/figure-markdown_strict/EfakSTL_toSTL-1.png)<!-- -->

    EfakAsIs_stl

    ##  Call:
    ##  stl(x = EfakAsIs, s.window = 9)
    ## 
    ## Components
    ##              seasonal     trend   remainder
    ## Jan 2008  -24764.2935  424215.0   17138.327
    ## Feb 2008   15831.0144  428674.2   28059.806
    ## Mar 2008  130207.7627  433133.4  -96802.155
    ## Apr 2008  -89604.2059  437592.6   22785.601
    ## May 2008   53655.4937  441695.6  -37610.070
    ## Jun 2008  -28168.2633  445798.5  -32813.285
    ## Jul 2008  -85516.1259  449901.5  100116.605
    ## Aug 2008  -60069.0943  454145.5   -5063.426
    ## Sep 2008    7943.2490  458389.5   42037.232
    ## Oct 2008   -7071.1329  462633.5   40035.615
    ## Nov 2008   68795.5412  467722.8   -7327.353
    ## Dec 2008   16445.8636  472812.1  -47712.969
    ## Jan 2009  -24517.4534  477901.4  -23328.946
    ## Feb 2009   15030.7380  483130.9  -29974.653
    ## Mar 2009  130489.6277  488360.4   29731.942
    ## Apr 2009  -86832.2848  493589.9    8232.339
    ## May 2009   57869.0651  500738.5  -92278.532
    ## Jun 2009  -27027.1196  507887.0  -15084.868
    ## Jul 2009  -90206.2474  515035.5    6158.739
    ## Aug 2009  -59589.5620  522438.5   39650.014
    ## Sep 2009     851.7679  529841.6   54289.645
    ## Oct 2009   -6909.8449  537244.6  -23457.782
    ## Nov 2009   73045.0669  543205.7  -22545.787
    ## Dec 2009   14833.5303  549166.8   77581.656
    ## Jan 2010  -24755.0398  555127.9  -22195.867
    ## Feb 2010   13032.2054  561076.6   27006.164
    ## Mar 2010  134008.6158  567025.4   74962.029
    ## Apr 2010  -82897.5582  572974.1 -166544.521
    ## May 2010   64095.2734  583594.9   24320.793
    ## Jun 2010  -24238.1669  594215.8   19917.379
    ## Jul 2010  -99942.9436  604836.6  -66553.698
    ## Aug 2010  -57381.4168  624421.3  -83676.912
    ## Sep 2010  -10865.7682  644006.0   -3076.248
    ## Oct 2010   -6769.0932  663590.7  -47879.610
    ## Nov 2010   81404.4940  687749.1  -81098.578
    ## Dec 2010   15859.6431  711907.5  -34709.109
    ## Jan 2011  -20725.1613  736065.8   63302.314
    ## Feb 2011    4640.5850  758789.4  -37175.952
    ## Mar 2011  126506.6073  781512.9   35254.505
    ## Apr 2011  -71671.1699  804236.4  112570.762
    ## May 2011   72609.2532  823426.4  134361.369
    ## Jun 2011  -29542.5598  842616.3   16124.211
    ## Jul 2011 -106957.2985  861806.3  -12868.021
    ## Aug 2011  -56180.8353  874743.3    1822.494
    ## Sep 2011  -34706.0440  887680.4   -1546.319
    ## Oct 2011    2834.9631  900617.4  -29557.348
    ## Nov 2011  102441.1450  909955.8  -15780.975
    ## Dec 2011   24243.0806  919294.3   -1926.356
    ## Jan 2012  -18009.0673  928632.7  -61214.654
    ## Feb 2012   -3670.4398  940136.7   85007.773
    ## Mar 2012  113699.8439  951640.6  -31315.457
    ## Apr 2012  -63397.5364  963144.6    4701.978
    ## May 2012   73612.6954  973444.0  -60604.672
    ## Jun 2012  -38582.2807  983743.4   66325.886
    ## Jul 2012 -103993.5049  994042.8  -27810.308
    ## Aug 2012  -57435.0433 1001328.7   82463.345
    ## Sep 2012  -44905.1318 1008614.6  -64817.451
    ## Oct 2012    9879.7360 1015900.5   54213.796
    ## Nov 2012  111936.5697 1022987.5  124805.940
    ## Dec 2012   29331.9995 1030074.5  -72444.513
    ## Jan 2013  -18049.2165 1037161.5   45984.680
    ## Feb 2013   -6901.6162 1048193.9  -89097.308
    ## Mar 2013  106628.4564 1059226.3 -102962.768
    ## Apr 2013  -58865.3148 1070258.7   46594.616
    ## May 2013   73499.4031 1082162.2  -27729.613
    ## Jun 2013  -41914.5970 1094065.7 -118786.124
    ## Jul 2013 -103470.7481 1105969.2   67368.515
    ## Aug 2013  -56721.4519 1118541.3  -41741.860
    ## Sep 2013  -51170.4991 1131113.4  -29972.893
    ## Oct 2013   13783.1826 1143685.5   39983.346
    ## Nov 2013  118472.3596 1157162.1    8335.554
    ## Dec 2013   30102.5772 1170638.7   80093.721

    # It is interesting to note that the almost linear trend is not seen in the 
    # individual segments. The individual trends run partially in opposite 
    # directions in the middle of the time scale, which causes the linear trend 
    # in the total As Is data.

*Discuss Trend*

    par(mfrow=c(1,1))

    plot(EfakAsIs_stl$time.series[,"trend"], col="red")

![](CaseStudy10_Paper_files/figure-markdown_strict/EfakSTL_Trend-1.png)<!-- -->

### Efak Monthly Seasonal

    knitr::read_chunk(paste0(DataAnalysis,'/EfakSeasonal.R'))

*Discuss and extract comments*

    # The modification of the seasonlity component can also be changed into a
    # monthly view. It only makes sense to do this if the seasonality componant as
    # the trend looks almost identical and the remainder is then randomly spread. 

    monthplot(EfakAsIs_stl$time.series[,"seasonal"], main="", ylab="Seasonal")

![](CaseStudy10_Paper_files/figure-markdown_strict/EfakSeasonal_Monthly-1.png)<!-- -->

### Efak External Indicator Correlation

    knitr::read_chunk(paste0(DataAnalysis,'/EfakExtCorrelation.R'))

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
