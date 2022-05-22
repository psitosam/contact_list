class RemoveNumberFromContacts < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :number, :string
  end
end
