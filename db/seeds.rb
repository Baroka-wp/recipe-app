# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
recipes = Recipe.create([
  {
    name: "Fufu et Pondu",
    prep_time: 10,
    cooking_time: 5,
    description: "Made with Maize flour, and eaten with Pondu, Meat sauce or other supplement.",
    public: true,
  },
  {
    name: "Walmar",
    prep_time: 10,
    cooking_time: 20,
    description: "Made with Rice and Beans.",
    public: true,
  }
])
