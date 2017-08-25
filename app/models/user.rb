class User
  attr_accessor :name
  attr_accessor :surname

  def initialize(attrs={})
    attrs.each do |(attr_name, attr_value)|
      public_send(:"#{attr_name}=", attr_value)
    end
  end
end
