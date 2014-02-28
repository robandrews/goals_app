class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, :null => false
      t.integer :user_id, :null => false
      t.boolean :public, :default => true

      t.timestamps
    end
  end
end
