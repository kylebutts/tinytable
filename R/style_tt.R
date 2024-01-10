#' export
style_tt <- function(
  x,
  i, j,
  bold = FALSE,
  italic = FALSE,
  monospace = FALSE,
  color = NULL,
  background = NULL,
  fontsize = NULL,
  width = NULL,
  align = NULL,
  colspan = NULL,
  rowspan = NULL,
  tabularray = NULL,
  bootstrap = NULL) {

  # TODO: cmd needs to be concatenated when there are many

  assert_string(color, null.ok = TRUE)
  assert_string(background, null.ok = TRUE)
  assert_string(fontsize, null.ok = TRUE)
  assert_string(width, null.ok = TRUE)
  assert_choice(align, c("c", "l", "r"), null.ok = TRUE)
  assert_flag(bold)
  assert_flag(italic)
  assert_integerish(colspan, len = 1, null.ok = TRUE)
  assert_integerish(rowspan, len = 1, null.ok = TRUE)

  arguments <- list()

  if (isTRUE(bold)) {
    arguments$bold <- list(
      tabularray = "cmd=\\bfseries",
      bootstrap = "font-weight: bold"
    )
  } 
  if (isTRUE(italic)) {
    arguments$italic <- list(
      tabularray = "cmd=\\textit",
      bootstrap = "font-style: italic"
    )
  } 
  if (isTRUE(monospace)) {
    arguments$monospace <- list(
      tabularray = "cmd=\\texttt",
      bootstrap = "font-family: monospace"
    )
  }
  if (!is.null(align)) {
    arguments$align <- list(
      tabularray = paste0("halign=", align),
      bootstrap = paste("text-align:", switch(align, r = "right", l = "left", c = "center"))
    )
  }
  if (!is.null(colspan)) {
    arguments$colspan <- list(
      tabularray <- paste0("c=", colspan)
    )
  }
  if (!is.null(rowspan)) {
    arguments$rowspan <- list(
      tabularray <- paste0("r=", colspan)
    )
  }
  if (!is.null(color)) {
    arguments$color <- list(
      tabularray = paste0("fg=", color),
      bootstrap = paste0("color: ", color)
    )
  }
  if (!is.null(background)) {
    arguments$background <- list(
      tabularray = paste0("bg=", background),
      bootstrap = paste0("background-color: ", background)
    )
  }
  if (!is.null(fontsize)) {
    arguments$fontsize <- list(
      bootstrap = paste("font-size:", fontsize)
    )
  }
  if (!is.null(width)) {
    arguments$width <- list(
      tabularray = sprintf("wd={%s}", width),
      bootstrap = paste("width:%s", width)
    )
  }

  tabularray <- sapply(arguments, function(x) x[["tabularray"]])
  tabularray <- paste(tabularray, collapse = ",")
  out <- style_tabularray(x, inner = tabularray)
  # TODO: use style_tabularray() to apply this if appropriate when we have given it a good class
  browser()

  class(out) <- c("style_tt", class(out))

  return(out)
}