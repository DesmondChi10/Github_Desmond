#TD sur les graphics du 04/02/2025

library(dplyr)
data("starwars")
starwars
head(starwars)

install.packages("ggplot2")
library(ggplot2)

data <- starwars |> filter(!is.na(name) & !is.na(mass) & !is.na(eye_color) & !is.na(sex) & !is.na(hair_color))
head(data)
#Selectionner les données dont nous avons besoins pour notre histogram de masse selon les couleur de cheveux
data2 <- data |> select(mass, sex, hair_color)
ggplot(data2) + geom_histogram(aes(x = mass, fill = sex)) + theme_linedraw () + facet_grid (hair_color~.)

#Graphe illustrant la relation existante entre la masse et la taille des différents personnages de starwars
ggplot(data, aes(x = height, y = mass)) +
  geom_jitter(aes(fill = sex), width = 0.2, size = 3, alpha = 0.7, shape = 21) +
  scale_fill_manual(values = c("female" = "red", "male" = "blue")) +
  facet_grid(sex ~ .) + theme_grey() + geom_smooth (method= "lm", color="black")

  