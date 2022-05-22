class RemovePhoneTypeFromContacts < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :phone_type, :string
  end
end
