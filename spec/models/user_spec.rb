require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: "Tom", email:"tom@dev", password: "password", password_confirmation: "password")
  end
  context 'validations' do
    it 'is valid with valid attributes' do
      @user.save
      expect(@user).to be_valid
    end
    it 'is not valid without a name' do
      @user.name = nil
      @user.save
      expect(@user).to_not be_valid
    end
    it 'is not valid without an email' do
      @user.email = nil
      @user.save
      expect(@user).to_not be_valid
    end
    it 'is not valid without a password' do
      @user.password = nil
      @user.save
      expect(@user).to_not be_valid
    end
  end

  context 'associations' do
    it 'has many recipes' do
      assc = described_class.reflect_on_association(:recipes)
      expect(assc.macro).to eq :has_many
    end
    it 'has many foods' do
      assc = described_class.reflect_on_association(:foods)
      expect(assc.macro).to eq :has_many
    end
  end
end
