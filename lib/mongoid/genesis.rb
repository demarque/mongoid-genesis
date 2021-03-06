module Mongoid
  module Genesis
    extend ActiveSupport::Concern

    def self.included(base)
      Object.const_set("#{base.name}Genesis", Class.new do
        include Mongoid::Document
        include Mongoid::Genesis::Storage

        embedded_in :alter, :class_name => base.name, :inverse_of => :genesis
      end)

      base.embeds_one :genesis, :class_name => "#{base.name}Genesis", :inverse_of => :alter
    end

    def init_genesis
      self.genesis = "#{self.class.name}Genesis".constantize.new
    end

    def read_attribute_genesis(field_name)
      source = (self.genesis and self.genesis.field_preserved?(field_name)) ? self.genesis : self

      return source.read_attribute field_name
    end

    def restore_genesis(field_name)
      self.genesis.restore field_name
    end

    def reverse_genesis
      self.genesis.reverse
    end

    def write_and_preserve_attribute(field_name, value)
      init_genesis if not self.genesis

      if value and self.genesis.read_attribute(field_name) == value
        self.restore_genesis(field_name)
      else
        self.genesis.preserve field_name
        self.write_attribute(field_name, value)
      end
    end
  end
end
