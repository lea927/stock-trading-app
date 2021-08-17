FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'test@example.com' }
    password { 'test123' }
    password_confirmation { 'test123' }
    # using dynamic attributes over static attributes in FactoryBot

    # if needed
    # is_active true

    factory :admin do
      role { 1 }
    end
  end
end
