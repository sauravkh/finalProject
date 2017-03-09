
library("dplyr")

data.folder <- "crunchbase_2013inCSV/"

cb_ipos <- read.csv(paste0(data.folder, "cb_ipos.csv"), quote = "", stringsAsFactors = FALSE)
cb_funding.rounds <- read.csv(paste0(data.folder, "cb_funding_rounds.csv"), quote = "", stringsAsFactors = FALSE)
cb_relationships <- read.csv(paste0(data.folder, "cb_relationships.csv"), quote = "", stringsAsFactors = FALSE)


funding.rounds.c <- filter(cb_funding.rounds, X.funding_round_type. == "'series-c+'") %>% 
  select(3)

funding.rounds.b <- filter(cb_funding.rounds, X.funding_round_type. == "'series-b'") %>% 
  select(3)

funding.rounds.a <- filter(cb_funding.rounds, X.funding_round_type. == "'series-a'") %>% 
  select(3)

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
funding.rounds.c <- funding.rounds.c[c.funding.without.ipo,]
funding.rounds.b <- funding.rounds.b[b.funding.without.ipo.or.c,]
funding.rounds.a <- funding.rounds.a[a.funding.without.ipo.or.c.or.b,]

#remove no longer necessary variables
remove(c.funding.without.ipo, b.funding.without.ipo.or.c, a.funding.without.ipo.or.c.or.b)

relationships <- filter(cb_relationships, grepl("c:", cb_relationships[4])) %>% 
  group_by(X.relationship_object_id.) %>% 
  summarise(Number = n())

funding.rounds.c <- mutate(relationships, Number)
