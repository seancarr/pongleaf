module MatchesHelper
  
  def calculate_rankings(matches)
    cached_elo_players = Hash.new{|h,k| h[k] = Elo::Player.new}
    
    matches.each do |match|
      elo_winner = cached_elo_players[match.winner.display_name]
      elo_loser = cached_elo_players[match.loser.display_name]
      
      elo_winner.wins_from(elo_loser)
    end
    
    cached_elo_players.to_a.sort_by{|name, elo| elo.rating}.reverse
  end
  
end
