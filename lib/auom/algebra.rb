module AUOM
  # The AUOM algebra
  module Algebra
    # Return addition result
    #
    # @param [Object] operand
    #
    # @return [Unit]
    #
    # @example
    #  
    #   # unitless
    #   Unit.new(1) + Unit.new(2) # => <Unit @scalar=3>
    #
    #   # with unit
    #   Unit.new(1,:meter) + Unit.new(2,:meter) # => <AUOM::Unit @scalar=3 meter>
    #
    #   # incompatible unit
    #   Unit.new(1,:meter) + Unit.new(2,:euro) # raises ArgumentError!
    #
    # @api public
    #
    def add(operand)
      klass = self.class
      operand = klass.convert(operand)

      unless operand.unit == unit
        raise ArgumentError, 'Incompatible units for substraction or addition'
      end

      klass.new(
        operand.scalar + scalar,
        numerators.dup,
        denominators.dup
      )
    end

    alias :+ :add

    # Return substraction result
    #
    # @param [Object] operand
    #
    # @return [Unit]
    #
    # @example
    #  
    #   # unitless
    #   Unit.new(2) - Unit.new(1) # => <Unit @scalar=1>
    #
    #   # with unit
    #   Unit.new(2,:meter) - Unit.new(1,:meter) # => <AUOM::Unit @scalar=1 meter>
    #
    #   # incompatible unit
    #   Unit.new(2,:meter) - Unit.new(1,:euro) # raises ArgumentError!
    #
    # @api public
    #
    def substract(operand)
      self.add(self.class.convert(operand) * -1)
    end

    alias :- :substract

    # Return multiplication result
    #
    # @param [Object] operand
    #
    # @return [Unit]
    #
    # @example
    #  
    #   # unitless
    #   Unit.new(2) * Unit.new(1) # => <Unit @scalar=2>
    #
    #   # with unit
    #   Unit.new(2, :meter) * Unit.new(1, :meter) # => <AUOM::Unit @scalar=2 meter^2>
    #
    #   # differend units
    #   Unit.new(2, :meter) * Unit.new(1, :euro) # => <AUOM::Unit @scalar=2 meter*euro>
    #
    # @api public
    #
    def multiply(operand)
      klass = self.class
      operand = klass.convert(operand)

      klass.new(
        operand.scalar * scalar,
        numerators + operand.numerators,
        denominators + operand.denominators
      )
    end

    alias :* :multiply

    # Return division result
    #
    # @param [Object] operand
    #
    # @return [Unit]
    #
    # @example
    #  
    #   # unitless
    #   Unit.new(2) / Unit.new(1) # => <Unit @scalar=2>
    #
    #   # with unit
    #   Unit.new(2, :meter) / Unit.new(1, :meter) # => <AUOM::Unit @scalar=2>
    #
    #   # differend units
    #   Unit.new(2, :meter) / Unit.new(1, :euro) # => <AUOM::Unit @scalar=2 meter/euro>
    #
    # @api public
    #
    def divide(operand)
      klass = self.class
      operand = klass.convert(operand)

      self * klass.new(
        1 / operand.scalar,
        operand.denominators.dup,
        operand.numerators.dup
      )
    end

    alias :/ :divide
  end
end
