# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    #作用为告诉程序与cotact的关联关系
    association :contact
    phone { Faker::PhoneNumber.phone_number }
    #phone_type 'home'

    #创建从属关系，意思是每一个电话中不同的类型
    factory :home_type do
      phone_type 'home'
    end

    factory :work_type do
      phone_type 'work'
    end

    factory :mobile_type do
      phone_type 'mobile'
    end

  end
end
