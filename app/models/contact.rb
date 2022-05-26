class Contact < ApplicationRecord
  validates_presence_of :first_name,
                        :middle_name,
                        :last_name,
                        :street,
                        :city,
                        :state,
                        :zip
  validates             :email, format: { with: URI::MailTo::EMAIL_REGEXP},
                        :presence => {message: "can't be blank"}
  validates_format_of   :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many              :phones, dependent: :destroy # Phones in the phone db will be destroyed if their associated Contact is deleted.


  def self.call_list
    Contact.find_by_sql("SELECT contacts.* FROM contacts INNER JOIN phones ON phones.contact_id = contacts.id WHERE phones.phone_type = 0 ORDER BY contacts.last_name, contacts.first_name")
    # using ActiveRecord:
    # Contact.joins(:phones).where(phones: { phone_type: 0 }).order(:last_name, :first_name)
  end
end
