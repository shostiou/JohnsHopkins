## LAFARGEHOLCIM - Collecte données performance Energetique
## 2020/03/27 - Essai de Connexion à la plateforme G2E Sud Est
## CREATION DU LIEN DE CONNEXION VERS EVELER

## Appel de la bibliothèque HTTR
library(httr)

# Passage des identifiants de l'API
token ='yeBXLcvzROpKkF8DoNSUsPucCIQoQVVTHBNRSvFKv9A'
secret = 'q3JGsAh3uYNEgtoqvamb1XGUGK2C6fsmwDXxKiv7qBw'

my_body<-paste0("https://suite.eveler.pro/api/client/auth/login?token=",token,"&secret=",secret) 
r <- POST(my_body)

# Affichage du code de statut de la connexion
paste("Code réponse :", status_code(r))

# Entête de la réponse
print("Type de contenu :")
print(headers(r))

# Reponse et recupeation des donnes json
library(jsonlite)
r_json=content(r)
# Recuperation du token
token_eveler <- r_json$data$token
paste("Token reçu :", token_eveler)


## ENVOI DE REQUETES VERS LE SITE
## ===============================

# Collecte de la liste des compteurs
Meters_List <- GET("https://suite.eveler.pro/api/client/meters", add_headers(accept = "application/json",Authorization = token_eveler))
Meters <- content(Meters_List, as = "parsed")

# Preparation du DF de reception
# Preparation Dataframe pour recevoir liste des compteurs
Meters_df <- data.frame(meter_id = character(),
                        client_id=character(),
                        site_id=character(),
                        name=character(),
                        rae=character(),
                        type=character(),
                        stringsAsFactors = FALSE)

# Lecture du nombre de compteurs
Nb_Meters <- Meters$pagination$to

# Construction du DF de Reception des donnees
for (i in 1:Nb_Meters)
{
  # Ligne de donnees
  new_line <- data.frame(meter_id =Meters$data[[i]]$'_id', 
                         client_id=Meters$data[[i]]$client_id,
                         site_id=Meters$data[[i]]$site_id,
                         name=Meters$data[[i]]$name,
                         rae=Meters$data[[i]]$rae,
                         type=Meters$data[[i]]$type)
  # Ajout de la ligne au DF
  Meters_df <- rbind(Meters_df,new_line)
}

# Conversion de Factor vers Character des colonnes du DF
Meters_df[] <- lapply(Meters_df, as.character)
head(Meters_df)


## COLLECTE DE DONNEES DETAILLEES DES COMPTEURS
## ============================================


### Selection d'un compteur specifique
compteur_id = Meters_df$meter_id[6]
# Construction et emission de la requete
my_body <- paste0("https://suite.eveler.pro/api/client/meter/",compteur_id,"/indexes")
Meter_Index <- GET(my_body, add_headers(accept = "application/json", Authorization = token_eveler))
# Decodage de la reponse
Meter_Index_lst <- content(Meter_Index, as = "parsed")

# Conversion de la liste en DF
Meter_Index_df <- as.data.frame(Meter_Index_lst$data[[1]])

# Ajout d'une colonne dans le DF avec le nom du site et l'id du compteur
Meter_Index_df$Meter_id <- Meters_df[Meters_df$meter_id==compteur_id,]$meter_id
Meter_Index_df$name <- Meters_df[Meters_df$meter_id==compteur_id,]$name
print(colnames(Meter_Index_df))

## CREATION D'UNE BOUCLE POUR COLLECTER L'ENSEMBLE DES DONNEES
## ============================================================

## Initialisation du DF Global
Meter_df_global_ICE <- data.frame()

## Construction du bouclage uniquement pour compteurs ICE
for (my_index in Meters_df[Meters_df$type=="ICE",]$meter_id)
  {
  
  ## Suivi Evolution
  print(my_index)
  
  ### Selection d'un compteur specifique
  compteur_id = my_index
  # Construction et emission de la requete
  my_body <- paste0("https://suite.eveler.pro/api/client/meter/",compteur_id,"/indexes")
  Meter_Index <- GET(my_body, add_headers(accept = "application/json",Authorization = token_eveler))
  # Decodage de la reponse
  Meter_Index_lst <- content(Meter_Index, as = "parsed")
  
  # Conversion de la liste en DF
  Meter_df <- as.data.frame(Meter_Index_lst$data[[1]])
  
  # Ajout d'une colonne dans le DF avec le nom du site et l'id du compteur
  Meter_df$Meter_id <- Meters_df[Meters_df$meter_id==compteur_id,]$meter_id
  Meter_df$name <- Meters_df[Meters_df$meter_id==compteur_id,]$name
  
  print(colnames(Meter_df))
  paste("nb_col",ncol(Meter_df),my_index)
  #Meter_df_global_ICE <- rbind(Meter_df_global_ICE,Meter_df)
  }



## FERMETURE DE LA CONNEXION
## -----------------------------------------
my_body<-paste0("https://suite.eveler.pro/api/client/auth/logout?token=",token) 
r <- POST(my_body)


