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

# login to open ai
def login_openai
  # création de la clé d'api et indication de l'url utilisée.
  api_key = ENV["OPENAI_API_KEY"]
  url = ENV["OPENAI_URL"]

  # un peu de json pour faire la demande d'autorisation d'utilisation à l'api OpenAI
  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"
  }

  reponse = HTTP.get(url, headers: headers)
  return reponse
end
