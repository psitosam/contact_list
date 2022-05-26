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
                        # :uniqueness => true NOTE: This validation caused failures with my contacts#create tests, as my database cleaner gem does not seem to clear the db as intended.
  validates_format_of   :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many              :phones
  # before_save           :normalize_phone

  def self.call_list
    Contact.find_by_sql("SELECT contacts.* FROM contacts INNER JOIN phones ON phones.contact_id = contacts.id WHERE phones.phone_type = 0 ORDER BY contacts.last_name, contacts.first_name")
    # using ActiveRecord:
    # Contact.joins(:phones).where(phones: { phone_type: 0 }).order(:last_name, :first_name)
  end
  # def normalize_phone
  #   self.phones.each do |phone|
  #     phone.number.gsub!(".", "-")
  #   end
  #   self.phones
  # end
  # def has_phone_type(type)
  #   contact = Contact.find(params[:id])
  #   contact.phones.each do |phone|
  #     phone.where(phone_type: type)
  #   end
  # end
  # def missing_phone_info
  #   contact_params.select { |k, v| v.blank? }
  # end
end
