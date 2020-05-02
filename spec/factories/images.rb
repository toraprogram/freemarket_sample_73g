FactoryBot.define do

  factory :image do
    image      {File.open("#{Rails.root}/spec/fixtures/test_image.png")}
    item_id    {1}
  end

end