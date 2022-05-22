class Phone < ApplicationRecord

  belongs_to :contact
  # validates_presence_of :number
  # validates_presence_of :phone_type
  enum phone_type: {
    home: 0,
    work: 1,
    mobile: 2
  }
end
