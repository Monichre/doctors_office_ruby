class Speciality
  attr_reader(:name, :doctor_id, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @doctor_id = attributes.fetch(:doctor_id)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_specialties = DB.exec('SELECT * FROM specialities;')
    specialities = []
    returned_specialties.each() do |speciality|
      name = speciality.fetch('name')
      doctor_id = speciality.fetch('doctor_id').to_i()
      id = speciality.fetch('id').to_i()
      specialities.push(Speciality.new(:name => name, :id => id, :doctor_id => doctor_id))
    end
    specialities
  end
  def save
    result = DB.exec("INSERT INTO specialities (name, doctor_id) VALUES ('#{@name}', #{@doctor_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:find) do |id|
    found_speciality = nil
    Speciality.all().each do |speciality|
      if speciality.id() == id
        found_speciality = speciality
      end
    end
    found_speciality
  end

  define_method(:==) do |speciality|
    self.name() == speciality.name()
  end

  def doctors
    speciality_doctors = []
    doctors = DB.exec("SELECT FROM doctors WHERE speciality_id = #{self.id()};")
    doctors.each do |doctor|
      name = doctor.fetch('name')
      specialty_id = doctor.fetch('speciality_id').to_i()
      id = doctor.fetch('id').to_i()
      speciality_doctors.push(Doctor.new({:name => name, :speciality_id => speciality_id, :id => id}))
    end
    speciality_doctors
  end

end
