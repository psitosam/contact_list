require 'rails_helper'

RSpec.describe Phone, type: :model do
    describe 'validations' do
      it { should validate_presence_of(:number) }
      it { should validate_presence_of(:phone_type) }
    end

    describe 'relationships' do
      it { should belong_to(:contact) }
    end
end
