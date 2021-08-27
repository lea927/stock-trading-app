# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def welcome_email_broker
    user = User.new(first_name: 'John', last_name: 'Doe', email: "johndoe@gmail.com", password: 'john123',role_id: 2)
    UserMailer.with(user: user).welcome_email
  end

  def welcome_email_buyer
    user = User.new(first_name: 'Jane', last_name: 'Doe', email: "janedoe@gmail.com", password: 'jane123',role_id: 3)
    UserMailer.with(user: user).welcome_email
  end

  def approved_broker_email
    user = User.new(first_name: 'Jane', last_name: 'Doe', email: "janedoe@gmail.com", password: 'jane123',role_id: 2)
    UserMailer.with(user: user).approved_email
  end
end