class Api::V1::ContactsController < ApplicationController

  def index
    render json: ContactsSerializer.format_contacts(Contact.all)
    # render json: ContactsSerializer.new(Contact.all)
  end

  def show
    if Contact.exists?(params[:id])
      render json: ContactsSerializer.format_single_contact(Contact.find(params[:id]))
    else
      render json: { data: { message: 'No contact matches this id'} },
             status: 404
    end
  end
end
