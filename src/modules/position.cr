module Celestine::Modules::Position
  make_units :x
  make_units :y


  def position_attribute(io : IO)
    io << %Q[x="#{x}#{x_units}" ] if x
    io << %Q[y="#{y}#{y_units}" ] if y
  end

  module Attrs
    X = "x"
    Y = "y"
  end
end

module Celestine::Modules::CPosition
  make_units :x
  make_units :y

  def position_attribute(io : IO)
    io << %Q[cx="#{x}#{x_units}" ] if x
    io << %Q[cy="#{y}#{y_units}" ] if y
  end
  
  module Attrs
    X = "cx"
    Y = "cy"
  end
end