# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SourceProvider.create(name: 'Priorbank', url: 'https://www.priorbank.by', address: 'ул. Казинца, 92/1')
SourceProvider.create(name: 'Belarusbank', url: 'https://belarusbank.by/', address: 'ул. ПЛЕХАНОВА, 42')

User.create(first_name: 'Maryia', last_name: 'Lisichonak', email: 'Maryia_lisichonak@epam.com', password: '1234')
User.create(first_name: 'aliaksandr', last_name: 'buhayeu', email: 'Aliaksandr_Buhayeu@epam.com', password: '4321')
User.create(email: 'bot@tut.by', password: '1')
User.create(first_name: 'test', email: 'test@epam.com', password: '2')
User.create(last_name: 'test', email: 'test@epam.com', password: '3')
