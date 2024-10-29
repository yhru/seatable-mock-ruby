# scripts/fetch_base_info.rb

require 'dotenv/load' # Charge les variables d'environnement
require 'seatable_ruby'
require 'json'

# Configuration de l'API SeaTable avec le token et les identifiants de compte
SeatableRuby.config do |c|
  c.api_token = ENV['SEATABLE_API_TOKEN']
end

# Création d'une instance BasicInfo pour récupérer les informations de la base
basic_info = SeatableRuby::BasicInfo.new

# Affiche les informations de base
puts JSON.pretty_generate(basic_info.basic_info)

