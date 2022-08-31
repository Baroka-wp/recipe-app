require 'rails_helper'

RSpec.describe Recipe, type: :view do
  before :each do
    @user = User.create(name: 'Tom', email: 'tom@dev.co', password: 'password', password_confirmation: 'password')

    @user1 = User.create(name: 'kev', email: 'kev@dev.co', password: 'password', password_confirmation: 'password')

    @food1 = Food.create(name: 'Pasta', measurement_unit: 'Litter', price: 10, user_id: @user.id)
    @food3 = Food.create(name: 'macaronie', measurement_unit: 'Litter', price: 10, user_id: @user.id)
    @food2 = Food.create(name: 'risoto', measurement_unit: 'cm', price: 10, user_id: @user.id)

    @recipe = Recipe.create(name: 'Pasta', description: 'Itelian', prep_time: 10, cooking_time: 10,
                            user_id: @user.id)
    @recipe = Recipe.create(name: 'macaro', description: 'Itelian', prep_time: 10, cooking_time: 10, public: false,
                            user_id: @user.id)
    @recipe = Recipe.create(name: 'rita', description: 'french', prep_time: 10, cooking_time: 10,
                            user_id: @user1.id)
  end

  context 'Visite public recipe' do
    it 'should show public recipe' do
      visit public_recipes_path
      expect(page).to have_content('Pasta')
    end
    it 'should not show private recipe' do
      visit public_recipes_path
      expect(page).not_to have_content('macaro')
    end
    it 'requires login' do
      visit recipes_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
  context 'Visite private recipe' do
    it 'should show private recipe' do
      # login
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'Log in'
      visit recipes_path
      expect(page).to have_content('Pasta')
    end
    it 'should not show private recipe own by other user' do
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'Log in'
      visit recipes_path
      expect(page).not_to have_content('rita')
    end
  end
end
