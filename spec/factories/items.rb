FactoryBot.define do

  factory :item do
    id               {1}
    seller_id        {1}
    name             {"g-team"}
    category_id      {1}
    brand_id         {1}
    price            {350}
    description      {"Don't think, feel!"}
    condition        {1}
    delivery_charge  {1}
    prefecture_id    {13}
    delivery_day     {1}
    size             {"5menber"}
    state            {true}

    after(:build) do |item|
      item.images << build(:image)
    end
    
  end
end