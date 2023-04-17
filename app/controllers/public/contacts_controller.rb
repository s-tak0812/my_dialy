class Public::ContactsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:show]

  def index
    @contacts = current_customer.contacts.order('id DESC').page(params[:page])
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

  # 保存するパラメータ
  def contact_params
    params.require(:contact).permit(:title, :body, :reply)
  end

  # 投稿したcustomerでない場合topに返す
  def ensure_correct_customer
    @contact = Contact.find(params[:id])
    unless @contact.customer == current_customer
      redirect_to root_path
    end
  end

end
