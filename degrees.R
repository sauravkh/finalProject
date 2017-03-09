library("dplyr")
library("ggplot2")
library("plotly")

degrees.data <- read.csv(file="data/crunchbase_2013inCSV/cb_degrees-1.csv", header=TRUE)

degrees.data <- select(degrees.data, 1, 2, 3, 4, 5, 6)
colnames(degrees.data) <- c("id", "object_id", "degree_type", "subject", "institution", "graduated_at")

degrees.data <- filter(degrees.data, degree_type == "MS" | degree_type == "BS" | degree_type == "PhD" | degree_type == "MBA") 

summary <- group_by(degrees.data, degree_type) %>%
  summarise(Number = n())

p <- ggplot(data = degrees.data) +
  geom_bar(mapping = aes(x = `degree_type`))

data.dropout <- filter(degrees.data, graduated_at == "NULL") %>%
  summarise(Number = n())

number.of.dropouts <- data.dropout[1,1]

data.total <- summarise(degrees.data, Number = n())

number.total <- data.total[1,1]

percent.dropout <- number.of.dropouts / number.total * 100



