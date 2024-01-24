# frozen_string_literal: true
# Gem PRY : outil de debuggage
require 'pry' # Appelle la gem Pry : use binding.pry cmd to execute pry at a specific place in your code . lancer pry dans le terminal

#______ keep the code above in each in project files lib/*.rb

# hello funcion
def hello
  puts "Hello world!"
  binding.pry
end