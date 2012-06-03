FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "Person #{n}"}
    sequence(:email){|n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :post do
    content "Lorem ipsum"
    title "Dolor sit amete"
    author "Jamob"
    date "8:13 AM, 2/06/2012"
  end
end
