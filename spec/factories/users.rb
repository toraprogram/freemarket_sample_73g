FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    family_name           {"あああ"}
    first_name            {"いい"}
    family_name_kana      {"サイトウ"}
    first_name_kana       {"ヒカル"}
    birthday              {"19970417"}
    phone_authy           {"08065516893"}
  end

end