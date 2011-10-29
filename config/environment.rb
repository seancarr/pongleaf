# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Pong::Application.initialize!

require 'elo_ratings'
EloRatings.players
