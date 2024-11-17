
<!-- README.md is generated from README.Rmd. Please edit that file -->

# log4r-demo

<!-- badges: start -->

<!-- badges: end -->

The goal of log4r-demo is to showcase how log4r can work under various
scenarios.

In the upcoming release, log4r will use namespaced functions, so lets
start using that now:

``` r
library(log4r)
log_info <- log4r::info
log_warn <- log4r::warn
log_error <- log4r::error
log_debug <- log4r::debug
```

``` r
start_time <- Sys.time() - 1.5 # lets pretend to let this work for 1.5 seconds
logger <- logger(threshold = "DEBUG", appenders = console_appender(logfmt_log_layout()))
log_debug(
  logger, 
  message = "processed entries", 
  file = whereami::whereami(), # if we want to know where this is coming from
  duration = difftime(Sys.time(), start_time, units = "secs")
)
#> level=DEBUG ts=2024-11-17T23:33:16Z message="processed entries" file=./README.Rmd duration=1.507
```

One of the other nice things is functions invoked as fields will only be
evaluated if they are used.

For example:

``` r
did_i_run <- function(context) {
  message("yes I ran in context: ", context)
  return(context)
}
logger <- logger(appenders = console_appender(logfmt_log_layout()))
did_i_run("in chunk")
#> yes I ran in context: in chunk
#> [1] "in chunk"

# this will print and also store the context in the output
log_info(logger, message = "an info message", output = did_i_run("in info log"))
#> yes I ran in context: in info log
#> level=INFO ts=2024-11-17T23:33:16Z message="an info message" output="in info log"

# if this were to eagerly evaluate this would print "yes I ran in context: in debug log" even if the log doesn't print
log_debug(logger, message = "a debug message", output = did_i_run("in debug log"))

# prove code evaluated all the way through here
did_i_run("after log messages")
#> yes I ran in context: after log messages
#> [1] "after log messages"
```

This means you can invoke pontentially “expensive” computation in debug
messages without worrying about them being unnecessarily executed.

<details>

``` r
sessionInfo()
#> R version 4.3.2 (2023-10-31)
#> Platform: aarch64-apple-darwin20 (64-bit)
#> Running under: macOS Sonoma 14.5
#> 
#> Matrix products: default
#> BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib 
#> LAPACK: /Library/Frameworks/R.framework/Versions/4.3-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.11.0
#> 
#> locale:
#> [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
#> 
#> time zone: America/New_York
#> tzcode source: internal
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] log4r_0.4.4
#> 
#> loaded via a namespace (and not attached):
#>  [1] jsonlite_1.8.8    crayon_1.5.3      compiler_4.3.2    highr_0.11        whereami_0.2.0    jquerylib_0.1.4  
#>  [7] credentials_2.0.1 yaml_2.3.10       fastmap_1.2.0     R6_2.5.1          pak_0.8.0         knitr_1.48       
#> [13] tibble_3.2.1      rprojroot_2.0.4   openssl_2.1.1     R.cache_0.16.0    bslib_0.8.0       pillar_1.9.0     
#> [19] R.utils_2.12.3    rlang_1.1.4       utf8_1.2.4        cachem_1.1.0      xfun_0.47         sass_0.4.9       
#> [25] fs_1.6.4          sys_3.4.2         cli_3.6.3         withr_3.0.1       magrittr_2.0.3    digest_0.6.37    
#> [31] rstudioapi_0.16.0 askpass_1.2.0     gert_2.0.1        lifecycle_1.0.4   R.oo_1.25.0       R.methodsS3_1.8.2
#> [37] vctrs_0.6.5       evaluate_0.24.0   glue_1.7.0        data.table_1.16.0 whisker_0.4.1     styler_1.10.2    
#> [43] fansi_1.0.6       rmarkdown_2.28    purrr_1.0.2       tools_4.3.2       usethis_3.0.0     pkgconfig_2.0.3  
#> [49] htmltools_0.5.8.1
```

</details>
