# LowLevelFloatFunctions.jl
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

## Use

These values are used throughout.

```julia
sqrt2₆₄ = sqrt(2.0)
sqrt2₃₂ = sqrt(2.0f0)
sqrt2₁₆ = sqrt(Float16(2.0))

max16₆₄ = Float64(realmax(Float16))
max16₃₂ = Float32(realmax(Float16))
max16₁₆ = realmax(Float16)
```

#### value extraction

```julia
julia> sqrt2₆₄ = sqrt(2.0); sqrt2₃₂ = sqrt(2.0f0); sqrt2₁₆ = sqrt(Float16(2.0));

julia> sign(-sqrt2₆₄), sign(sqrt2₃₂), sign(-sqrt2₁₆)
(-1.0, 1.0f0, Float16(-1.0))
julia> exponent(-sqrt2₆₄), exponent(sqrt2₃₂), exponent(-sqrt2₁₆)
(0, 0, 0)
julia> significand(-sqrt2₆₄), significand(sqrt2₃₂), significand(-sqrt2₁₆)
(-1.4142135623730951, 1.4142135f0, Float16(-1.414))
```
#### field getting and setting
```julia
julia> sqrt2₆₄ = sqrt(2.0); sqrt2₃₂ = sqrt(2.0f0); sqrt2₁₆ = sqrt(Float16(2.0));

julia> sign_field(-sqrt2₆₄), sign_field(sqrt2₃₂), sign_field(-sqrt2₁₆)
(0x0000000000000001, 0x00000000, 0x0001)

julia> exponent_field(-sqrt2₆₄), exponent_field(sqrt2₃₂), exponent_field(-sqrt2₁₆)
(0x00000000000003ff, 0x0000007f, 0x000f)

julia> significand_field(sqrt2₆₄), significand_field(sqrt2₃₂), significand_field(sqrt2₁₆)
(0x0006a09e667f3bcd, 0x003504f3, 0x01a8)


julia> sign_field(-sqrt2₆₄, 0%UInt64)

julia> exponent_field(-sqrt2₆₄, exponent_field(-sqrt2₆₄)*2%UInt64)

julia> significand_field(-sqrt2₃₂, significand_field(-sqrt2₃₂)*2%UInt64)
```
#### characterizion
```julia
julia> sqrt2₆₄ = sqrt(2.0); sqrt2₃₂ = sqrt(2.0f0); sqrt2₁₆ = sqrt(Float16(2.0));

julia> sign_bits(Float64), exponent_bits(Float32), significand_bits(Float16)

julia> exponent_field_max(Float64), exponent_max(Float64), exponent_min(Float64)    

julia> exponent_bias(Float32)
```
#### utilitiarian
```julia
julia> sqrt2₆₄ = sqrt(2.0); sqrt2₃₂ = sqrt(2.0f0); sqrt2₁₆ = sqrt(Float16(2.0));

julia> bitwidth(Float64), bitwidth(Float32)

julia> hexstring(sqrt2₆₄), hexstring(sqrt2₃₂)
```
