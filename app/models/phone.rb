class Phone < ApplicationRecord

  belongs_to :contact
  validates_presence_of :number
  validates_presence_of :phone_type
  enum phone_type: {
    home: 0,
    work: 1,
    mobile: 2
  }

  # def create
  #   Phone.new(phone_params)
  # end
  #
  # private
  #   def phone_params
  #     params.permit(:number, :phone_type)
  #   end
end
