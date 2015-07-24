class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username
      t.string :bio
      t.string :password
    end
  end
  def down
    drop_table :users
  end
end
