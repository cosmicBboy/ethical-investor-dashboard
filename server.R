shinyServer(function(input, output) {

  current_dataset <- reactive({
    # Make sure requirements are met
    req(input$data_file)
    get_data(input$data_file)
  })

  output$dataset <- renderUI({
    choices <- names(DATA_FILES)
    radioButtons(
      "data_file", "Select Dataset", selected = choices[1], choices = choices)
  })

  output$raw_view <- renderDataTable({
      current_dataset()
    },
    options = list(pageLength = 5)
  )

  output_plot <- reactive({
    print("CURRENT FILE")
    print(input$data_file)
  })

  output$plot_view <- renderPlotly({
    req(input$data_file)
    p <-  if (grepl("etf holders", input$data_file)) {
      plot_etf_holders(current_dataset())
    }
    else if (grepl("inst holders", input$data_file)) {
      plot_inst_holders(current_dataset())
    } else if (grepl("mfund holders", input$data_file)) {
      plot_mfund_holders(current_dataset())
    } else {
      ggplot()
    }
    plotly_build(ggplotly(p) %>%
      config(displayModeBar = FALSE))
  })

})


plot_etf_holders <- function(df) {
  names(df) <- c("ticker", "name", "category", "expense_ratio")
  ggplot(df, aes_string("category", "expense_ratio", text = "name")) +
    geom_point() +
    coord_flip() +
    scale_fill_brewer(palette="Set1") +
    ggtitle("Exchange-traded Funds Holding GSK/PFE") +
    theme_bw() +
    theme(panel.border = element_blank(),
          panel.grid.major.x = element_blank())
}

plot_inst_holders <- function(df) {
  names(df) <- c("name", "shares", "share value in 1K USD", "date_recorded")
  ggplot(df, aes_string("shares", "`share value in 1K USD`", text = "name")) +
    geom_point() +
    ggtitle("Institutions Holding GSK/PFE") +
    theme_bw() +
    theme(panel.border = element_blank())
}

plot_mfund_holders <- function(df) {
  names(df) <- c(
    "name", "shares", "% of all shares", "change num shares",
    "change %", "% total assets", "mfund ticker")
  ggplot(df, aes_string("shares", "`% of all shares`", text = "name")) +
    geom_point() +
    ggtitle("Mutual Funds Holding GSK/PFE") +
    theme_bw() +
    theme(panel.border = element_blank())
}
