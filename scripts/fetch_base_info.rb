# scripts/fetch_base_info.rb

require 'dotenv/load' # Charge les variables d'environnement
require 'seatable_ruby'
require 'json'

# Configuration de l'API SeaTable avec le token et les identifiants de compte
SeatableRuby.config do |c|
  c.api_token = ENV['SEATABLE_API_TOKEN']
  c.account_credentials = {
    username: ENV['SEATABLE_USERNAME'],
    password: ENV['SEATABLE_PASSWORD']
  }
end

# Création d'une instance BasicInfo pour récupérer les informations de la base
basic_info = SeatableRuby::BasicInfo.new

# Affiche les informations de base
puts basic_info.basic_info
