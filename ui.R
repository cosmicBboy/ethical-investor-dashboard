dashboardPage(
  dashboardHeader(title = "MSF 401K Dashboard"),
  dashboardSidebar(
    uiOutput("dataset")),
  dashboardBody(
    plotlyOutput("plot_view"),
    dataTableOutput("raw_view")
  ),
  skin = "red"
)
