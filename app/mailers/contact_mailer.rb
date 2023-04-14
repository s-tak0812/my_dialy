class ContactMailer < ApplicationMailer

	default from: 'from@example.com'

	def send_when_admin_reply(customer, contact) #メソッドに対して引数を設定
    @customer = customer #ユーザー情報
    @answer = contact.reply #返信内容
    mail to: customer.email, subject: '【My Dialy】 お問い合わせありがとうございます'
  end

end
