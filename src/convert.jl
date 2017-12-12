
# convert used as a generalized reinterpret

@inline Base.convert(::Type{Unsigned}, ::Type{Float16}) = UInt16
@inline Base.convert(::Type{Unsigned}, ::Type{Float32}) = UInt32
@inline Base.convert(::Type{Unsigned}, ::Type{Float64}) = UInt64

@inline Base.convert(::Type{SysFloat}, ::Type{UInt16}) = Float16
@inline Base.convert(::Type{SysFloat}, ::Type{UInt32}) = Float32
@inline Base.convert(::Type{SysFloat}, ::Type{UInt64}) = Float64

@inline Base.convert(::Type{Unsigned}, x::Float16) = reinterpret(Unsigned, x)
@inline Base.convert(::Type{Unsigned}, x::Float32) = reinterpret(Unsigned, x)
@inline Base.convert(::Type{Unsigned}, x::Float64) = reinterpret(Unsigned, x)

@inline Base.convert(::Type{SysFloat}, x::UInt16) = reinterpret(Float16, x)
@inline Base.convert(::Type{SysFloat}, x::UInt32) = reinterpret(Float32, x)
@inline Base.convert(::Type{SysFloat}, x::UInt64) = reinterpret(Float64, x)

@inline Base.convert(::Type{UInt16}, x::Float16) = reinterpret(UInt16, x)
@inline Base.convert(::Type{UInt32}, x::Float32) = reinterpret(UInt32, x)
@inline Base.convert(::Type{UInt64}, x::Float64) = reinterpret(UInt64, x)

@inline Base.convert(::Type{Float16}, x::UInt16) = reinterpret(Float16, x)
@inline Base.convert(::Type{Float32}, x::UInt32) = reinterpret(Float32, x)
@inline Base.convert(::Type{Float64}, x::UInt64) = reinterpret(Float64, x)

@inline Base.convert(::Type{Unsigned}, ::Type{Float16}) = UInt16
@inline Base.convert(::Type{Unsigned}, ::Type{Float32}) = UInt32
@inline Base.convert(::Type{Unsigned}, ::Type{Float64}) = UInt64

@inline Base.convert(::Type{SysFloat}, ::Type{UInt16}) = Float16
@inline Base.convert(::Type{SysFloat}, ::Type{UInt32}) = Float32
@inline Base.convert(::Type{SysFloat}, ::Type{UInt64}) = Float64

@inline Base.convert(::Type{Signed}, x::Float16) = reinterpret(Signed, x)
@inline Base.convert(::Type{Signed}, x::Float32) = reinterpret(Signed, x)
@inline Base.convert(::Type{Signed}, x::Float64) = reinterpret(signed, x)

@inline Base.convert(::Type{SysFloat}, x::Int16) = reinterpret(Float16, x)
@inline Base.convert(::Type{SysFloat}, x::Int32) = reinterpret(Float32, x)
@inline Base.convert(::Type{SysFloat}, x::Int64) = reinterpret(Float64, x)

@inline Base.convert(::Type{Int16}, x::Float16) = reinterpret(Int16, x)
@inline Base.convert(::Type{Int32}, x::Float32) = reinterpret(Int32, x)
@inline Base.convert(::Type{Int64}, x::Float64) = reinterpret(Int64, x)

@inline Base.convert(::Type{Float16}, x::Int16) = reinterpret(Float16, x)
@inline Base.convert(::Type{Float32}, x::Int32) = reinterpret(Float32, x)
@inline Base.convert(::Type{Float64}, x::Int64) = reinterpret(Float64, x)
