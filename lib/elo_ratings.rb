class EloRatings
  
  @@players = nil
  
  def self.add_match(match)
    add_match_to_players(match, players)
  end
  
  def self.get_elo_player(player_id)
    get_elo_player_from_players(player_id, players)
  end
  
  def self.players_by_rating
    players_by_rating_from_players(players)
  end
  
  def self.players
    if @@players.nil?
      @@players = Hash.new
      Match.order("occured_at asc").each do |match|
        add_match(match)
      end
    end
    @@players
  end
  
  def self.ratings_by_date(player_id)
    local_players = Hash.new
    all_matches = Match.order("occured_at asc")
    ratings = {}
    all_matches.each_with_index do |match, idx|
      add_match_to_players(match, local_players)
      if ([match.winner_id, match.loser_id].include?(player_id))
        ratings[match.occured_at.to_date.to_s(:db)] = local_players[player_id].rating
      end
    end
    ratings.to_a.sort
  end
  
  private
  
  def self.add_match_to_players(match, local_players)
    winner = get_elo_player_from_players(match.winner_id, local_players)
    loser = get_elo_player_from_players(match.loser_id, local_players)
    
    winner.wins_from(loser)
  end
  
  def self.get_elo_player_from_players(player_id, local_players)
    local_players[player_id] ||= Elo::Player.new
  end
  
  def self.players_by_rating_from_players(local_players)
    local_players.to_a.sort_by{|player_id, elo| elo.rating}.reverse
  end
  
end
