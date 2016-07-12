class Doctor
  attr_reader(:name, :specialty_id, :id)

  def initialize (attributes)
    @name = attributes.fetch(:name)
    @specialty_id = attributes.fetch(:specialty_id)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all)do
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i()
      id = doctor.fetch("id").to_i()
      doctors.push(Doctor.new(:name => name, :specialty_id => specialty_id, :id => id))
    end
    doctors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (name,specialty_id) VALUES ('#{name}',#{specialty_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_doctor|
    self.name() == another_doctor.name() 
  end

  define_singleton_method(:find) do |id|
    found_doctor = nil
    Doctor.all().each() do |doctor|
      if doctor.id == id
        found_doctor =doctor
      end
    end
    found_doctor
  end

  define_method(:patients) do
    patients_list = []
    patients = DB.exec("SELECT * FROM patients WHERE doctor_id  = #{self.id()};")
    patients.each() do |patient|
      name = patient.fetch("name")
      birth_date = patient.fetch("birth_date")
      doctor_id = patient.fetch("doctor_id").to_i()
      id = patient.fetch("id").to_i()
      patients_list.push(Patient.new({:name => name, :birth_date => birth_date, :doctor_id=> doctor_id, :id => id}))

    end
    patients_list
  end
end
