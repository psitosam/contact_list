class Api::V1::ContactsController < ApplicationController

  def index
    render json: ContactsSerializer.format_contacts(Contact.all)
  end

  def show
    if Contact.exists?(params[:id])
      render json: ContactsSerializer.format_single_contact(Contact.find(params[:id]))
    else
      render json: { data: { message: 'No contact matches this id'} },
             status: 404
    end
  end

  def new

  end

  def create
    contact = Contact.create(contact_params)
    if contact.save
      render json: ContactsSerializer.format_single_contact(contact),
             status: 201
    else
      render json: { data: { message: 'Invalid attributes'} },
             status: 424
    end
  end

  def update
    contact = Contact.find(params[:id])
    if contact_params[:phone].present?
      contact.phones.create(contact_params[:phone])
        if contact.save
          render json: ContactsSerializer.format_single_contact(contact),
                 status: 200
        else
          render json: { data: { message: 'Invalid request'} },
                 status: 404
        end
    elsif
      contact.update(contact_params)
      render json: ContactsSerializer.format_single_contact(contact),
             status: 200
    else
      render json: { data: { message: 'Invalid request'} },
             status: 404
    end
  end

  def delete
    contact = Contact.find(params[:id])
    if contact.destroy
      render status: 204
    end
  end

  def call_list
    render json: ContactsSerializer.format_contacts(Contact.call_list)
  end









  private
    def contact_params
      params.permit(:first_name,
                    :middle_name,
                    :last_name,
                    :street,
                    :city,
                    :state,
                    :zip,
                    :email,
                    phone: [:number, :phone_type, :contact_id])
    end
end
