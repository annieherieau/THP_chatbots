# frozen_string_literal: true
# Gem PRY : outil de debuggage
require 'pry' # Appelle la gem Pry : use binding.pry cmd to execute pry at a specific place in your code
# gem HTTP
require 'http'
require 'json'

# Gem DOTENV : sécuriser / masquer les clés API
require 'dotenv'# Appelle la gem Dotenv
Dotenv.load # Ceci appelle le fichier .env qui contien toutes les clés API enregistrées dans un hash ENV[key]
# puts ENV['OPENAI_API']

#______ keep the code above in each in project files lib/*.rb


#_________ CHATBOT Recettes

# création de la clé d'api et indication de l'url utilisée.
api_key = ENV["OPENAI_API_KEY"]
url = ENV["OPENAI_URL"]

# un peu de json pour faire la demande d'autorisation d'utilisation à l'api OpenAI
headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

# un peu de json pour envoyer des informations directement à l'API
data = {
  "model" => "gpt-3.5-turbo-instruct",
  "prompt" => "donne-moi une recette de cuisine facile, je veux la liste des étapes de réalisation, mais pas de liste des ingrédients",
  "max_tokens" => 200,
  "n" => 1, #  nombre de réponses différentes
  # "stop" => ["\n"], # point d'arrêt de la réponse
  "temperature" => 0.5 # de 0 cohérent à 1 créatif
}

# une partie un peu plus complexe :
# - cela permet d'envoyer les informations en json à ton url
# - puis de récupéré la réponse puis de séléctionner spécifiquement le texte rendu
response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)
response_string = response_body['choices'][0]['text'].strip

# ligne qui permet d'envoyer l'information sur ton terminal
puts "Voici une recette de cuisine facile :"
puts response_string