class CreateDonations < ActiveRecord::Migration
  def up
    create_table :donations do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :amount
    end
  end
  def down
    drop_table :donations
  end
end
