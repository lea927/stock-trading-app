FactoryBot.define do
  factory :role do
    name { [Role.find_or_create_by(name: 'Admin'), Role.find_or_create_by(name: 'Broker'), Role.find_or_create_by(name: 'Buyer')] }
  end
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'test@example.com' }
    password { 'test123' }
    password_confirmation { 'test123' }
    role_id { 1 }
  end
end
