source("startups.R")

#remove no longer necessary variables
remove(cb_funding.rounds, cb_ipos, cb_relationships, data.complete, relationships, relationships.funding.a, relationships.funding.b,
       relationships.funding.c, relationships.ipo)

cb_offices <- read.csv(paste0(data.folder, "cb_offices2.csv"), quote = "", stringsAsFactors = FALSE)
cb_objects <- read.csv(paste0(data.folder, "cb_objects.csv"), quote = "", stringsAsFactors = FALSE)
cb_offices <- filter(cb_offices, X.country_code. == "'USA'", X.latitude. != "NULL") %>% 
  arrange(X.object_id.)

