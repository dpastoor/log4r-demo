.le <- new.env(parent = emptyenv())
.le$logger <- log4r::logger(threshold = "DEBUG")
log_debug <- log4r::debug
log_info <- log4r::info
log_warn <- log4r::warn
log_error <- log4r::error
log_fatal <- log4r::fatal


#' set the default package logger
#' @param logger a log4r logger
#' @export
set_logger <- function(logger) {
  if (!inherits(logger, "logger")) {
    rlang::abort("logger must be of class `logger` from log4r")
  }
  .le$logger <- logger
  return(invisible(NULL))
}
