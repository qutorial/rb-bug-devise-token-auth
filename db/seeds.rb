# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


u = User.create(email: 'user@example.com', nickname: 'UOne', name: 'User One', password: "monkey67")

r = Recipe.create(name: "Apple cake", user: u, preparation: "Do it like this", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Apple_pie.jpg/450px-Apple_pie.jpg")
Recipe.create(name: "Cheese cake", user: u, preparation: "Do it like this")
Recipe.create(name: "Chocolate cake", user: u, preparation: "Do it like this")
Recipe.create(name: "Welle Torte", user: u, preparation: "Do it like this")
Recipe.create(name: "Blah bloh", user: u, preparation: "Do it like this")
Recipe.create(name: "Snickers", user: u, preparation: "Do it like this")

g1 = Group.create(name: "Dough", recipe: r)
g2 = Group.create(name: "Filling", recipe: r)

Ingredient.create(name: "Flour", quantity: 2, unit: "kg", recipe: r, group: g1)
Ingredient.create(name: "Eggs", quantity: 2, unit: "pcs", recipe: r, group: g1)
Ingredient.create(name: "Apples", quantity: 3, unit: "pcs", recipe: r, group: g2)
Ingredient.create(name: "Butter", quantity: 100, unit: "g", recipe: r)
