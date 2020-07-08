# schemeColoR: scrape color palettes from SchemeColor <img src="man/figures/schemeColoR.png" width="150" align="right" />

schemeColoR provides a simple function for pulling color palettes into R.

## Installation

To install the package from GitHub run:

```
devtools::install_github("daynefiler/schemeColoR", build_opts = "", dependencies = TRUE)
library(schemeColoR)
```

## Usage

The package currently contains one funciton, `schemeColoR()`, which takes the name of a palette from [SchemeColor.com]. Note, the function takes a couple seconds to run due to the slower server response.

```
schemeColoR("BISEXUALITY FLAG COLORS")
# A tibble: 3 x 9
#   name          hex       red green  blue  cyan magenta yellow black
#   <chr>         <chr>   <int> <int> <int> <int>   <dbl>  <dbl> <dbl>
# 1 Red-Purple    #D60270   214     2   112     0   0.99   0.476 0.16
# 2 Razzmic Berry #9B4F96   155    79   150     0   0.49   0.032 0.392
# 3 Royal Azure   #0038A8     0    56   168     1   0.666  0     0.341
```



