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

    def restore_genesis(field_name)
      self.genesis.restore(field_name)
    end

    def reverse_genesis
      self.genesis.reverse
    end

    def write_and_preserve_attribute(field_name, value)
      init_genesis if not self.genesis
      self.genesis.preserve field_name

      self.write_attribute(field_name, value)
    end
  end
end
