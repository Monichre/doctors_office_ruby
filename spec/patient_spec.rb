require('spec_helper')

describe(Patient) do

  describe('#save') do
    it('adds a patient to the database') do
      test_patient = Patient.new({:name => "Liam", :birth_date => '1987-03-27 00:00:00', :doctor_id=> 1, :id => nil})
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end

end
