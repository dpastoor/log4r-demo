#' do some work
#' @param reps fake argument
#' @export
do_work <- function(reps) {
  log_info(.le$logger, message = "about to do some work!", reps = reps, package = "pkg.log4r")
  return(TRUE)
}
