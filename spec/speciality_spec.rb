require "spec_helper"

describe(Speciality) do
  describe('.all') do
    it('starts off with no lists') do
      expect(Speciality.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('lets you save specialities to the database') do
      speciality = Speciality.new({:name => "Pediatrics", :doctor_id => 2, :id => nil})
      speciality.save()
      expect(Speciality.all()).to(eq([speciality]))
    end
  end

end
