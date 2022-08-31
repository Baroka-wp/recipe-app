require "rails_helper"

RSpec.describe Food, type: :view do
    before :each do
        @user = User.create(name: "Tom", email:"tom@dev.co", password: "password", password_confirmation: "password")
        @food = Food.create(name: "Pasta", measurement_unit: "Litter", price: 10, user_id: @user.id)
        @recipe = Recipe.create(name: "Pasta", description: "Itelian", prep_time: 10, cooking_time: 10, user_id: @user.id)
        @recipe = Recipe.create(name: "rita", description: "french", prep_time: 10, cooking_time: 10, public: false, user_id: @user.id)

    end

    context 'Visite public recipe' do
        it 'should show public recipe' do
            visit public_recipes_path
            expect(page).not_to have_content('rita')
            expect(page).to have_content('Pasta')
        end
    end
end