require "spec_helper"

describe (Doctor) do

  describe(".all") do
    it("starts off as an empty list") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe ('#name') do
    it ("tells its name") do
      doctor = Doctor.new({:name => "John Doe",:specialty_id => 1, :id => nil})
      expect(doctor.name()).to (eq("John Doe"))
    end
  end

  describe ('#id') do
    it ("tells its id") do
      doctor = Doctor.new({:name => "John Doe",:specialty_id => 1, :id => nil})
      doctor.save()
      expect(doctor.id()).to (be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
      it("lets you save doctors to the database") do
        doctor = Doctor.new({:name => "John Doe",:specialty_id => 1, :id => nil})
        doctor.save()
        expect(Doctor.all()).to(eq([doctor]))
      end
    end

  describe("#==") do
    it ("is the same doctor if it has the same name and id") do
      doc1 = Doctor.new({:name => "John Doe",:specialty_id => 1, :id => nil})
      doc1.save()
      expect(doc1).to(eq(doc1))
    end
  end

  describe('.find') do
    it("returns a doctor by ID")do
    doc1 = Doctor.new({:name => "John Doe",:specialty_id => 1, :id => nil})
    doc1.save()
    doc2 = Doctor.new({:name => "Jack Doe",:specialty_id => 1, :id => nil})
    doc2.save()
    expect(Doctor.find(doc1.id())).to(eq(doc1))
    end
  end

  describe('#patients') do
    it ("returns the patients for a doctor") do
      doctor = Doctor.new({:name => "John Doe",:specialty_id => 1, :id => nil})
      doctor.save()
      test_patient1 = Patient.new({:name => "Liam", :birth_date => '1987-03-27 00:00:00', :doctor_id=> doctor.id(), :id => nil})
      test_patient1.save()
      test_patient2 = Patient.new({:name => "Rony", :birth_date => '1985-03-27 00:00:00', :doctor_id=> doctor.id(), :id => nil})
      test_patient2.save()
      expect(doctor.patients()).to(eq([test_patient1,test_patient2]))
    end
  end


end
