class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :gender
      t.integer :age
      t.string :city
      t.string :province
      t.string :job
      t.integer :income

      t.timestamps
    end
  end
end
