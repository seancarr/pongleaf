require 'elo_ratings'

class MatchesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    params[:match] ||= {}
    params[:match][:winner] = Player.find_or_create_by_name(params[:winner_name].downcase)
    params[:match][:loser] = Player.find_or_create_by_name(params[:loser_name].downcase)

    if params[:match][:winner].valid? &&params[:match][:loser].valid?
      match = Match.new(params[:match])
      match.save!
      EloRatings.add_match(match)
    else
      flash.alert = "Must specify a winner and a loser to post a match."
    end
    redirect_to matches_path
  end

  def destroy
    Match.find(params[:id]).destroy
    redirect_to matches_path
  end
  
  def index
    @match = Match.new
    @matches = Match.order("occured_at desc").includes([:winner, :loser])
  end

end
