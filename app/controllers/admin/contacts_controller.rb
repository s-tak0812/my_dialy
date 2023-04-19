class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @contacts = Contact.page(params[:page]).order(created_at: :desc)
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    contact = Contact.find(params[:id])
    contact.update(contact_params)
    customer = contact.customer
    ContactMailer.send_when_admin_reply(customer, contact).deliver_now
    redirect_to admin_contacts_path
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    redirect_to admin_contacts_path
  end

  private

  def contact_params
    params.require(:contact).permit(:title, :body, :reply)
  end

end
