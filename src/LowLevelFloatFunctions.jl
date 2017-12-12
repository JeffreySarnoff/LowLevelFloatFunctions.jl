module LowLevelFloatFunctions


export bitwidth, signbit, sign, precision, exponent, significand,
       exponent_max, exponent_min, exponent_field_max,
       sign_field, exponent_field, signficand_field,
       sign_and_exponent_fields, exponent_and_significand_fields

import Base.Math: precision, significand_bits, exponent_bits

const SysFloat = Union{Float64, Float32, Float16}

@inline bitwidth(::Type{T}) where T<:SysFloat = sizeof(T) * 8

@inline exponent_max(::Type{Float16})  =     15
@inline exponent_max(::Type{Float32})  =    127
@inline exponent_max(::Type{Float64})  =   1023

@inline exponent_min(::Type{T}) where T<:SysFloat = 1 - exponent_max(T)

@inline exponent_bias(::Type{T}) where T<:SysFloat = exponent_max(T)

@inline exponent_field_max(::Type{T}) where T<:SysFloat = exponent_max(T) + one(convert(Signed, T))

include("convert.jl")
include("fields.jl")

end # module LowLevelFloatFunctions
