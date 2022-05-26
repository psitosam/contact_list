# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
contact_1 = Contact.create(first_name: "India", middle_name: "Corwin", last_name: "Lynch", street: "612 Cyndy Coves", city: "Howellton", state: "Oklahoma", zip: "41265-1557", phone: [], email: "ernest@simonis-wolf.org")

contact_2 = Contact.create(first_name: "Thea", middle_name: "Fisher", last_name: "Kuhn", street: "926 Kimberly Road", city: "North Billy", state: "Maine", zip: "03740-3342", phone: [], email: "ericka_beahan@hermann-tromp.io")

contact_3 = Contact.create(first_name: "Sherita", middle_name: "Graham", last_name: "Treutel", street: "6669 Williamson Square", city: "Port Erna", state: "New Mexico", zip: "60239-2314", phone: [], email: "nobuko.pfeffer@buckridge.com")

contact_4 = Contact.create(first_name: "Janeen", middle_name: "McCullough", last_name: "Quigley", street: "9166 McKenzie Square", city: "Friesenborough", state: "Iowa", zip: "00050-1101", phone: [], email: "leigh@okeefe-franecki.com")

contact_5 = Contact.create(first_name: "Long", middle_name: "Breitenberg", last_name: "Wolff", street: "224 Grant Islands", city: "Port Trentburgh", state: "New Hampshire", zip: "62350-2289", phone: [], email: "ronny@cole.name")

phone_1 = Phone.create(number: "937-262-3861", phone_type: "home", contact_id: contact_1.id )
phone_2 = Phone.create(number: "810-734-8712", phone_type: "mobile", contact_id: contact_2.id )
phone_3 = Phone.create(number: "412.786.8338", phone_type: "home", contact_id: contact_3.id )
phone_4 = Phone.create(number: "479-347-6659", phone_type: "work", contact_id: contact_4.id )
phone_5 = Phone.create(number: "901-732-2835", phone_type: "home", contact_id: contact_5.id )
