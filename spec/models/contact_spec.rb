require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:middle_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:phone_type) }
    it { should validate_presence_of(:email) }
    it { should validate_format_of(:email).with(/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/) }
    it { should validate_uniqueness_of(:email) }
  end
end
