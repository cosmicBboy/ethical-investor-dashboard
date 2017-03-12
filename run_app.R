# # Reloads page whenever changes made to app files. Useful for development.
options(shiny.autoreload = TRUE)

# Get port from command line argument
port <- as.numeric(commandArgs(trailingOnly = TRUE)[1])
if (is.na(port)) {
  warning("Not a valid port: ", port, "\nDefaulting to port 8100")
  port <- 8100
}

# This is needed to prevent "Rplots.pdf" from being written to disk.
# For more information, see:
# http://stackoverflow.com/questions/6535927/how-do-i-prevent-rplots-pdf-from-being-generated
pdf(NULL)
shiny::runApp(".", host = "0.0.0.0", port = port)
