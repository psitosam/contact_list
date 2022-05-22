class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :contacts, :type, :phone_type
  end
end
# I ran into problems with ActiveRecord when I named a column "type" on the contacts table and then tried to do things with it. To quote the error message: "This error is raised because the column 'type' is reserved for storing the class in case of inheritance". So I've made this migration to work around that with what I hope is a somewhat intuitive column name. 
