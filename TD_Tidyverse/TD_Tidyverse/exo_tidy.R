############################################################################
############################################################################
###################  ANALYSES - INDICATEURS  ###############################
############################################################################
############################################################################

## Date : 15/11/2024 
## Auteur : Desmond CHI

##########################################################################
########################### Fonction utiles ##############################
##########################################################################


library(tidyverse)

#%>% 
#|> 
#read_excel()
#select() avec start_with() par exemple
#filter()
#mutate()
#fct_recode()
#group_by_()
#summarise()
#left_join() right_join() inner_join() full_join()
#pivot_longer() pivot_wider()
# ...



##########################################################################
########################### Import #######################################
##########################################################################

library(readxl) #On télécharge et on charge la librairie readxl pour importer les données excel
Sites <- read_excel("TD_Tidyverse/TD_Tidyverse/Sites.xlsx")
Microorga <- read_excel("TD_Tidyverse/TD_Tidyverse/Microorganismes.xlsx")
Nematodes <- read_excel("TD_Tidyverse/TD_Tidyverse/Nematodes.xlsx")
Vers <- read_excel("TD_Tidyverse/TD_Tidyverse/Lombrics.xlsx")

##########################################################################
######################### Jointure de tables #############################
##########################################################################
########### CONSIGNE : Choisir deux communauté biologique ###########

#Assoicier sites à deux communutés
Sites %>%
  inner_join(.,Microorga,join_by(ID)) %>%
  inner_join(.,Nematodes,join_by(ID))-> SiteMN
#On doit associer deux communautés biologiques, Microorga & Nematodes, aux sites pour créer un nouveau ficher nomé SiteMN

##########################################################################
################## Sélection de lignes et colonnes ##################
##########################################################################
########### CONSIGNE : Choisir un site ###########
SiteMN %>%
  filter(SITE == "Feucherolles") %>%
  select(SITE:REPET_BLOC,ARGILE, contains("SABLE"),
         ends_with("MIN"),PHYTO:CARNI)-> FeMN
#Ici on veut filtré les données  des sites Feucherolles en selectionant des colonnes spécifiques qui nous intéressent et exporté ses données en FeMN
##########################################################################
####################### Créer des variables ##################
##########################################################################
FeMN %>%
  mutate(Pphyto=(PHYTO/(PHYTO+BACT+FONG+OMNI+CARNI))*100)-> FeMN2
View(FeMN2)
#Ici on modifie nos données dans FeMN en ajoutant une nouvelle colonne qui est le pourcentage de PHYTO qu'on nomme Pphyto
##########################################################################
############################## Calculs par groupe ########################
##########################################################################
########### CONSIGNE : calculs sur plusieurs variables en même temps######
FeMN2 %>%
  group_by(MODALITE_DESCR) %>%
  summarise(mean_Pp=mean(Pphyto), sd_Pp=sd(Pphyto))-> M_SD 
#nous avons grouper, reduit et puis clculer les moyenne et ecart types des pourcentages de PHYTO

##########################################################################
####################### Graphique ########################
##########################################################################
########### CONSIGNE : un graphique en modifiant l'ordre et en recodant des modalités
library(ggplot2)

ggplot(FeMN, aes(x=N_MIN, y=C_MIN)) + 
  geom_point() + 
  scale_y_reverse() #le graphe qui nous permet de visualiser la relation existante entre C_MIN et N_MIN

##########################################################################
######################## Pivots ##########################################
##########################################################################
SiteMN <- pivot_longer(SiteMN, cols= starts_with("LIMON_"),
                       values_to = "amount",
                       names_to="LIMON")-> Pv_SiteMN #exemple pivot_longer
#permet de ranger des données similaires classées en colonnes séparées dans une seule colonne
#les colonne concernée ici c'est LIMON_F & LIMON_G qu'on met sous la colonne LIMON
SiteMN_Pvw <- SiteMN %>% pivot_wider(names_from = LIMON, values_from = amount)
view(SiteMN_Pvw)
#On a dissocier à nouveau la colonne LIMON en LIMON_F & LIMON_G
##########################################################################
####################### Enchaîner tous les traitements ###################
##########################################################################


