class AddInitialRatingToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :initial_rating, :integer, :null => true
  end

  def self.down
    remove_column :players, :initial_rating
  end
end
