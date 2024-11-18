#' showcase logging
#' @param arg1 some argument
#' @export
showcase <- function(arg1) {
  # some very manual "stack" tracing by calling out the fn as "showcase"
  log_debug(.le$logger, message = "debug message", arg1 = arg1, package = "pkg.log4r", fn = "showcase")
  log_info(.le$logger, message = "info message", arg1 = arg1, package = "pkg.log4r", fn = "showcase")
  log_warn(.le$logger, message = "warn message", arg1 = arg1, package = "pkg.log4r", fn = "showcase")
  log_error(.le$logger, message = "error message", arg1 = arg1, package = "pkg.log4r", fn = "showcase")
  log_fatal(.le$logger, message = "fatal message", arg1 = arg1, package = "pkg.log4r", fn = "showcase")
  return(TRUE)
}
