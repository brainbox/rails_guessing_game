class AddGuessesToGame < ActiveRecord::Migration
  def self.up
    add_column :games, :guesses, :integer
  end

  def self.down
    remove_column :games, :guesses
  end
end
