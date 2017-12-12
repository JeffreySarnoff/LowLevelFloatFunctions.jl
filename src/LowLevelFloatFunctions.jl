module LowLevelFloatFunctions


export bitwidth, signbit, sign, precision, exponent, significand,
       exponent_max, exponent_min, exponent_field_max,
       get_sign_field, get_exponent_field, get_signficand_field,
       get_sign_and_exponent_fields, get_exponent_and_significand_fields,
       set_sign_field, set_exponent_field, set_signficand_field,
       set_sign_and_exponent_fields, set_exponent_and_significand_fields

import Base.Math: precision, significand_bits, exponent_bits

const SysFloat = Union{Float64, Float32, Float16}

@inline bitwidth(::Type{T}) where T<:SysFloats = sizeof(T) * 8

@inline exponent_max(::Type{Float16})  =     15
@inline exponent_max(::Type{Float32})  =    127
@inline exponent_max(::Type{Float64})  =   1023

@inline exponent_min(::Type{T}) where T<:SysFloats = 1 - exponent_max(T)

@inline exponent_bias(::Type{T}) where T<:SysFloats = exponent_max(T)

@inline exponent_field_max(::Type{T}) where T<:SysFloats = exponent_max(T) + one(convert(Signed, T))

include("convert.jl")
include("fields.jl")

end # module LowLevelFloatFunctions
