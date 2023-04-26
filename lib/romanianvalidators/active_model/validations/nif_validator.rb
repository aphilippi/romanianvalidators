module RomanianValidators
  module ActiveModel
    module Validations
      class NifValidator < ::ActiveModel::EachValidator
        include ActiveModel::Validations::EmptyBlankEachValidator

        def valid?(nif)
          RomanianValidators::Nif.valid?(nif)
        end
      end
    end
  end
end
