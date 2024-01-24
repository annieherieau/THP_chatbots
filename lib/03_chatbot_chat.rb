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

# ____________ CONFIG
# définition de la configutation de la connexion API >> return Hash
def config_api_connexion(api_key,url)
  config = {
    api_key: api_key, 
    url: url,
    
    headers: {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"},
    
    data:  {
    "model" => "gpt-3.5-turbo-instruct",
    "prompt" => nil,
    "max_tokens" => 500,
    "n" => 1, #  nombre de réponses différentes
    # "stop" => ["\n"],
    "temperature" => 1 } 
  }
  return config
end
# ________ END of CONFIG



# sauvegarde dans l'historique des conversations >> return Integer ?? ou autre ?
def save_in_history(history, role, content)
  history.push({role: role, content:content})
  return history.length
end

# le prompt du user >> return String
def input_user_prompt
  user_prompt = gets.chomp
  return user_prompt
end

# debut de la conversation par l'AI: phrase d'amorce >> puts + return String
def start_conversation
  role = "AI"
  content = "Bonjour ! Comment puis-je t'aider?"
  puts "#{role} : #{content}"
  puts "(tape 'stop' pour arrêter)"
  return content
end


def converse_with_ai(config, prompt)
  # ajout du prompt
  config[:data]["prompt"] = prompt

  # envoi de la requete
  response = HTTP.post(config[:url], headers: config[:headers], body: config[:data].to_json)
  response_body = JSON.parse(response.body.to_s)
  response_string = response_body['choices'][0]['text'].strip

  return response_string
end

def my_chatbot
  config = config_api_connexion(ENV["OPENAI_API_KEY"], ENV["OPENAI_URL"])
  conversation_history= Array.new
  # début de la conversation: phrse de bien venue
  start_conversation #non enregistré dans l'historique

  user_prompt = ""
  # Boucle de la conversation
  loop do
    print "Vous : "
    user_prompt = input_user_prompt
    save_in_history(conversation_history,"Vous", user_prompt)

    # arrêt si le user écrit "stop"
    break if user_prompt.downcase == 'stop'
    
    ai_response = converse_with_ai(config, user_prompt)
    save_in_history(conversation_history, "AI", ai_response)
    puts "AI : #{ai_response}"

  end

end

my_chatbot


