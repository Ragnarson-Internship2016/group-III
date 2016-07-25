User.create(name: "Kamil", surname: "Filipowski", city: "lolopolo", email: "lolopolo@gmail.com", password: "lolopolo", confirmed_at: Time.now)
User.create(name: "Maciej", surname: "Michalik", city: "lolopolo", email: "test@gmail.com", password: "lolopolo", confirmed_at: Time.now)
Event.create(user_id: 1, name: "D&D", description: "We are all playing D&D", city: "Lodz", address: "Pietryna 217", start_t: DateTime.parse("09/08/2016 17:00"), end_t: DateTime.parse("09/08/2016 22:00"))
Event.create(user_id: 1, name: "Grzybobranie", description: "We are all playing Grzybobranie", city: "Lodz", address: "Rojna 2", start_t: DateTime.parse("12/08/2016 10:00"), end_t: DateTime.parse("13/08/2016 10:00"))
Event.create(user_id: 2, name: "Pandemia", description: "We are all playing Pandemia", city: "Lodz", address: "Pietryna 272", start_t: DateTime.parse("14/09/2016 14:00"), end_t: DateTime.parse("14/09/2016 18:00"))
