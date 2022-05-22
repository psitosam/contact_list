require 'rails_helper'

RSpec.describe 'the contacts API' do
  it 'returns index of all contacts' do
    contact_1 = create :contact
    phone_1 = create :phone, { contact_id: contact_1.id }
    contact_2 = create :contact
    phone_2 = create :phone, { contact_id: contact_2.id }
    contact_3 = create :contact
    phone_3 = create :phone, { contact_id: contact_3.id }
    contact_4 = create :contact
    phone_4 = create :phone, { contact_id: contact_4.id }
    contact_5 = create :contact
    phone_5 = create :phone, { contact_id: contact_5.id }

    # Here I am using FactoryBot to create test data that conforms to the specifications in the challenge documentation. Please see ./spec/factories/contact.rb for more information. It is using the faker gem documented here: https://github.com/faker-ruby/faker#deterministic-random

    get "/api/v1/contacts"

    parsed = JSON.parse(response.body, symbolize_names: true)
    contacts = parsed[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(contacts.class).to eq(Array)
    expect(contacts.length).to eq(5)
    #Testing that the request returns success, and that it is coming back as an Array with each Contact being an element within that Array. Now we iterate through that array checking for the presence of all required key/value pairs:

    contacts.each do |contact|
      expect(contact).to have_key(:attributes)
      expect(contact[:attributes][:name][:last]).to be_a String
      expect(contact[:attributes][:name][:middle]).to be_a String
      expect(contact[:attributes][:name][:first]).to be_a String
      expect(contact[:attributes][:address][:street]).to be_a String
      expect(contact[:attributes][:address][:city]).to be_a String
      expect(contact[:attributes][:address][:state]).to be_a String
      expect(contact[:attributes][:address][:zip]).to be_a String

      expect(contact[:attributes][:phone][0][:number]).to be_a String
      #The Contact to Phone relationship
      expect(contact[:attributes][:phone][0][:phone_type]).to eq("home")
      expect(contact[:attributes][:email]).to be_a String
      # Validation for the formatting of email addresses is checked in the Model: ./app/models/contact.rb

    end
  end

  context 'show' do
    it 'returns a specific contact' do
      id = create(:contact).id
      phone = create(:phone, contact_id: id)
      get "/api/v1/contacts/#{id}"

      parsed = JSON.parse(response.body, symbolize_names: true)
      contact = parsed[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(contact).to have_key(:attributes)
      expect(contact[:attributes][:name][:last]).to be_a String
      expect(contact[:attributes][:name][:middle]).to be_a String
      expect(contact[:attributes][:name][:first]).to be_a String
      expect(contact[:attributes][:address][:street]).to be_a String
      expect(contact[:attributes][:address][:city]).to be_a String
      expect(contact[:attributes][:address][:state]).to be_a String
      expect(contact[:attributes][:address][:zip]).to be_a String
      expect(contact[:attributes][:phone][0][:number]).to be_a String
      expect(contact[:attributes][:phone][0][:phone_type]).to eq("home")
      expect(contact[:attributes][:email]).to be_a String
    end

    it 'returns an error message if no contact exists with that id' do
      id = create(:contact).id
      get "/api/v1/contacts/#{id + 1}"

      parsed = JSON.parse(response.body, symbolize_names: true)
      contact = parsed[:data]

      expect(response.status).to eq(404)
      expect(contact).to have_key(:message)
      expect(contact[:message]).to eq('No contact matches this id')
    end
  end
end
