class Public::ContactsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @contacts = current_customer.contacts.order('id DESC')
    @contact = Contact.new
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.customer_id = current_customer.id
    if @contact.save
      redirect_to customers_mypage_path, success_contact:"お問い合わせを送信しました。"
    else
      @contacts = current_customer.contacts.order('id DESC')
      render :index
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:title, :body, :reply)
  end

end
