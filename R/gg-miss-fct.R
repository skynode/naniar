#' Plot the number of missings for each variable, broken down by a factor
#'
#' This function draws a ggplot plot of the number of missings in each column,
#'   broken down by a categorical variable from the dataset. A default minimal
#'   theme is used, which can be customised as normal for ggplot.
#'
#' @param x data.frame
#' @param fct column containing the factor variable to visualise
#'
#' @return ggplot object depicting the % missing of each factor level for
#'   each variable.
#'
#' @seealso [geom_miss_point()] [gg_miss_case()] [gg_miss_case_cumsum] [gg_miss_span()] [gg_miss_var()] [gg_miss_var_cumsum()] [gg_miss_which()]
#'
#' @export
#'
#' @examples
#'
#' gg_miss_fct(x = riskfactors, fct = marital)
#' library(ggplot2)
#' gg_miss_fct(x = riskfactors, fct = marital) + labs(title = "NA in Risk Factors and Marital status")
#'
#'
gg_miss_fct <- function(x, fct){

  fct <- rlang::enquo(fct)

  ggobject <- x %>%
    dplyr::group_by(!!fct) %>%
    miss_var_summary() %>%
    ggplot(aes_string(quo_name(fct),
                      "variable",
                      fill = "pct_miss")) +
    geom_tile() +
    viridis::scale_fill_viridis(name = "% Miss") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45,
                                     hjust = 1))

  return(ggobject)
}
