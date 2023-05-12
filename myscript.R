# get parameters from shell command
args <- commandArgs(trailingOnly = TRUE)

# check that all parameters are provided
if (length(args) < 2) {
  stop("Please provide CSVfile and column parameters")
}

# assign parameters to variables
CSVfile <- args[1]
column <- args[2]

# read data from CSV file
data <- read.csv(CSVfile)

# verify that column contains numerical data
if (!is.numeric(data[, column])) {
  stop("The specified column must contain numerical data")
}

# Compute statistics for selected column
stats <- c("mean", "median", "sd", "var", "sum", "quantile")

# Create summary data frame
summary_df <- data.frame(File = rep(CSVfile, length(stats)), Statistic = stats, Value = NA)

# Compute statistics and store in summary data frame
for (i in seq_along(stats)) {
  statistic <- stats[i]
  summary_stats <- switch(tolower(statistic),
    mean = mean(data[,column], na.rm = TRUE),
    median = median(data[,column], na.rm = TRUE),
    sd = sd(data[,column], na.rm = TRUE),
    var = var(data[,column], na.rm = TRUE),
    sum = sum(data[,column], na.rm = TRUE),
    quantile = paste(quantile(data[,column], na.rm = TRUE), collapse = ", "),
    "default" = stop(paste("Unsupported statistic:", statistic))
  )
  summary_df$Value[i] <- summary_stats
}

# Create CSV file name with .tmp extension
CSVfile_tmp <- paste0(tools::file_path_sans_ext(CSVfile), ".summary.csv")

# Save summary data frame as CSV
write.csv(summary_df, file = CSVfile_tmp, row.names = FALSE)

# Create PNG file name with .png extension
PNGfile <- paste0(tools::file_path_sans_ext(CSVfile), ".png")

# Create box plot and save to PNG file
png(PNGfile)
boxplot(data[,column], main = paste("Box plot of", column))
mtext(paste("File name:", CSVfile), side = 1, line = 2)
dev.off()