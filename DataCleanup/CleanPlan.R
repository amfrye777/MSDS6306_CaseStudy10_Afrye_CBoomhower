# ---- CleanPlan_Vectors ----
PlanVector <-
  c(
    CWplan[2:13, 2],
    CWplan[2:13, 3],
    CWplan[2:13, 4],
    CWplan[2:13, 5],
    CWplan[2:13, 6],
    CWplan[2:13, 7]
  )
EfakPlanVector <-
  c(
    CWplan[16:27, 2],
    CWplan[16:27, 3],
    CWplan[16:27, 4],
    CWplan[16:27, 5],
    CWplan[16:27, 6],
    CWplan[16:27, 7]
  )
WugePlanVector <-
  c(
    CWplan[30:41, 2],
    CWplan[30:41, 3],
    CWplan[30:41, 4],
    CWplan[30:41, 5],
    CWplan[30:41, 6],
    CWplan[30:41, 7]
  )
TotalEtelPlanVector <-
  c(
    CWplan[44:55, 2],
    CWplan[44:55, 3],
    CWplan[44:55, 4],
    CWplan[44:55, 5],
    CWplan[44:55, 6],
    CWplan[44:55, 7]
  )
BlueEtelPlanVector <-
  c(
    CWplan[58:69, 2],
    CWplan[58:69, 3],
    CWplan[58:69, 4],
    CWplan[58:69, 5],
    CWplan[58:69, 6],
    CWplan[58:69, 7]
  )
RedEtelPlanVector <-
  c(
    CWplan[72:83, 2],
    CWplan[72:83, 3],
    CWplan[72:83, 4],
    CWplan[72:83, 5],
    CWplan[72:83, 6],
    CWplan[72:83, 7]
  )
YearPlanVector <-
  c(
    CWplan[86, 2],
    CWplan[86, 3],
    CWplan[86, 4],
    CWplan[86, 5],
    CWplan[86, 6],
    CWplan[86, 7]
  )
PlanVector_2014 <- c(CWplan[2:13, 8])

# ---- CleanPlan_TimeSeries ----
TotalPlan <-
  ts(
    PlanVector ,
    start = c(2008, 1),
    end = c(2013, 12),
    frequency = 12
  )
EfakPlan <-
  ts(
    EfakPlanVector,
    start = c(2008, 1),
    end = c(2013, 12),
    frequency = 12
  )
WugePlan <-
  ts(
    WugePlanVector,
    start = c(2008, 1),
    end = c(2013, 12),
    frequency = 12
  )
TotalEtelPlan <-
  ts(
    TotalEtelPlanVector,
    start = c(2008, 1),
    end = c(2013, 12),
    frequency = 12
  )
BlueEtelPlan <-
  ts(
    BlueEtelPlanVector,
    start = c(2008, 1),
    end = c(2013, 12),
    frequency = 12
  )
RedEtelPlan <-
  ts(
    RedEtelPlanVector,
    start = c(2008, 1),
    end = c(2013, 12),
    frequency = 12
  )
YearPlan <-
  ts(
    YearPlanVector,
    start = c(2008, 1),
    end = c(2013, 12),
    frequency = 12
  )
TotalPlan_2014 <-
  ts(
    PlanVector_2014,
    start = c(2014, 1),
    end = c(2014, 12),
    frequency = 12
  )

# ---- CleanPlan_TSverify ----
TotalPlan
EfakPlan
WugePlan 
TotalEtelPlan
BlueEtelPlan
RedEtelPlan
YearPlan
TotalPlan_2014