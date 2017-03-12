library(dplyr)
library(DT)
library(ggplot2)
library(plotly)
library(readr)
library(shiny)
library(shinydashboard)
library(shinyjs)
library(tidyr)


BASE_URL <- "https://raw.githubusercontent.com"
REPO <- "mr-z-ro/msf-401k-hackathon-tools"
BRANCH <- "master"
FILE_FORMAT <- "csv"
DATA_FILES <- list(
  "GSK etf holders" = "GSK_etf_holders.csv",
  "GSK inst holders" = "GSK_inst_holders.csv",
  "GSK mfund holders" = "GSK_mfund_holders.csv",
  "PFE etf holders" = "PFE_etf_holders.csv",
  "PFE inst holders" = "PFE_inst_holders.csv",
  "PFE mfund holders" = "PFE_mfund_holders.csv",
  "mfund tickers" = "mfund_tickers.csv"
)


get_data <- function(data_file) {
  read_csv(url(
    file.path(BASE_URL, REPO, BRANCH, FILE_FORMAT, DATA_FILES[[data_file]])))
}
