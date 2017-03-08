
library("dplyr")
cb_ipos <- read.csv("cb_ipos.csv", quote = "", stringsAsFactors = FALSE)
cb_funding.rounds <- read.csv("cb_funding_rounds.csv", quote = "", stringsAsFactors = FALSE)
cb_relationships <- read.csv("cb_relationships.csv", quote = "", stringsAsFactors = FALSE)


funding.rounds.c <- filter(cb_funding.rounds, X.funding_round_type. == "'series-c+'") %>% 
  select(3)

funding.rounds.b <- filter(cb_funding.rounds, X.funding_round_type. == "'series-b'") %>% 
  select(3)

funding.rounds.a <- filter(cb_funding.rounds, X.funding_round_type. == "'series-a'") %>% 
  select(3)


c.funding.with.ipo <- !funding.rounds.c$X.object_id. %in% cb_ipos$X.object_id.

funding.rounds.c <- funding.rounds.c[c.funding.with.ipo,]
