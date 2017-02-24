class RangeValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        value1 = record[@attributes[0]]
        value2 = record[@attributes[1]]
        if (value1 && value2) && (value2 <= value1)
            record.errors[@attributes[1]] << (options[:message] || "must be greater than start")
        end
    end
end
