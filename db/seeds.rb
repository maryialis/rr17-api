# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name: 'Maryia', last_name: 'Lisichonak', email: 'Maryia_lisichonak@epam.com', password: '123456')
User.create(first_name: 'aliaksandr', last_name: 'buhayeu', email: 'Aliaksandr_Buhayeu@epam.com', password: '654321')
User.create(email: 'bot@tut.by', password: '111111')
User.create(first_name: 'test', email: 'test@epam.com', password: '222222')
User.create(last_name: 'test', email: 'test@epam.com', password: '333333')

SourceProvider.create(name: 'Priorbank', url: 'https://www.priorbank.by', address: 'ул. Казинца, 92/1', author: User.find(1))
SourceProvider.create(name: 'Belarusbank', url: 'https://belarusbank.by/', address: 'ул. ПЛЕХАНОВА, 42', author: User.find(2))
SourceProvider.create(name: 'Unknown', url: 'Unknown', address: 'Unknown', active: false, author: User.find(3))
SourceProvider.create(name: 'Technobank', url: 'https://tb.by/', address: 'ул. Кропоткина, 44', author: User.find(1))

CourseResult.create(usd: 1.8580, eur: 2.0700, rur: 0.0324, source_provider_id: 1)
CourseResult.create(usd: 1.8570, eur: 2.0780, rur: 0.0333, source_provider_id: 2)

SourceParser.create(parser_name: 'BelarusParser', url_pattern: 'https://belarusbank.by/ru/fizicheskim_licam/valuta/kursy-po-plastikovym-kartam')
SourceParser.create(parser_name: 'TechnoParser', url_pattern: 'https://tb.by/individuals/')
