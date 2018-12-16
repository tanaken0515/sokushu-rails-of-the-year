FactoryBot.define do
  factory :task do
    name {'Specを書く'}
    description {'SystemSpecを書くための準備をする'}
    user
  end
end