class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :last_name
      t.string :first_name
      t.string :password
      t.string :priviliged, :default => false, :null => false

      t.timestamps
    end
  end
end
