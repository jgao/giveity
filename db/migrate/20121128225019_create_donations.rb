class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :time
      t.integer :money
      t.integer :user_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
