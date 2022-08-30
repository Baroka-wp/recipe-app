require "faker"

5.times do |user|
    User.create(
        email: Faker::Internet.email,
        password: '123456',
        name: Faker::Name.name,
    )
end

  
User.all.each do |user|
    3.times do |food|
        i = rand(0..3)
        Food.create(
            name: Faker::Food.ingredient,
            price: Faker::Number.between(from: 4, to: 100),
            measurement_unit: Faker::Food.metric_measurement,
            user_id: user.id
        )
    end
end

User.all.each do |user|
    3.times do |recipe|
        i = rand(0..3)
        Recipe.create(
            name: Faker::Food.dish,
            description: Faker::Food.description,
            prep_time: Faker::Number.between(from: 1, to: 10),
            cooking_time: Faker::Number.between(from: 1, to: 10),
            user_id: user.id
        )
    end
end


10.times do |t|
    RecipeFood.create(quantity: Faker::Food.measurement, recipe_id: Recipe.ids.sample, food_id: Food.ids.sample) 
end

# rebecka@mayer.com