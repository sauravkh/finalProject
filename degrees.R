library("dplyr")
library("ggplot2")
library("plotly")
library("stringr")

degrees.data <- read.csv(file="crunchbase_2013inCSV/cb_degrees-1.csv", header=TRUE)
source("startups.R")

# Select required/relevant columns from the data frame
degrees.data <- select(degrees.data, 1, 2, 3, 4, 5, 6)
companies <- select(cb_relationships, 3, 4)

# Reassigns column names to in a better format
colnames(degrees.data) <- c("id", "object_id", "degree_type", "subject", "institution", "graduated_at")
colnames(companies) <- c("object_id", "relationship_id")

# Remove single quote from the companies data frame
companies$object_id <- str_replace(companies$object_id , "'", "")
companies$object_id <- str_replace(companies$object_id , "'", "")
companies$relationship_id <- str_replace(companies$relationship_id , "'", "")
companies$relationship_id <- str_replace(companies$relationship_id , "'", "")

# Joins the degrees.data and companies data fram by object_id
degrees.data <- full_join(degrees.data, companies, by = "object_id")

# Filter out unnecessary data
degrees.data <- filter(degrees.data, degree_type == "MS" | degree_type == "BS" | degree_type == "PhD" | degree_type == "MBA")

# Filter out the data for various degrees to different data frames
data.MS <- filter(degrees.data, degree_type == "MS")
data.BS <- filter(degrees.data, degree_type == "BS")
data.PhD <- filter(degrees.data, degree_type == "PhD")
data.MBA <- filter(degrees.data, degree_type == "MBA")

# Compute the total number of people in each degree
summary <- group_by(degrees.data, degree_type) %>%
  summarise(Number = n())

# Plot total number of people in each degree
plot.total <- ggplot(data = degrees.data) +
  geom_bar(mapping = aes(x = `degree_type`))

# Filter out the data for people who dropped out
dropout <- filter(degrees.data, graduated_at == "NULL")

# Compute the number of dropouts
data.dropout <- filter(degrees.data, graduated_at == "NULL") %>%
  summarise(Number = n())
number.of.dropouts <- data.dropout[1,1]

# Compute total number of employees
data.total <- summarise(degrees.data, Number = n())
number.total <- data.total[1,1]

# Compute percent of dropouts
percent.dropout <- number.of.dropouts / number.total * 100

# Remove single quote from the data frames of funding rounds
funding.rounds.a$object_id <- str_replace(funding.rounds.a$object_id, "'", "")
funding.rounds.b$object_id <- str_replace(funding.rounds.b$object_id, "'", "")
funding.rounds.c$object_id <- str_replace(funding.rounds.c$object_id, "'", "")
funding.ipo$object_id <- str_replace(funding.ipo$object_id, "'", "")
funding.rounds.a$object_id <- str_replace(funding.rounds.a$object_id, "'", "")
funding.rounds.b$object_id <- str_replace(funding.rounds.b$object_id, "'", "")
funding.rounds.c$object_id <- str_replace(funding.rounds.c$object_id, "'", "")
funding.ipo$object_id <- str_replace(funding.ipo$object_id, "'", "")

# Reassign column names in a proper format
colnames(funding.rounds.a) <- c("relationship_id", "amount")
colnames(funding.rounds.b) <- c("relationship_id", "amount")
colnames(funding.rounds.c) <- c("relationship_id", "amount")
colnames(funding.ipo) <- c("relationship_id", "amount")

# Joins the data frame to add the value of amount funded to each table
success.BS.a.data <- full_join(data.BS, funding.rounds.a, na.rm = TRUE) %>%
  na.omit()
success.MS.a.data <- full_join(data.MS, funding.rounds.a, na.rm = TRUE) %>%
  na.omit()
success.MBA.a.data <- full_join(data.MBA, funding.rounds.a, na.rm = TRUE) %>%
  na.omit()
success.PhD.a.data <- full_join(data.PhD, funding.rounds.a, na.rm = TRUE) %>%
  na.omit()

# Compute number of succesful in each degree
number.BS.success.a <- summarise(success.BS.a.data, n())[1,1]
number.MBA.success.a <- summarise(success.MBA.a.data, n())[1,1]
number.MS.success.a <- summarise(success.MS.a.data, n())[1,1]
number.PhD.success.a <- summarise(success.PhD.a.data, n())[1,1]

# Plot the number of successful in each degree
success.a.plot <- plot_ly(
  x = c("BS", "MBA", "MS", "PhD"),
  y = c(number.BS.success.a, number.MBA.success.a, number.MS.success.a, number.PhD.success.a),
  name = "Success Rate and education",
  type = "bar"
)

# Joins the data frame to add the value of amount funded to each table
success.BS.ipo.data <- full_join(data.BS, funding.ipo, na.rm = TRUE) %>%
  na.omit()

success.MS.ipo.data <- full_join(data.MS, funding.ipo, na.rm = TRUE) %>%
  na.omit()

success.MBA.ipo.data <- full_join(data.MBA, funding.ipo, na.rm = TRUE) %>%
  na.omit()

success.PhD.ipo.data <- full_join(data.PhD, funding.ipo, na.rm = TRUE) %>%
  na.omit()

# Compute number of succesful in each degree
number.BS.success.ipo <- summarise(success.BS.ipo.data, n())[1,1]
number.MBA.success.ipo <- summarise(success.MBA.ipo.data, n())[1,1]
number.MS.success.ipo <- summarise(success.MS.ipo.data, n())[1,1]
number.PhD.success.ipo <- summarise(success.PhD.ipo.data, n())[1,1]

# Plot the number of successful in each degree
success.ipo.plot <- plot_ly(
  x = c("BS", "MBA", "MS", "PhD"),
  y = c(number.BS.success.ipo, number.MBA.success.ipo, number.MS.success.ipo, number.PhD.success.ipo),
  name = "Success Rate and education",
  type = "bar"
)

# Joins the data frame to add the value of amount funded to each table
success.BS.b.data <- full_join(data.BS, funding.rounds.b, na.rm = TRUE) %>%
  na.omit()

success.MS.b.data <- full_join(data.MS, funding.rounds.b, na.rm = TRUE) %>%
  na.omit()

success.MBA.b.data <- full_join(data.MBA, funding.rounds.b, na.rm = TRUE) %>%
  na.omit()

success.PhD.b.data <- full_join(data.PhD, funding.rounds.b, na.rm = TRUE) %>%
  na.omit()

# Compute number of succesful in each degree
number.BS.success.b <- summarise(success.BS.b.data, n())[1,1]
number.MBA.success.b <- summarise(success.MBA.b.data, n())[1,1]
number.MS.success.b <- summarise(success.MS.b.data, n())[1,1]
number.PhD.success.b <- summarise(success.PhD.b.data, n())[1,1]

# Plot the number of successful in each degree
success.b.plot <- plot_ly(
  x = c("BS", "MBA", "MS", "PhD"),
  y = c(number.BS.success.b, number.MBA.success.b, number.MS.success.b, number.PhD.success.b),
  name = "Success Rate and education",
  type = "bar"
)

# Joins the data frame to add the value of amount funded to each table
success.BS.c.data <- full_join(data.BS, funding.rounds.c, na.rm = TRUE) %>%
  na.omit()

success.MS.c.data <- full_join(data.MS, funding.rounds.c, na.rm = TRUE) %>%
  na.omit()

success.MBA.c.data <- full_join(data.MBA, funding.rounds.c, na.rm = TRUE) %>%
  na.omit()

success.PhD.c.data <- full_join(data.PhD, funding.rounds.c, na.rm = TRUE) %>%
  na.omit()

# Compute number of succesful in each degree
number.BS.success.c <- summarise(success.BS.c.data, n())[1,1]
number.MBA.success.c <- summarise(success.MBA.c.data, n())[1,1]
number.MS.success.c <- summarise(success.MS.c.data, n())[1,1]
number.PhD.success.c <- summarise(success.PhD.c.data, n())[1,1]

# Plot the number of successful in each degree
success.c.plot <- plot_ly(
  x = c("BS", "MBA", "MS", "PhD"),
  y = c(number.BS.success.c, number.MBA.success.c, number.MS.success.c, number.PhD.success.c),
  name = "Success Rate and education",
  type = "bar"
)








