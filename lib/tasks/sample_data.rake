namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Admin",
                email: "foo@bar.com",
                password:"foobar",
                password_confirmation: "foobar")
    admin.toggle!(:admin)

    User.create!(name: "Rachkov",
                email: "mcgill.physics@gmail.com",
                password:"horses",
                password_confirmation: "horses")
    User.create!(name: "Jeremy",
                email: "mcgill.physics@gmail.com",
                password:"turtle",
                password_confirmation: "turtle")
    User.create!(name: "Chandra",
                email: "mcgill.physics@gmail.com",
                password:"airplanes",
                password_confirmation: "airplanes")
    User.create!(name: "Wilhelm",
                email: "mcgill.physics@gmail.com",
                password:"roidrage",
                password_confirmation: "roidrage")
    User.create!(name: "Adam",
                email: "mcgill.physics@gmail.com",
                password:"moustache",
                password_confirmation: "moustache")
    User.create!(name: "Fang Xi Lin",
                email: "mcgill.physics@gmail.com",
                password:"EMPEROR",
                password_confirmation: "EMPEROR")
  end
end
