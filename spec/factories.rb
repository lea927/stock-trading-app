FactoryBot.define do
  factory :role do
    name { 'Admin' }
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
