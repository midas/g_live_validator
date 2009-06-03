module GLiveValidator
  
  class ValidationDefinition
    attr_accessor :active_record, :macro, :name, :options
    
    def initialize( validation )
      if validation.is_a?(ActiveRecord::Reflection::MacroReflection )
        self.active_record = validation.active_record
        self.macro = validation.macro
        self.name = validation.name
        self.options = validation.options
      elsif validation.is_a?( ValidationRule )
        self.active_record = validation.entity_type.constantize
        self.macro = "validates_#{validation.validation}_of"
        self.name = validation.attribute
        self.options = YAML.load( validation.description ) unless validation.description.nil?
      end
    end
  end
  
end