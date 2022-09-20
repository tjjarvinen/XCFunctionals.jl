# Tutorial

## List all functionals

```@example 1
using XCFunctionals

list_functionals()
```

Search for functionals with specific name

```@example 1
list_functionals("gga")
```

## Generate symbolic represenations for functionals

```@example 1
xc = generate_functional("lda_example")
xc.xc
```

Derivatives

```@example 1
generate_functional_derivatives!(xc, 2)
println(xc.derivatives[1])
println(xc.derivatives[2])
```

## Generate code for functionals

```@example 1
xc = build_functional("lda_example", 1,2,3)

# First derivative
xc[1]
```

Generate C code

```@example 1
xc = build_functional("lda_example", 1,2,3; target=CTarget())

# First derivative
print(xc[1])
```

Compile Julia code

```@example 1
xc = build_functional("lda_example", 1,2,3; compile=true)

# First derivative
xc[1](1.2)

# Array input
xc[1].( rand(3) )
```

### GPU calculation

Standard broadcasting works with GPUs

```julia
using Cuda
ρ = rand(3)
ρ_cuda = CuArray(ρ)
xc[1].( ρ_cuda )
```

```julia
using AMDGPU
ρ = rand(3)
ρ_rocm = ROCArray(ρ)
xc[1].( ρ_rocm )
```

```julia
using OneAPI
ρ = rand(3)
ρ_one = oneArray(ρ)
xc[1].( ρ_one )
```
