class Patient
  attr_reader(:name, :birth_date, :id, :doctor_id)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @birth_date = attributes.fetch(:birth_date)
    @doctor_id = attributes.fetch(:doctor_id)
  end

  def save
    result = DB.exec("INSERT INTO patients (name, birth_date, doctor_id) VALUES ('#{name}', '#{birth_date}', #{doctor_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patients")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch('name')
      birth_date = patient.fetch('birth_date')
      doctor_id = patient.fetch('doctor_id').to_i()
      id = patient.fetch('id').to_i()
      patients.push(Patient.new({:name => name, :birth_date => birth_date, :doctor_id => doctor_id, :id => id}))
    end
    patients
  end

  define_method(:==) do |another_patient|
    self.name() == (another_patient.name()) && (self.id() == (another_patient.id()))
  end


end
