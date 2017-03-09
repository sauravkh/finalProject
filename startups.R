library("dplyr")
library("ggplot2")

data.folder <- "crunchbase_2013inCSV/"

cb_ipos <- read.csv(paste0(data.folder, "cb_ipos.csv"), quote = "", stringsAsFactors = FALSE)
cb_funding.rounds <- read.csv(paste0(data.folder, "cb_funding_rounds.csv"), quote = "", stringsAsFactors = FALSE)
cb_relationships <- read.csv(paste0(data.folder, "cb_relationships.csv"), quote = "", stringsAsFactors = FALSE)
cb_funding.rounds <- filter(cb_funding.rounds, X.object_id. != "", X.funding_round_type. != "", X.raised_amount_usd. != "NULL")
cb_relationships <- filter(cb_relationships, X.relationship_object_id. != "")


funding.ipo <- filter(cb_funding.rounds, X.object_id. %in% cb_ipos$X.object_id.)%>% 
  select(3, 7)

funding.rounds.c <- filter(cb_funding.rounds, X.funding_round_type. == "'series-c+'") %>% 
  select(3, 7)

funding.rounds.b <- filter(cb_funding.rounds, X.funding_round_type. == "'series-b'") %>% 
  select(3, 7)

funding.rounds.a <- filter(cb_funding.rounds, X.funding_round_type. == "'series-a'") %>% 
  select(3, 7)

c.funding.without.ipo <- !funding.rounds.c$X.object_id. %in% cb_ipos$X.object_id.

b.funding.without.ipo.or.c <- !funding.rounds.b$X.object_id. %in% cb_ipos$X.object_id. &
  !funding.rounds.b$X.object_id. %in% funding.rounds.c$X.object_id.

a.funding.without.ipo.or.c.or.b <- !funding.rounds.a$X.object_id. %in% cb_ipos$X.object_id. &
  !funding.rounds.a$X.object_id. %in% funding.rounds.c$X.object_id. &
  !funding.rounds.a$X.object_id. %in% funding.rounds.b$X.object_id.

#character vectors that contain ids of companies under certain funding rounds
# they are exclusive, meaning that:
# companies that are in funding.rounds.a will not appear in funding.rounds.c or
#   funding.rounds.b because it is assumed that companies that made thier series c funding
#   would have gotten their series a funding anyway
funding.rounds.c <- filter(funding.rounds.c, c.funding.without.ipo)
funding.rounds.b <- filter(funding.rounds.b, b.funding.without.ipo.or.c)
funding.rounds.a <- filter(funding.rounds.a, a.funding.without.ipo.or.c.or.b)

#remove no longer necessary variables
remove(c.funding.without.ipo, b.funding.without.ipo.or.c, a.funding.without.ipo.or.c.or.b)

relationships <- group_by(cb_relationships, X.relationship_object_id.) %>% 
  summarise(Number = n())

relationships.ipo <- filter(relationships, relationships$X.relationship_object_id. %in% cb_ipos$X.object_id., Number < 100) 
relationships.funding.a <- filter(relationships, relationships$X.relationship_object_id. %in% funding.rounds.a$X.object_id., Number < 30)
relationships.funding.b <- filter(relationships, relationships$X.relationship_object_id. %in% funding.rounds.b$X.object_id., Number < 25)
relationships.funding.c <- filter(relationships, relationships$X.relationship_object_id. %in% funding.rounds.c$X.object_id., Number < 40)
none <- !relationships$X.relationship_object_id. %in% funding.rounds.a$X.object_id. & 
        !relationships$X.relationship_object_id. %in% funding.rounds.b$X.object_id. &
        !relationships$X.relationship_object_id. %in% funding.rounds.c$X.object_id. &
        !relationships$X.relationship_object_id. %in% cb_ipos$X.object_id.

none <- relationships[none,]

#plotting relationships vs. funding of ipo companies
colnames(relationships.ipo) <- c("object_id", "Number")
colnames(funding.ipo) <- c("object_id", "amount")

data.complete <- full_join(relationships.ipo, funding.ipo, na.rm = TRUE)

funding.and.relations.plot.ipos <- ggplot(data = data.complete) +
  geom_point(mapping = aes(x = Number, y = amount)) + 
  theme(axis.text = element_blank(),
        axis.ticks = element_blank()) + 
  labs(title="IPO & Relationships", y = "Amount of Funding", x = "Number of Relationships")

#plotting relationships vs. funding of series c companies
colnames(relationships.funding.c) <- c("object_id", "Number")
colnames(funding.rounds.c) <- c("object_id", "amount")

data.complete <- full_join(relationships.funding.c, funding.rounds.c, na.rm = TRUE)

funding.and.relations.plot.c <- ggplot(data = data.complete) +
  geom_point(mapping = aes(x = Number, y = amount)) + 
  theme(axis.text = element_blank(),
        axis.ticks = element_blank()) + 
  labs(title="C Funding & Relationships", y = "Amount of Funding", x = "Number of Relationships")


#plotting relationships vs. funding of series c companies
colnames(relationships.funding.b) <- c("object_id", "Number")
colnames(funding.rounds.b) <- c("object_id", "amount")

data.complete <- full_join(relationships.funding.b, funding.rounds.b, na.rm = TRUE)

funding.and.relations.plot.b <- ggplot(data = data.complete) +
  geom_point(mapping = aes(x = Number, y = amount)) + 
  theme(axis.text = element_blank(),
        axis.ticks = element_blank()) + 
  labs(title="B Funding & Relationships", y = "Amount of Funding", x = "Number of Relationships")


#plotting relationships vs. funding of series a companies
colnames(relationships.funding.a) <- c("object_id", "Number")
colnames(funding.rounds.a) <- c("object_id", "amount")

data.complete <- full_join(relationships.funding.a, funding.rounds.a, na.rm = TRUE)

funding.and.relations.plot.a <- ggplot(data = data.complete) +
  geom_point(mapping = aes(x = Number, y = amount))  + 
  theme(axis.text = element_blank(),
        axis.ticks = element_blank()) + 
  labs(title="A Funding & Relationships", y = "Amount of Funding", x = "Number of Relationships")


