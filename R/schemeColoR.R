#' @name schemeColoR
#' @title Scrape color schemes from SchemeColor.com
#' @description \code{schemeColoR} provides a tool to scrape color palettes
#' from SchemeColor.com based on the palette name.
#' @param palName character of length 1 giving the palette name as defined on
#' SchemeColor.com
#' @details
#' SchemeColor.com uses the url format https://www.schemecolor.com/palName.php,
#' converting spaces in the palette name to dashes. \code{schemeColoR} attempts
#' to clean-up the given 'palName' removing leading/trailing whitespace and
#' substituting spaces for dashes.
#' @examples
#' schemeColoR("bisexuality-flag-colors")
#' @importFrom tidyr separate `%>%`
#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes html_text
#' @importFrom stringr str_replace str_to_upper str_replace_all
#' @importFrom dplyr bind_cols
#' @importFrom methods is
#' @export

schemeColoR <- function(palName) {

  ## Variable binding of . used in piped commands to pass checks
  . <- NULL

  stopifnot(length(palName) == 1)
  stopifnot(is.character(palName))
  palName <- tolower(trimws(palName))
  palName <- gsub("[: :]+", "-", palName)
  u <- sprintf("https://www.schemecolor.com/%s.php", palName)
  info <- try(read_html(u) %>% html_nodes(css = ".color-info"), silent = TRUE)
  if (is(info, "try-error")) {
    stop("Could not find '", palName, "' at: ", u)
  }

  .nm <- info %>%
    html_nodes(css = "li:nth-child(1)") %>%
    html_text() %>%
    str_replace(pattern = "Name: ", "")

  .hex <- info %>%
    html_nodes(css = "li:nth-child(2)") %>%
    html_text() %>%
    str_replace(pattern = "Hex: ", "") %>%
    str_to_upper()

  .rgb <- info %>%
    html_nodes(css = "li:nth-child(3)") %>%
    html_text() %>%
    str_replace_all(pattern = "RGB: |\\(|\\)| ", "") %>%
    bind_cols(tmp = .) %>%
    separate(col = "tmp", into = c("red", "green", "blue"), convert = TRUE)

  .cmyk <- info %>%
    html_nodes(css = "li:nth-child(4)") %>%
    html_text() %>%
    str_replace_all(pattern = "CMYK: | ", "") %>%
    bind_cols(tmp = .) %>%
    separate(col = "tmp",
             into = c("cyan", "magenta", "yellow", "black"),
             sep = ",",
             convert = TRUE)

  bind_cols(name = .nm, hex = .hex, .rgb, .cmyk)

}



