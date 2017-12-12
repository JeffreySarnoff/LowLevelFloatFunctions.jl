module LowLevelFloatFunctions

export bitwidth, signbit, sign, precision, exponent, significand,
       sign_bits, exponent_bits, significand_bits,
       exponent_max, exponent_min, exponent_field_max, exponent_bias,
       sign_field, exponent_field, significand_field,
       sign_and_exponent_fields, exponent_and_significand_fields,
       hexstring

import Base.Math: precision, significand_bits, exponent_bits

const SysFloat = Union{Float64, Float32, Float16}

"""
    hexstring(x)

like bitstring(x), with hexadecimal digits
"""
hexstring(x::T) where T<:SysFloat = hex(convert(Unsigned, x), sizeof(x) * 2)
hexstring(x::T) where T<:Union{Signed, Unsigned} = hex(x)

# extend coverage to Unsigneds for field processing functions

for F in (:precision, :significand_bits, :exponent_bits)
    for (T,U) in ((:Float64, :UInt64), (:Float32, :UInt32), (:Float16, :UInt16))
        @eval begin
            @inline $F(::Type{$U}) = $F($T)
        end
    end
end

@inline sign_bits(::Type{T}) where T<:SysFloat = 1
@inline sign_bits(::Type{T}) where T<:Union{UInt64, UInt32, UInt16} = 1

@inline bitwidth(::Type{T}) where T = sizeof(T) * 8

@inline exponent_max(::Type{Float16})  =     15
@inline exponent_max(::Type{Float32})  =    127
@inline exponent_max(::Type{Float64})  =   1023

@inline exponent_min(::Type{T}) where T<:SysFloat = 1 - exponent_max(T)

@inline exponent_bias(::Type{T}) where T<:SysFloat = exponent_max(T)

@inline exponent_field_max(::Type{T}) where T<:SysFloat = exponent_max(T) + one(convert(Signed, T))

# extend coverage to Unsigneds for field processing functions

for F in (:exponent_max, :exponent_min, :exponent_bias, :exponent_field_min)
    for (T,U) in ((:Float64, :UInt64), (:Float32, :UInt32), (:Float16, :UInt16))
        @eval begin
            @inline $F(::Type{$U}) = $F($T)
        end
    end
end

include("convert.jl")
include("fields.jl")exponent(sqrt2₆₄), exponent(-sqrt2₃₂), exponent(sqrt2₁₆)
54
(0, 0, 0)

end # module LowLevelFloatFunctions
