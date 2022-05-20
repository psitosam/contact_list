class ContactsSerializer
  include JSONAPI::Serializer
  attributes :first_name, :middle_name, :last_name, :street, :city, :state, :zip, :number, :phone_type, :email

  # Due to the custom nature of this JSON, I found it necessary to hand-roll the serializers. The first method returns an array of Contacts, and the second returns a single Contact.

  def self.format_contacts(contacts)
    {
      data: contacts.map do |contact|
        {
          id: contact.id,
          attributes: {
            name: {
              first: contact.first_name,
              middle: contact.middle_name,
              last: contact.last_name
            },
            address: {
              street: contact.street,
              city: contact.city,
              state: contact.state,
              zip: contact.zip
            },
            phone: [
              {
                number: contact.number,
                phone_type: contact.phone_type
              }
            ],
            email: contact.email
          }
        }
      end
    }
  end

  def self.format_single_contact(contact)
    {
      data:
        {
          id: contact.id,
          attributes: {
            name: {
              first: contact.first_name,
              middle: contact.middle_name,
              last: contact.last_name
            },
            address: {
              street: contact.street,
              city: contact.city,
              state: contact.state,
              zip: contact.zip
            },
            phone: [
              {
                number: contact.number,
                phone_type: contact.phone_type
              }
            ],
            email: contact.email
          }
        }
    }
  end
end
