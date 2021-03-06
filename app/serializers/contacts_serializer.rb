class ContactsSerializer
  include JSONAPI::Serializer
  attributes :first_name, :middle_name, :last_name, :street, :city, :state, :zip, :number, :phone_type, :email

  # Due to the custom nature of this JSON, I found it necessary to hand-roll the serializers. The first method returns an array of Contacts, and the second returns a single Contact. They both call on the helper method self.format_contact_info(contact).

  def self.format_contacts(contacts)
    {
      data: contacts.map do |contact|
        self.format_contact_info(contact)
      end
    }
  end

  def self.format_single_contact(contact)
    { data: self.format_contact_info(contact) }
  end



def self.format_contact_info(contact)
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
      phone:
        contact.phones.map do |phone|
          {
            number: phone.number,
            phone_type: phone.phone_type
          }
        end,
      email: contact.email
    }
  }
end

def self.format_call_list(contacts)
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
          phone:
            contact.phones.find do |phone| phone.phone_type == "home"
            {
              number: phone.number
            }
          end
        }
      }
    end
  }
end
# Since the call list is formatted a little differently, I decided to be very explicit in what was returned to fit the guidelines. Could probably refactor this to be cleaner.

end
