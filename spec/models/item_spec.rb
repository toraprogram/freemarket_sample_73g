require 'rails_helper'

describe Item do
  describe '#create' do

    context 'can save' do
      it "全て記入で登録できること" do
        item = build(:item)
        expect(item).to be_valid
      end

      it "brand_idがない場合も登録できること" do
        item = build(:item, brand_id: nil)
        expect(item).to be_valid
      end
    end
    
    context 'cant save' do
      it "imageがない場合登録できないこと" do
        image = build(:image, image: nil)
        image.valid?
        expect(image.errors[:image]).to include("can't be blank")
      end

      it "seller_idがない場合登録できないこと" do
        item = build(:item, seller_id: nil)
        item.valid?
        expect(item.errors[:seller_id]).to include("can't be blank")
      end

      it "nameがない場合登録できないこと" do
        item = build(:item, name: "")
        item.valid?
        expect(item.errors[:name]).to include("can't be blank")
      end

      # it "category_idがない場合登録できないこと" do
      #   item = build(:item, category_id: nil)
      #   item.valid?
      #   expect(item.errors[:category_id]).to include("can't be blank")
      # end

      it "priceがない場合登録できないこと" do
        item = build(:item, price: nil)
        item.valid?
        expect(item.errors[:price]).to include("can't be blank")
      end

      it "descriptionがない場合登録できないこと" do
        item = build(:item, description: "")
        item.valid?
        expect(item.errors[:description]).to include("can't be blank")
      end

      it "conditionの選択がない場合登録できないこと" do
        item = build(:item, condition: "")
        item.valid?
        expect(item.errors[:condition]).to include("can't be blank")
      end

      it "delivery_chargeの選択がない場合登録できないこと" do
        item = build(:item, delivery_charge: "")
        item.valid?
        expect(item.errors[:delivery_charge]).to include("can't be blank")
      end

      it "prefecture_idの選択がない場合登録できないこと" do
        item = build(:item, prefecture_id: nil)
        item.valid?
        expect(item.errors[:prefecture_id]).to include("can't be blank")
      end

      it "delivery_dayの選択がない場合登録できないこと" do
        item = build(:item, delivery_day: "")
        item.valid?
        expect(item.errors[:delivery_day]).to include("can't be blank")
      end

      it "sizeがない場合登録できないこと" do
        item = build(:item, size: "")
        item.valid?
        expect(item.errors[:size]).to include("can't be blank")
      end

      it "stateがfalseの場合登録できないこと" do
        item = build(:item, state: false)
        item.valid?
        expect(item.errors[:state]).to include("can't be blank")
      end
    end

    context 'name check' do
      it "nameが40文字以内で登録できること" do
        item = build(:item, name: "1234567890123456789012345678901234567890")
        expect(item).to be_valid
      end
  
      it "nameが41文字以上の場合登録できないこと" do
        item = build(:item, name: "123456789012345678901234567890123456789012")
        item.valid?
        expect(item.errors[:name]).to include("is too long (maximum is 40 characters)")
      end
    end

    context 'price check' do
      it "priceが300以上で登録できること" do
        item = build(:item, price: 300)
        expect(item).to be_valid
      end
  
      it "priceが299以下の場合登録できないこと" do
        item = build(:item, price: 299)
        item.valid?
        expect(item.errors[:price]).to include("is not included in the list")
      end
  
      it "priceが10,000,000以上の場合登録できないこと" do
        item = build(:item, price: 10000000)
        item.valid?
        expect(item.errors[:price]).to include("is not included in the list")
      end
    end
 
  end
end