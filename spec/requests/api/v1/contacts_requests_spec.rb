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
      #The Contact to Phone relationship. Checking the first element of the phones array for each contact.
      expect(contact[:attributes][:phone][0][:phone_type]).to eq("home")
      # Default test data is given a phone_type of "home". See spec/factories/contacts.rb for more.
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

  context 'post' do
    it 'creates a new Contact and adds it to the Contacts index' do
      contact_1 = create :contact
      phone_1 = create(:phone, contact_id: Contact.last.id)
      phone_2 = create(:phone, phone_type: 1, contact_id: Contact.last.id)
      contact_params =
      {
        id: contact_1.id,
        first_name: contact_1.first_name,
        middle_name: contact_1.middle_name,
        last_name: contact_1.last_name,
        street: contact_1.street,
        city: contact_1.city,
        state: contact_1.state,
        zip: contact_1.zip,
        phone: contact_1.phones.map do |phone|
            {
              number: phone.number,
              phone_type: phone.phone_type
            }
          end,
        email: contact_1.email
      }
      post "/api/v1/contacts/", params: (contact_params)

      contact = Contact.last

      expect(response.status).to eq(201)
      expect(contact.first_name).to eq(contact_1.first_name)
      expect(contact.middle_name).to eq(contact_1.middle_name)
      expect(contact.last_name).to eq(contact_1.last_name)
      expect(contact.last_name).to eq(contact_1.last_name)
    end

    describe 'sad path' do
      it 'returns an error if given invalid attributes' do
        contact_2 = Contact.create(first_name: "Alex", middle_name: "", last_name: "")
        contact_params =
        {
          id: contact_2.id,
          first_name: contact_2.first_name,
          middle_name: contact_2.middle_name,
          last_name: contact_2.last_name,
          street: contact_2.street,
          city: contact_2.city,
          state: contact_2.state,
          zip: contact_2.zip,
          phone: contact_2.phones.map do |phone|
              {
                number: phone.number,
                phone_type: phone.phone_type
              }
            end,
          email: contact_2.email
        }

        post "/api/v1/contacts/", params: contact_params

        parsed = JSON.parse(response.body, symbolize_names: true)
        contact = parsed[:data]
        expect(response.status).to eq(424)
        expect(contact).to have_key(:message)
        expect(contact[:message]).to eq('Invalid attributes')

      end
    end
  end

  context 'put' do
    it 'updates an existing contact' do
      contact_1 = create :contact
      phone_1 = create(:phone, contact_id: contact_1.id)
      contact_params = { phone: [{ number: "123-456-7891", phone_type: "mobile", contact_id: contact_1.id}] }

      put "/api/v1/contacts/#{contact_1.id}", params: (contact_params)

      parsed = JSON.parse(response.body, symbolize_names: true)
      contact = parsed[:data]

      expect(response.status).to eq(200)
      expect(contact[:attributes][:phone][0][:number]).to be_a String
      expect(contact[:attributes][:phone][0][:phone_type]).to eq("home")
      expect(contact[:attributes][:phone][1][:number]).to be_a String
      expect(contact[:attributes][:phone][1][:phone_type]).to eq("mobile")

    end

    it 'returns an error message if given invalid data' do
      contact_1 = create :contact
      phone_1 = create(:phone, contact_id: contact_1.id)
      contact_params = { phone: [{ number: "", phone_type: "mobile", contact_id: contact_1.id}] }

      put "/api/v1/contacts/#{contact_1.id}", params: (contact_params)

      parsed = JSON.parse(response.body, symbolize_names: true)
      contact = parsed[:data]

      expect(response.status).to eq(404)
      expect(contact).to have_key(:message)
      expect(contact[:message]).to eq('Invalid request')
    end
  end

  context 'delete' do
    it 'removes a contact from the index' do
      contact_1 = create :contact
      phone_1 = create(:phone, contact_id: contact_1.id)
    end
  end

  context 'call list' do
    it 'returns an array of contacts that have home phone numbers' do

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
      # Expecting an Array of Contacts with 3 total Contacts included. Sorting by last name will put "Thea Kuhn" first, followed by "Janeen Quigley" and "Long Wolff".

      get "/api/v1/contacts/call-list"

      parsed = JSON.parse(response.body, symbolize_names: true)
      contacts = parsed[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(contacts.class).to eq(Array)
      expect(contacts.length).to eq(3)
      expect(contacts[0][:attributes][:name][:last]).to eq("Kuhn")
      expect(contacts[0][:attributes][:phone][:phone_type]).to eq("home")
      expect(contacts[1][:attributes][:name][:last]).to eq("Quigley")
      expect(contacts[1][:attributes][:phone][:phone_type]).to eq("home")
      expect(contacts[2][:attributes][:name][:last]).to eq("Wolff")
      expect(contacts[2][:attributes][:phone][:phone_type]).to eq("home")
    end

  end
end
