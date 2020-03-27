## LAFARGEHOLCIM - Collecte données performance Energetique
## 2020/03/27 - Essai de Connexion à la plateforme G2E Sud Est


## CREATION DU LIEN DE CONNEXION VERS EVELER
## -----------------------------------------

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
## -----------------------------------------


# Collecte de la liste des compteurs
Meters_List <- GET("https://suite.eveler.pro/api/client/meters", add_headers(accept = "application/json",Authorization = token_eveler))
Meters <- content(Meters_List, as = "parsed")

# Lecture du nombre de compteurs
Nb_Meters <- Meters$pagination$to

# Preparation Dataframe pour recevoir liste des compteurs
Meters_df <- data.frame(id=character(), 
                        nom_site=character())

# Extraction de la liste des compteurs
for (i in 1:Nb_Meters)
  {
      # Ligne de donnees
      new_line <- data.frame(id=Meters$data[[i]]$'_id', 
                             nom_site=Meters$data[[i]]$name)
      print(new_line)
      # Ajout de la ligne au DF
      Meters_df<- rbind(Meters_df,new_line)
  }


## FERMETURE DE LA CONNEXION
## -----------------------------------------
my_body<-paste0("https://suite.eveler.pro/api/client/auth/logout?token=",token) 
r <- POST(my_body)

