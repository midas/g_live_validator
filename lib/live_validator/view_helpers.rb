module LiveValidator
  module ViewHelpers
    
    G_VALIDATION_METHODS = {
      :presence => "Validate.Presence",
      :numericality => "Validate.Numericality",
      :format => "Validate.Format",
      :length => "Validate.Length",
      :size => "Validate.Length",
      :acceptance => "Validate.Acceptance",
      :confirmation => "Validate.Confirmation",
      :exclusion => "Validate.Exclusion"
    }

    # Guilded component.  This reads from the server side validations and sets up client side 
    # validations that match utilizing the Live Validation library.  The following validation
    # macros and args are implemented:
    # 
    # validates_presence_of - :message
    # validates_numericality_of - :less_than, :less_than_or_equal_to, :equal_to, :greater_than, 
    #   :greater_then_or_equal_to, :only_integer, :notANumberMessage, :notAnIntegerMessage,
    #   :wrongNumberMessage, :tooLowMessage, :tooHighMessage
    # validates_length_of / validates_size_of - :maximum, :minimum, :is, :within, :in, :too_long,
    #   :too_short, :wrong_length
    # validates_confirmation_of - Only works for 2 fields, no more or less.
    # validates_acceptance_of - :message
    # validates_inclusion_of - :message
    # validates_exclusion_of - :message
    # 
    # If you need to do custom initialization you can implement g.beforeLiveValidatorInit() or 
    # g.afterLiveValidatorInit().
    #
    # If you need custom handling of valid or invalid fields, you can implement g.liveValidatorInvalidField() 
    # or g. liveValidatorValidField().
    # 
    # *parameters*
    # form:: The form object from the form_for helper.
    # 
    # *options*
    # id:: (required)
    # except:: List of fields to not include.  A string, symbol or array of strings or symbols. 
    #
    def g_live_validator( form, *args )
      options = args.extract_options!
      klass = form.object.class
      class_name = klass.to_s.downcase
      options.merge! :id => "live-validator-#{class_name}"
      ar_obj_name = form.object.class.to_s.underscore
      
      validations = g_map_validations( klass.reflect_on_all_validations )
      
      # Remove any foreign keys as they will not be present on the form
      validations.reject! { |field, validation| field.include?( "_id" ) }
      
      # Remove any excepts, if necessary
      if options[:except]
        if options[:except].is_a?( Array )
          excepts = options[:except]
        elsif options[:except].is_a?( String ) || options[:except].is_a?( Symbol )
          excepts = Array.new << options[:except]          
        else
          throw "'Except' option must be a string symbol or arry of strings or symbols"
        end

        # Add the AR object name to the field name, as Rails does this on forms
        excepts.map! { |except| "#{ar_obj_name}_#{except.to_s}" }
        
        excepts.each do |except|
          validations.reject! { |field, validation| field == except }
        end
      end
      
      # Handle nested form namings, if necessary
      if form.object.class.to_s.underscore != form.object_name
        #field_precursor = form.object_name.gsub( /\[/, '_' ).gsub( /\]/, '_' )
        field_precursor = form.object_name[0...form.object_name.index( "[" )] + '_'
        nested_validations = Hash.new
        validations.each do |key, value|
          nested_validations[ "#{field_precursor}#{key}".to_sym ] = value
        end
        validations = nested_validations
      end
      
      options.merge! :validations => validations
      Guilded::Guilder.instance.add( :live_validator, options, [ 'livevalidation-1.3.min.js' ] )
      return ""
    end
    
    private
    
    def g_map_validations( validation_defs )
      validations = {}
      confirmation_of = []
      
      validation_defs.each do |validation_def|
        klass = validation_def.active_record.to_s.underscore
        temp = { :name => validation_def.macro }
        options = {}
        
        unless validation_def.options.nil?
          
          validation_def.options.each do |key, value|
            if key == :greater_than
              options.merge!( :minimum => value + 1 )
            elsif key == :greater_than_or_equal_to
              options.merge!( :minimum => value )
            elsif key == :equal_to
              options.merge!( :is => value )
            elsif key == :less_than
              options.merge!( :maximum => value - 1 )
            elsif key == :less_than_or_equal_to
              options.merge!( :maximum => value )
            elsif ( key == :within || key == :in ) && validation_def.macro == :validates_length_of
              options.merge!( :minimum => value.begin )
              options.merge!( :maximum => value.end )
            elsif ( validation_def.macro == :validates_inclusion_of || validation_def.macro == :validates_exclusion_of ) && key == :in
              if value.is_a?( Array )
                options.merge!( :within => value )
              else
                options.merge!( :within => value.to_a )
              end
            elsif key == :message
              options.merge!( :failureMessage => value )
            elsif key == :allow_nil
              options.merge!( :allowNull => value )
            elsif key == :wrong_length
              options.merge!( :wrongLengthMessage => value )
            elsif key == :too_long
              options.merge!( :tooLongMessage => value )
            elsif key == :too_short
              options.merge!( :tooShortMessage => value )
            else
              options.merge!( key.to_s.camelize( :lower ) => value )
            end
          end
        
          temp.merge!( :args => options )
          
        end
        
        # Handle validatesconfirmation_of
        if validation_def.macro.to_sym == :validates_confirmation_of
          
          confirmation_of.push( validation_def.name )
          
          if confirmation_of.size ==2
            key = "#{klass}_#{confirmation_of[1]}"
            
            temp[:args] = {} if temp[:options].nil?
            
            temp[:args].merge! :match => "#{klass}_#{confirmation_of[0]}" 
            
            if validations.has_key?( key )
              validations[key].push( temp )
            else
              validations[key] = [ temp ]
            end
          end
          
        else # Handle others
          
          key = "#{klass}_#{validation_def.name}"
          
          if validations.has_key?( key )
            validations[key].push( temp )
          else
            validations[key] = [ temp ]
          end
          
        end
        
      end
      
      return validations
    end
    
  end
end