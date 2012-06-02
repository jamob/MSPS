namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Fang",
                 full_name: "Fang Xi Lin",
                 position: "Emperor",
                email: "mcgill.physics@gmail.com",
                password:"EMPEROR",
                password_confirmation: "EMPEROR")
    User.create!(name: "Rachkov",
                 full_name: "Alexander Rachkov",
                 position: "Treasurer",
                email: "mcgill.physics@gmail.com",
                password:"horses",
                password_confirmation: "horses")
    User.create!(name: "Wilhelm",
                 full_name: "Guillaume Verdon",
                 position: "VP Internal",
                email: "mcgill.physics@gmail.com",
                password:"roidrage",
                password_confirmation: "roidrage")
    User.create!(name: "Adam",
                 full_name: "Adam Pearson",
                 position: "VP social",
                email: "mcgill.physics@gmail.com",
                password:"moustache",
                password_confirmation: "moustache")
    User.create!(name: "Jeremy",
                 full_name: "Jeremy Rothschild",
                 position: "VP External",
                email: "mcgill.physics@gmail.com",
                password:"turtle",
                password_confirmation: "turtle")
    User.create!(name: "Chandra",
                 full_name: "Chandra Curry",
                 position: "VP Academic",
                email: "mcgill.physics@gmail.com",
                password:"airplanes",
                password_confirmation: "airplanes")
    admin = User.create!(name: "Admin",
                         full_name: "Timothy Spurdle",
                         position: "Webmaster",
                email: "foo@bar.com",
                password:"foobar",
                password_confirmation: "foobar")
    admin.toggle!(:admin)
  end
end
