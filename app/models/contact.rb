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
end
