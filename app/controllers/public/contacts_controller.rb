class Public::ContactsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:show]
  before_action :ensure_test_customer

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
      redirect_to contacts_path, notice: "送信完了"
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

  # お試し用アカウントの制限
  def ensure_test_customer
    if current_customer.email == 'test@hoge.com'
      redirect_to root_path, alert: 'お試しではその操作はできません'
    end
  end

end
