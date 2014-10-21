class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :points
      t.integer :idx

      t.timestamps
    end
  end
end
