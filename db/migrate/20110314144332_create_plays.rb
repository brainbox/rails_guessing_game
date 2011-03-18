class CreatePlays < ActiveRecord::Migration
  def self.up
    create_table :plays do |t|
      t.integer :the_number
      t.integer :your_guess
      t.integer :guesses
      t.string :won

      t.timestamps
    end
  end

  def self.down
    drop_table :plays
  end
end
