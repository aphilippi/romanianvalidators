module RomanianValidators
  module Nif
    
    module_function

    def valid?(nif)
      return false unless RomanianValidators::Cnp::well_formed?(nif)
      control = (0..11).reduce(0) { |acc, elem| acc + RomanianValidators::Cnp::TEST_KEY[elem] * nif[elem].chr.to_i } % 11
      control = 1 if control == 10
      control == nif[12].chr.to_i
    end
  end
end
