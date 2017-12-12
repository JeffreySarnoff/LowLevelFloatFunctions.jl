if VERSION >= v"0.7.0-DEV-"
    using Test
else
    using Base.Test
end

@test 1==1
