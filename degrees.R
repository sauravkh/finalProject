library("dplyr")
library("ggplot2")
library("plotly")
library("stringr")

degrees.data <- read.csv(file="crunchbase_2013inCSV/cb_degrees-1.csv", header=TRUE)
source("startups.R")

degrees.data <- select(degrees.data, 1, 2, 3, 4, 5, 6)
companies <- select(cb_relationships, 3, 4)

colnames(degrees.data) <- c("id", "object_id", "degree_type", "subject", "institution", "graduated_at")
colnames(companies) <- c("object_id", "relationship_id")

data.req <- full_join(degrees.data, companies, by = `object_id`)




#degrees.data$object_id <- str_replace(degrees.data$object_id, "p:", "")

degrees.data <- filter(degrees.data, degree_type == "MS" | degree_type == "BS" | degree_type == "PhD" | degree_type == "MBA")

data.MS <- filter(degrees.data, degree_type == "MS")

data.req <- right_join(companies, data.MS, by = "object_id")



data.BS <- filter(degrees.data, degree_type == "BS")
data.PhD <- filter(degrees.data, degree_type == "MS")
data.MBA <- filter(degrees.data, degree_type == "MS")


summary <- group_by(degrees.data, degree_type) %>%
  summarise(Number = n())

p <- ggplot(data = degrees.data) +
  geom_bar(mapping = aes(x = `degree_type`))

dropout <- filter(degrees.data, graduated_at == "NULL")

data.dropout <- filter(degrees.data, graduated_at == "NULL") %>%
  summarise(Number = n())

number.of.dropouts <- data.dropout[1,1]

data.total <- summarise(degrees.data, Number = n())

number.total <- data.total[1,1]

percent.dropout <- number.of.dropouts / number.total * 100

funding.rounds.a <-  str_replace(funding.rounds.a, "c:", "")
funding.rounds.a <-  str_replace(funding.rounds.a, "'", "")
funding.rounds.a <-  str_replace(funding.rounds.a, "'", "")

funding.rounds.b <-  str_replace(funding.rounds.b, "c:", "")
funding.rounds.b <-  str_replace(funding.rounds.b, "'", "")
funding.rounds.b <-  str_replace(funding.rounds.b, "'", "")

funding.rounds.c <-  str_replace(funding.rounds.c, "c:", "")
funding.rounds.c <-  str_replace(funding.rounds.c, "'", "")
funding.rounds.c <-  str_replace(funding.rounds.c, "'", "")

success.a <- degrees.data$object_id %in% funding.rounds.a
success.b <- degrees.data$object_id %in% funding.rounds.b
success.c <- degrees.data$object_id %in% funding.rounds.c

success.a.data <- degrees.data[success.a, ]
success.b.data <- degrees.data[success.b, ]
success.c.data <- degrees.data[success.c, ]






