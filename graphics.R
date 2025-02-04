#TD sur les graphics du 04/02/2025

library(dplyr)
data("starwars")
starwars
head(starwars)

install.packages("ggplot2")
library(ggplot2)

data <- starwars |> filter(!is.na(name) & !is.na(mass) & !is.na(eye_color))
head(data)
data2 <- data |> select(name, mass, eye_color) #Selectionner une partie des données à traiter
ggplot(data2) + geom_histogram(aes(x = mass, color = eye_color)) #histogramme des masses différentié par les coleurs des yeux

#Boxplot des sexes et coleur des yeux différentier selon les couleurs des cheveux
ggplot(data) + geom_boxplot(aes(x = sex, y = eye_color, fill = hair_color))
