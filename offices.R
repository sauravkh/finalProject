source("startups.R")

#remove no longer necessary variables
remove(cb_funding.rounds, cb_relationships, data.complete, relationships, relationships.funding.a, relationships.funding.b,
       relationships.funding.c, relationships.ipo)

cb_offices <- read.csv(paste0(data.folder, "cb_offices2.csv"), quote = "", stringsAsFactors = FALSE)
cb_objects <- read.csv(paste0(data.folder, "cb_objects.csv"), quote = "", stringsAsFactors = FALSE)
cb_offices <- filter(cb_offices, X.country_code. == "'USA'", X.latitude. != "NULL") %>% 
  arrange(X.object_id.)
cb_offices$X.longitude. <- as.numeric(cb_offices$X.longitude.)
cb_offices$X.latitude. <- as.numeric(cb_offices$X.latitude.)

usa <- map_data("usa")

ipo.offices <- filter(cb_offices, X.object_id. %in% cb_ipos$X.object_id.)
series.c.offices <- filter(cb_offices, X.object_id. %in% funding.rounds.c$object_id)
series.b.offices <- filter(cb_offices, X.object_id. %in% funding.rounds.b$object_id)
series.a.offices <- filter(cb_offices, X.object_id. %in% funding.rounds.a$object_id)

everything <- ggplot(data = usa) + geom_point(aes(x = long, y = lat), size = 0.1) + labs(x=NULL, y=NULL) +
        geom_point(data = ipo.offices, aes(x = X.longitude., y = X.latitude.), color = "red", size = 0.5) + labs(x=NULL, y=NULL) + 
        geom_point(data = series.c.offices, aes(x = X.longitude., y = X.latitude.), color = "yellow", size = 0.5) + labs(x=NULL, y=NULL) + 
        geom_point(data = series.b.offices, aes(x = X.longitude., y = X.latitude.), color = "green", size = 0.5) + labs(x=NULL, y=NULL) + 
        geom_point(data = series.a.offices, aes(x = X.longitude., y = X.latitude.), color = "blue", size = 0.5) + labs(x=NULL, y=NULL) + 
        theme(axis.title = element_blank(),
              axis.text = element_blank(),
              axis.ticks = element_blank())
