require 'elo_ratings'
require 'google_chart'

class PlayersController < ApplicationController
  
  def index
    if params[:q]
      query = params[:q].downcase + '%'
      names = Player.where(["LOWER(name) LIKE ?", query]).collect(&:name)
    else
      names = Player.all.collect(&:name)
    end
    
    # names2 = names.collect(&:downcase).sort.uniq.collect(&:titleize).map{|n| "'#{n}'"}.join(",")
    # respond_to do |format|
    #   # format.js{render text: names.collect(&:downcase).sort.uniq.collect(&:titleize).join("\n")}
    #   format.js{render json: "{query:'#{params[:q]}',suggestions:[#{names2}], data:[#{names2}]}"}
    #   
    #   format.html
    # end
    
    render text: names.collect(&:downcase).sort.uniq.collect(&:titleize).join("\n")
  end
  
  def show
    @player = Player.find(params[:id])
    @matches = @player.matches.includes([:winner, :loser]).order("occured_at desc")
    @num_wins = @player.winning_matches.size
    @num_loses = @player.losing_matches.size
    @elo_player = EloRatings.get_elo_player(@player.id)
    
    ratings_by_date = EloRatings.ratings_by_date(@player.id)
    @ratings = ratings_by_date.map(&:last)
    
    # Line Chart
    @lc = GoogleChart::LineChart.new('550x200', "Rating Over Time", false) do |lc|
      lc.show_legend = false
      lc.data "Rating", @ratings, '3A74BA'
      lc.axis :y, :range => [@ratings.sort.first, @ratings.sort.last], :color => '3A74BA', :font_size => 16, :alignment => :center
      lc.axis :x, :labels => ratings_by_date.map(&:first), :color => '3A74BA', :font_size => 16, :alignment => :center
    end
  end
  
  def rankings
    @match = Match.new
    @ratings = EloRatings.players_by_rating
    @players_by_id = Player.all.index_by{|p| p.id}
  end
  
end
