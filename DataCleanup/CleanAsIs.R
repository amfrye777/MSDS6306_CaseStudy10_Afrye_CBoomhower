# ---- CleanAsIs_toVector ----
TotalAsIsVector <- c(AsIsChulwar [2:13, 2],
                     AsIsChulwar [2:13, 3],
                     AsIsChulwar [2:13, 4],
                     AsIsChulwar [2:13, 5],
                     AsIsChulwar [2:13, 6],
                     AsIsChulwar [2:13, 7])

EfakAsIsVector <- c(AsIsChulwar [16:27, 2],
                    AsIsChulwar [16:27, 3],
                    AsIsChulwar [16:27, 4],
                    AsIsChulwar [16:27, 5],
                    AsIsChulwar [16:27, 6],
                    AsIsChulwar [16:27, 7])

WugeAsIsVector <- c(AsIsChulwar [30:41, 2],
                    AsIsChulwar [30:41, 3],
                    AsIsChulwar [30:41, 4],
                    AsIsChulwar [30:41, 5],
                    AsIsChulwar [30:41, 6],
                    AsIsChulwar [30:41, 7])

TotalEtelAsIsVector <- c(AsIsChulwar [44:55, 2],
                         AsIsChulwar [44:55, 3],
                         AsIsChulwar [44:55, 4],
                         AsIsChulwar [44:55, 5],
                         AsIsChulwar [44:55, 6],
                         AsIsChulwar [44:55, 7])

BlueEtelAsIsVector <- c(AsIsChulwar [58:69, 2],
                        AsIsChulwar [58:69, 3],
                        AsIsChulwar [58:69, 4],
                        AsIsChulwar [58:69, 5],
                        AsIsChulwar [58:69, 6],
                        AsIsChulwar [58:69, 7])

RedEtelAsIsVector <- c(AsIsChulwar [72:83, 2],
                       AsIsChulwar [72:83, 3],
                       AsIsChulwar [72:83, 4],
                       AsIsChulwar [72:83, 5],
                       AsIsChulwar [72:83, 6],
                       AsIsChulwar [72:83, 7])

YearAsIsVector <- c(AsIsChulwar [86, 2],
                    AsIsChulwar [86, 3],
                    AsIsChulwar [86, 4],
                    AsIsChulwar [86, 5],
                    AsIsChulwar [86, 6],
                    AsIsChulwar [86, 7])

TotalAsIsVector_2014 <- c(AsIsChulwar[2:13, 8])

# ---- CleanAsIs_toTimeSeries ----
# The data is saved as a vector and needs to be converted into a time series
TotalAsIs <- ts(
  TotalAsIsVector,
  start             = c(2008, 1),
  end               = c(2013, 12),
  frequency         = 12
)

EfakAsIs <- ts(
  EfakAsIsVector ,
  start              = c(2008, 1),
  end                = c(2013, 12),
  frequency          = 12
)

WugeAsIs <- ts(
  WugeAsIsVector,
  start              = c(2008, 1),
  end                = c(2013, 12),
  frequency          = 12
)

TotalEtelAsIs <- ts(
  TotalEtelAsIsVector,
  start         = c(2008, 1),
  end           = c(2013, 12),
  frequency     = 12
)

BlueEtelAsIs <- ts(
  BlueEtelAsIsVector,
  start          = c(2008, 1),
  end            = c(2013, 12),
  frequency      = 12
)
RedEtelAsIs <- ts(
  RedEtelAsIsVector,
  start           = c(2008, 1),
  end             = c(2013, 12),
  frequency       = 12
)
YearAsIs <- ts(
  YearAsIsVector,
  start              = c(2008, 1),
  end                = c(2013, 12),
  frequency          = 12
)

TotalAsIs_2014 <- ts(
  TotalAsIsVector_2014,
  start        = c(2014, 1),
  end          = c(2014, 12),
  frequency    = 12
)

# ---- CleanAsIs_ReviewData ----
TotalAsIs
EfakAsIs
WugeAsIs
TotalEtelAsIs
BlueEtelAsIs
RedEtelAsIs
YearAsIs
TotalAsIs_2014