# A few helpers and monkey patchers to make things easier

class String
  def numeric?
     true if Float(self) rescue false
  end
end