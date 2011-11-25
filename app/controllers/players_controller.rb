require 'elo_ratings'

class PlayersController < ApplicationController
  
  def index
    if params[:q]
      query = params[:q].downcase + '%'
      names = Player.where(["LOWER(name) LIKE ?", query]).collect(&:name)
    else
      names = Player.all.collect(&:name)
    end
    
    render text: names.collect(&:downcase).sort.uniq.collect(&:titleize).join("\n")
  end
  
  def show
    @player = Player.find(params[:id])
    @matches = @player.matches.includes([:winner, :loser]).order("occured_at desc")
    @num_wins = @player.winning_matches.size
    @num_loses = @player.losing_matches.size
    @elo_player = EloRatings.get_elo_player(@player.id)
    
    @ratings_by_date = EloRatings.ratings_by_date(@player.id)
  end
  
  def rankings
    @match = Match.new
    @ratings = EloRatings.players_by_rating
    @players_by_id = Player.all.index_by{|p| p.id}
  end
  
end
