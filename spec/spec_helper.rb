
require("rspec")
require("pg")
require("patient")
require "doctor"
require "speciality"


DB = PG.connect({:dbname => "doctors_office_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM specialities *;")
  end
end
