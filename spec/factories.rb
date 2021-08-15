FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'test123' }
    password_confirmation { 'test123' }
    role_id { 1 }
    # using dynamic attributes over static attributes in FactoryBot

    # if needed
    # is_active true
  end
  factory :role do 
    name { 'Admin' }
  end
end
