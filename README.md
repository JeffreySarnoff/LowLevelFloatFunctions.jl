# LowLevelFloatFuncs.jl
Manipulate sign, exponent, significand of Float64, Float32, Float16 values.

## Exports

#### value extraction

sign, exponent, significand

#### field getting and setting

sign_field, exponent_field, signficand_field,    
sign_and_exponent_fields, exponent_and_significand_fields

#### characterizion

sign_bits, exponent_bits, significand_bits,    
exponent_max, exponent_min, exponent_field_max,    
exponent_bias

#### utilitiarian

bitwidth, hexstring
