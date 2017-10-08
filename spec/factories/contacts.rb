# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }

#factorygirl 带有的callback，还有before(:build),before(:create)等
    after(:build) do |contact|
      [:home_type,:work_type,:mobile_type].each do |phone|
        contact.phones << FactoryGirl.build(:phone,
                                            phone_type: phone, contact: contact)

      end
    end

    factory :invalid_contact do
      firstname nil
    end
  end
end
