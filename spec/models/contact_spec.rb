require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject { build(:contact) }
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:middle_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:email) }
    # it { should validate_uniqueness_of(:email) }
  end

  describe 'relationships' do
    it { should have_many(:phones) }
  end
end
