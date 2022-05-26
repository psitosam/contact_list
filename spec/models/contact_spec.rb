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

  describe 'attributes, instance and class methods' do
    it 'phone attribute should initialize as an empty array' do
      contact = create :contact
      expect(contact.phone).to eq([])
    end

    it 'should be able to read associated phones from the database' do
      contact_1 = create :contact
      phone_1 = create :phone, { contact_id: contact_1.id }
      phone_2 = create :phone, { phone_type: 2, contact_id: contact_1.id }

      expect(contact_1.phones.length).to eq(2)
      expect(contact_1.phones[0].phone_type).to eq("home")
      expect(contact_1.phones[1].phone_type).to eq("mobile")
    end

    it 'generates a call list of contacts that have a home number listed' do
      # contacts = (
      #   contact_1 = create :contact
      #   phone_1 = create :phone, { contact_id: contact_1.id } #home number
      #   phone_2 = create :phone, { phone_type: 2, contact_id: contact_1.id } #mobile number
      #
      #   contact_2 = create :contact
      #   phone_3 = create :phone, { contact_id: contact_2.id } #home number
      #   phone_4 = create :phone, { phone_type: 2, contact_id: contact_2.id } #mobile number
      #
      #   contact_3 = create :contact
      #   phone_5 = create :phone, { phone_type: 2, contact_id: contact_3.id } #mobile number
      #
      #   contact_4 = create :contact
      #   phone_6 = create :phone, { contact_id: contact_4.id } #home number
      #   phone_7 = create :phone, { phone_type: 2, contact_id: contact_4.id } #mobile number
      # )
      contact_1 = Contact.create(first_name: "India", middle_name: "Corwin", last_name: "Lynch", street: "612 Cyndy Coves", city: "Howellton", state: "Oklahoma", zip: "41265-1557", phone: [], email: "ernest@simonis-wolf.org")
      phone_1 = Phone.create(number: "937-262-3861", phone_type: "mobile", contact_id: contact_1.id)
      #contact_1 has only a mobile number, non-select expected

      contact_2 = Contact.create(first_name: "Thea", middle_name: "Fisher", last_name: "Kuhn", street: "926 Kimberly Road", city: "North Billy", state: "Maine", zip: "03740-3342", phone: [], email: "ericka_beahan@hermann-tromp.io")
      phone_2 = create :phone, { contact_id: contact_2.id }
      phone_6 = create :phone, { phone_type: "mobile", contact_id: contact_2.id }
      # contact_2 has both a home number and a mobile number

      contact_3 = Contact.create(first_name: "Sherita", middle_name: "Graham", last_name: "Treutel", street: "6669 Williamson Square", city: "Port Erna", state: "New Mexico", zip: "60239-2314", phone: [], email: "nobuko.pfeffer@buckridge.com")
      phone_3 = create :phone, { phone_type: "work", contact_id: contact_3.id }
      # contact_3 has only a work number, non-select expected

      contact_4 = Contact.create(first_name: "Janeen", middle_name: "McCullough", last_name: "Quigley", street: "9166 McKenzie Square", city: "Friesenborough", state: "Iowa", zip: "00050-1101", phone: [], email: "leigh@okeefe-franecki.com")
      phone_4 = create :phone, { contact_id: contact_4.id }
      phone_7 = create :phone, { phone_type: "work", contact_id: contact_4.id }
      # contact_4 has both home and work numbers

      contact_5 = Contact.create(first_name: "Long", middle_name: "Breitenberg", last_name: "Wolff", street: "224 Grant Islands", city: "Port Trentburgh", state: "New Hampshire", zip: "62350-2289", phone: [], email: "ronny@cole.name")
      phone_5 = create :phone, { contact_id: contact_5.id }
      # contact_5 has only a home number
      

      expected = ([contact_2, contact_4, contact_5])

      expect(Contact.call_list).to eq(expected)

    end
  end
end
