source("startups.R")

#remove no longer necessary variables
remove(cb_funding.rounds, cb_relationships, data.complete, relationships, relationships.funding.a, relationships.funding.b,
       relationships.funding.c, relationships.ipo)

cb_offices <- read.csv(paste0(data.folder, "cb_offices2.csv"), quote = "", stringsAsFactors = FALSE)
cb_objects <- read.csv(paste0(data.folder, "cb_objects.csv"), quote = "", stringsAsFactors = FALSE)
cb_offices <- filter(cb_offices, X.country_code. == "'USA'", X.latitude. != "NULL") %>% 
  arrange(X.object_id.)

ipo.offices <- filter(cb_offices, X.object_id. %in% cb_ipos$X.object_id.)
series.c.offices <- filter(cb_offices, X.object_id. %in% funding.rounds.c$object_id)
series.b.offices <- filter(cb_offices, X.object_id. %in% funding.rounds.b$object_id)
series.a.offices <- filter(cb_offices, X.object_id. %in% funding.rounds.a$object_id)


#ggplot(data = cb_offices) + geom_point(aes(x = X.latitude., y = X.longitude.), size = 0.5) + labs(x=NULL, y=NULL)

ipo <- ggplot(data = ipo.offices) + geom_point(aes(x = X.latitude., y = X.longitude.), size = 0.5) + labs(x=NULL, y=NULL) + 
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
c <- ggplot(data = series.c.offices) + geom_point(aes(x = X.latitude., y = X.longitude.), size = 0.5) + labs(x=NULL, y=NULL) + 
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())

b <- ggplot(data = series.b.offices) + geom_point(aes(x = X.latitude., y = X.longitude.), size = 0.5) + labs(x=NULL, y=NULL) + 
       geom_point(data = series.a.offices, aes(x = X.latitude., y = X.longitude.), size = 0.5) + labs(x=NULL, y=NULL) + 
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
