class CreatePhones < ActiveRecord::Migration[5.2]
  def change
    create_table :phones do |t|
      t.string :number
      t.integer :phone_type, default: 0
      t.references :contact, foreign_key: true
    end
  end
end
