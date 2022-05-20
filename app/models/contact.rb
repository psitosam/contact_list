class Contact < ApplicationRecord
  validates_presence_of :first_name,
                        :middle_name,
                        :last_name,
                        :street,
                        :city,
                        :state,
                        :zip,
                        :number,
                        :phone_type, default: "home"
  validates             :email, format: { with: URI::MailTo::EMAIL_REGEXP},
                        :presence => {message: "can't be blank"},
                        :uniqueness => true
  validates_format_of   :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
