class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :number
      t.string :type
      t.string :email

      t.timestamps
    end
  end
end
