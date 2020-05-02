require 'rails_helper'
describe User do
  describe '#create' do
    # 1
    it "nickname、email、password、password_confirmation、family_name、first_name、family_name_kana、
    first_name_kana、birthday、phone_authy、postal_code、prefecture_id、city、blockが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    #ここはuserモデルのカラムに合わせた内容です
 
    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

  
    it "emailがない場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it " passwordがなかったら登録できないこと " do
      user = build(:user, password: "", password_confirmation: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "birthdayがない場合は登録できないこと" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end

    it " passwordが7文字以上であれば登録できること " do
      user = build(:user, password: "00000000", password_confirmation: "00000000")
      expect(user).to be_valid
    end

    it " passwordが6文字以下であれば登録できないこと " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it "family_nameがない場合は登録できないこと" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    it "first_nameがない場合は登録できないこと" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end


    it "family_name_kanaがない場合は登録できないこと" do
      user = build(:user, family_name_kana: "")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("can't be blank")
    end

    it "first_name_kanaがない場合は登録できないこと" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    it "phone_authyがない場合は登録できないこと" do
      user = build(:user, phone_authy: "")
      user.valid?
      expect(user.errors[:phone_authy]).to include("can't be blank")
    end


    #ここからはaddressのカラムに合わせた内容です


    it "postal_codeがない場合は登録できないこと" do
      user = build(:address, postal_code: "")
      user.valid?
      expect(user.errors[:postal_code]).to include("can't be blank")
    end

    it "prefecture_idがない場合は登録できないこと" do
      user = build(:address, prefecture_id: "")
      user.valid?
      expect(user.errors[:prefecture_id]).to include("can't be blank")
    end

    it "prefecture_idが数字でない場合は登録できないこと" do
      user = build(:address, prefecture_id: "0-9０-９")
      user.valid?
      expect(user.errors[:prefecture_id]).to include("is not included in the list")
    end

    it "cityがない場合は登録できないこと" do
      user = build(:address, city: "")
      user.valid?
      expect(user.errors[:city]).to include("can't be blank")
    end

    it "blockがない場合は登録できないこと" do
      user = build(:address, block: "")
      user.valid?
      expect(user.errors[:block]).to include("can't be blank")
    end

  end
end
