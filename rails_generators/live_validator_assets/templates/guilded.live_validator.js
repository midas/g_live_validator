/* Guilded Live Validator 1.0.1
 * Copyright (c) 2009 C. Jason Harrelson (midas)
 * Guilded Live Validator is licensed under the terms of the MIT License */

g.liveValidationsByField = {}; /* The collection of live validation objects indexed by field names */
g.liveValidations = []; /* The collection of live validation objects */

g.doInvalidField = function()
{
  if( g.liveValidatorInvalidField )
  {
    g.liveValidatorInvalidField( this );
  }
  else
  {
    this.insertMessage( this.createMessageSpan() );
    this.addFieldClass();
  }
};

g.doValidField = function()
{
  if( g.liveValidatorValidField )
    g.liveValidatorValidField( this );
  else
  {
    this.insertMessage( this.createMessageSpan() );
    this.addFieldClass();
  }
};

g.liveValidatorInit = function( options )
{
  if( g.beforeLiveValidatorInit )
    g.beforeLiveValidatorInit( options );

  var moreValidationMethods = {
    presence: Validate.Presence,
    numericality: Validate.Numericality,
    format: Validate.Format,
    length: Validate.Length,
    acceptance: Validate.Acceptance,
    confirmation: Validate.Confirmation
  };

  var validationMethods = {
    validates_presence_of: Validate.Presence,
    validates_numericality_of: Validate.Numericality,
    validates_format_of: Validate.Format,
    validates_length_of: Validate.Length,
    validates_size_of: Validate.Length,
    validates_acceptance_of: Validate.Acceptance,
    validates_confirmation_of: Validate.Confirmation,
    validates_inclusion_of: Validate.Inclusion,
    validates_exclusion_of: Validate.Exclusion
  };

  var validations = options[ 'validations' ];

  for( field in validations )
  {
    /* Guard against fields that we cannot find throwing errors.  Just don't
     * attach if you cannot find it. */
    fieldEl = $j( '#' + field );
    if( fieldEl.length == 0 )
      continue;

    var vList = validations[ field ];
    var v = null;

    v = new LiveValidation( field, { onlyOnBlur:true, onInvalid:g.doInvalidField, onValid:g.doValidField } );

    for( var i=0; i<vList.length; i++ )
    {
      var validation = vList[i];
      v.add( validationMethods[ validation.name ], validation.args );
      g.liveValidationsByField[field] = v;
      g.liveValidations.push( v );
    }
  }

  if( g.afterLiveValidatorInit )
    g.afterLiveValidatorInit( options );
};