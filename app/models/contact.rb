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
  # accepts_nested_attributes_for :phone, :allow_destroy => true, :reject_if => :missing_phone_info
  has_many              :phones

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
