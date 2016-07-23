Assignment Definition
---------------------

The prime minister of Chulwalhar has asked us to help him in forecasting
exports from his country. In order to do this we have been given as-is
data, which is the original or observed data, and planned data, which is
what Chulwalhar would like to export. We also have a list of indicators
that may affect exports. Our job is to find out the best way to forecast
Chulwalhar’s exports in 2014 based on data collected before this year.
In other words, we want to create a credible statistical model.

The export data for Chulwalhar are in two CSV files. One contains the
as-is data and the other one contains the planned data. These data sets
are also composed of other data sets: monthly and yearly for both
groups. Your task is to take all of these data sets, import them into R,
and develop a model to forecast the exports of these particular products
for the prime minister of Chulwalhar.

Submit an R markdown document with the code necessary to download clean
and analyze the data. Interpretations of the code and analysis should be
provided. There should also be at least one graphic that explains an
important feature of the data. This graphic should be interpreted in the
text of the document.

FILE TREE STRUCTURE DEFINED
---------------------------

    ## -- DataAnalysis
    ##    |__EfakCorrelation.R
    ##    |__EfakCorrelation.RMD
    ##    |__EfakExtCorrelation.R
    ##    |__EfakExtCorrelation.RMD
    ##    |__EfakSeasonal.R
    ##    |__EfakSeasonal.RMD
    ##    |__EfakSmoothing.R
    ##    |__EfakSmoothing.RMD
    ##    |__EfakSTL.R
    ##    |__EfakSTL.RMD
    ## -- DataCleanup
    ##    |__CleanAsIs.R
    ##    |__CleanAsIs.Rmd
    ##    |__CleanIndicators.R
    ##    |__CleanIndicators.Rmd
    ##    |__CleanPlan.R
    ##    |__CleanPlan.RMD
    ## -- DataLoad
    ##    |__ImportedAsIsDataChulwalar.csv
    ##    |__ImportedIndicatorsChulwalar.csv
    ##    |__ImportedPlanDataChulwalar.csv
    ##    |__LoadAsIs.R
    ##    |__LoadAsIs.RMD
    ##    |__LoadIndicators.R
    ##    |__LoadIndicators.Rmd
    ##    |__LoadPlan.R
    ##    |__LoadPlan.RMD
    ## -- MSDS6306_CaseStudy10_Afrye_CBoomhower.Rproj
    ## -- Paper
    ##    |__CaseStudy10_Paper.md
    ##    |__CaseStudy10_Paper.RMD
    ##    |__CaseStudy10_Paper_files
    ##       |__figure-markdown_strict
    ##          |__EfakCor_Business-1.png
    ##          |__EfakExtCorrelation_CEPI-1.png
    ##          |__EfakExtCorrelation_CEPI_seasonal-1.png
    ##          |__EfakExtCorrelation_Temp_Seasonal-1.png
    ##          |__EfakExtCorrelation_Temp_STL-1.png
    ##          |__EfakSeasonal_Monthly-1.png
    ##          |__EfakSTL_toSTL-1.png
    ##          |__HoltWinterSeasonalAdd-1.png
    ##          |__PlotModelMLE-1.png
    ##          |__PlotSES_HWSA-1.png
    ##          |__SimpleExponential-1.png
    ##       |__ModelErrors.png
    ##       |__ModelMLE.png
    ## -- README.md
    ## -- README.rmd
    ## -- RResources
    ##    |__SourceAll.R
    ##    |__Twee.R

**NOTE:** Project Deliverable File Located:
"~/Paper/CaseStudy10\_Paper.MD"

PROJECT REPRODUCIBILITY INSTRUCTIONS
------------------------------------

1.  Regenerate README (If Project File Structure Changes)
    -   Open README.RMD located inside Project Root
    -   Modify DefaultDir input to your Project's Root Directory Path
    -   Knit README.Rmd

2.  Regenerate AFrye\_Week6CaseStudy.MD
    -   Open CaseStudy10\_Paper.RMD
    -   Modify DefaultDir input to your Project's Root Directory Path
    -   Ensure all required R Packages are installed on your machine.
        Uncomment any needed Install.Packages code lines
    -   Knit CaseStudy10\_Paper.RMD
