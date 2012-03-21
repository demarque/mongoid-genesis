module Mongoid
  module Genesis
    module Storage
      def field_preserved?(field_name)
        self.attribute_present? field_name
      end

      def preserve(field_name)
        self.write_attribute(field_name, self.alter.read_attribute(field_name)) if not field_preserved? field_name
      end

      def restore(field_name)
        if field_preserved? field_name
          self.alter.write_attribute(field_name, self.read_attribute(field_name))
          self.remove_attribute(field_name)
        end
      end

      def reverse
        self.attributes.each do |name, value|
          if not ['_id', '_type'].include? name
            buffer = self.alter.read_attribute(name)

            self.alter.write_attribute(name, self.read_attribute(name))
            self.write_attribute(name, buffer)
          end
        end
      end

      def method_missing(*args, &block)
        if self.alter.respond_to? args[0].to_s
          self.read_attribute args[0]
        else
          raise NoMethodError.new("undefined local variable or method '#{args.first}' for #{self.class}")
        end
      end
    end
  end
end
