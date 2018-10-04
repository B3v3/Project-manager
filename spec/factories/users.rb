FactoryBot.define do
  factory :user do
    name {'XxSEBAxX'}
    email {'hotjanusz@januszex.ru'}
    password {'passowordu'}
    password_confirmation {'passowordu'}
  end

  factory :user1, class: User do
    name { 'testomaniac'}
    email {'dajcie@mi.prace'}
    password {'passowordu'}
    password_confirmation {'passowordu'}
  end
end
