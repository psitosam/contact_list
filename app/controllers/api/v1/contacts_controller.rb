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
    contact = Contact.new(contact_params)
    if contact.save
      render json: ContactsSerializer.format_single_contact(contact),
             status: 201
    else
      render json: { data: { message: 'Invalid attributes'} },
             status: 424
    end
  end

  def update

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
                    :number,
                    :phone_type,
                    :email,
                    :phones)
    end
end
