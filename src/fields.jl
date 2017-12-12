# field[s] offset (shift by)

@inline sign_field_offset(::Type{T}) where T<:SysFloat = bitwidth(T) - one(convert(Signed, T))
@inline exponent_field_offset(::Type{T}) where T<:SysFloat = sign_field_offset(T) - exponent_bits(T)
@inline significand_field_offset(::Type{T}) where T<:SysFloat = zero(convert(Signed, T))
@inline sign_and_exponent_fields_offset(::Type{T}) where T<:SysFloat = exponent_field_offset(T)
@inline exponent_and_significand_fields_offset(::Type{T}) where T<:SysFloat = significand_field_offset(T)

# field[s] filter and mask

@inline sign_field_filter(::Type{T}) where T<:Unsigned = ~(zero(T)) >>> 1
@inline sign_and_exponent_fields_filter(::Type{T}) where T<:Unsigned = ~(zero(T)) >>> (exponent_bits(T) + 1)
@inline exponent_field_filter(::Type{T}) where T<:Unsigned = sign_and_exponent_fields_filter(T) | sign_field_mask(T)
@inline significand_field_filter(::Type{T}) where T<:Unsigned = ~sign_and_exponent_fields_filter(T)
@inline exponent_and_significand_fields_filter(::Type{T}) where T<:Unsigned = ~(sign_field_filter(T))

@inline sign_field_filter(::Type{T}) where T<:SysFloat = ~(zero(convert(Unsigned,T))) >>> 1
@inline sign_and_exponent_fields_filter(::Type{T}) where T<:SysFloat = ~(zero(convert(Unsigned,T))) >>> (exponent_bits(T) + 1)
@inline exponent_field_filter(::Type{T}) where T<:SysFloat = sign_and_exponent_fields_filter(T) | sign_field_mask(T)
@inline significand_field_filter(::Type{T}) where T<:SysFloat = ~sign_and_exponent_fields_filter(T)
@inline exponent_and_significand_fields_filter(::Type{T}) where T<:SysFloat = ~(sign_field_filter(T))

@inline sign_field_mask(::Type{T}) where T<:Unsigned = ~sign_field_filter(T)
@inline sign_and_exponent_fields_mask(::Type{T}) where T<:Unsigned = ~sign_and_exponent_fields_filter(T)
@inline exponent_field_mask(::Type{T}) where T<:Unsigned = ~exponent_field_filter(T)
@inline significand_field_mask(::Type{T}) where T<:Unsigned = ~sign_and_exponent_fields_mask(T)
@inline exponent_and_significand_fields_mask(::Type{T}) where T<:Unsigned = ~exponent_and_significand_fields_mask(T)

@inline sign_field_mask(::Type{T}) where T<:SysFloat = ~sign_field_filter(T)
@inline sign_and_exponent_fields_mask(::Type{T}) where T<:SysFloat = ~sign_and_exponent_fields_filter(T)
@inline exponent_field_mask(::Type{T}) where T<:SysFloat = ~exponent_field_filter(T)
@inline significand_field_mask(::Type{T}) where T<:SysFloat = ~sign_and_exponent_fields_mask(T)
@inline exponent_and_significand_fields_mask(::Type{T}) where T<:SysFloat = ~exponent_and_significand_fields_mask(T)

@inline sign_field_mask_lsbs(::Type{T}) where T<:SysFloat = sign_field_mask(T) >> sign_field_offset(T)
@inline exponent_field_mask_lsbs(::Type{T}) where T<:SysFloat = exponent_field_mask(T) >> exponent_field_offset(T)
@inline significand_field_mask_lsbs(::Type{T}) where T<:SysFloat = significand_fields_mask(T) >> significand_field_offset(T)
@inline sign_and_exponent_fields_mask_lsbs(::Type{T}) where T<:SysFloat = sign_and_exponent_fields_mask(T) >> exponent_field_offset(T)
@inline exponent_and_significand_fields_mask_lsbs(::Type{T}) where T<:SysFloat = exponent_and_significand_fields_mask(T) >> significand_field_offset(T)

# isolate the field[s] from other bits and yield the field value, as Unsigned bits in place

@inline isolate_sign_field(x::T) where T<:Unsigned = x & sign_field_mask(T)
@inline isolate_exponent_field(x::T) where T<:Unsigned = x & exponent_field_mask(T)
@inline isolate_significand_field(x::T) where T<:Unsigned = x & significand_field_mask(T)
@inline isolate_sign_and_exponent_fields(x::T) where T<:Unsigned = x & sign_and_exponent_field_mask(T)
@inline isolate_exponent_and_significand_fields(x::T) where T<:Unsigned = x & sign_field_filter(T)
@inline isolate_sign_and_significand_fields(x::T) where T<:Unsigned = x & exponent_field_mask(T)

# clear the field[s] and yield the value, as Unsigned bits in place

@inline clear_sign_field(x::T) where T<:SysFloat = convert(Unsigned, x) & sign_field_filter(T)
@inline clear_exponent_field(x::T) where T<:SysFloat = convert(Unsigned, x) & exponent_field_filter(T)
@inline clear_significand_field(x::T) where T<:SysFloat = convert(Unsigned, x) & significand_field_filter(T)
@inline clear_sign_and_exponent_fields(x::T) where T<:SysFloat = convert(Unsigned, x) && sign_and_exponent_fields_filter(T)
@inline clear_exponent_and_significand_fields(x::T) where T<:SysFloat = convert(Unsigned, x) & exponent_and_significand_fields_filter(T)

# fetch the field[s] into the low order bits of an Unsigned

@inline sign_field(x::T) where T<:Unsigned = isolate_sign_field(x) >> sign_field_offset(T)
@inline exponent_field(x::T) where T<:Unsigned = isolate_exponent_field(x) >> exponent_field_offset(T)
@inline significand_field(x::T) where T<:Unsigned = isolate_significand_field(x) >> significand_field_offset(T)
@inline sign_and_exponent_fields(x::T) where T<:Unsigned = isolate_sign_and_exponent_fields(x) >> exponent_field_offset(T)
@inline exponent_and_significand_fields(x::T) where T<:Unsigned = isolate_exponent_and_significand_fields(x) >> significand_field_offset(T)

for F in (:sign_field, :exponent_field, :significand_field, :sign_and_exponent_fields, :exponent_and_significand_fields)
  @eval begin
    @inline $F(x::T) where T<:SysFloat = $F(convert(Unsigned,x))
  end
end

# prepare Unsigned low order bits to occupy field[s]

@inline prepare_sign_field(x::T) where T<:Unsigned = (x & sign_field_mask_lsbs(T)) << sign_field_offset(T)
@inline prepare_exponent_field(x::T) where T<:Unsigned = (x & exponent_field_mask_lsbs(T)) << exponent_field_offset(T)
@inline prepare_significand_field(x::T) where T<:Unsigned = (x & significand_field_mask_lsbs(T)) << significand_field_offset(T)
@inline prepare_sign_and_exponent_fields(x::T) where T<:Unsigned = (x & sign_and_exponent_fields_mask_lsbs(T)) << exponent_field_offset(T)
@inline prepare_exponent_and_significand_fields(x::T) where T<:Unsigned = (x & exponent_and_significand_fields_mask_lsbs(T)) << exponent_and_significand_fields_offset(T)

# set field[s]: sign_field(1.0, 1%UInt64) == -1.0

for (F,C,P) in ((:sign_field, :clear_sign_field, :prepare_sign_field),
                (:exponent_field, :clear_exponent_field, :prepare_exponent_field),
                (:significand_field, :clear_significand_field, :prepare_significand_field),
                (:sign_and_exponent_fields, :clear_sign_and_exponent_fields, :prepare_sign_and_exponent_fields),
                (:exponent_and_significand_fields, :clear_exponent_and_significand_fields, :prepare_exponent_and_significand_fields))
  for (T,U) in ((:Float64, :UInt64), (:Float32, :UInt32), (:Float16, :UInt16))
    @eval begin
        @inline $F(x::$T, y::$U) = convert($T, $C(convert($U, x)) | $P(y))
    end
  end
end
