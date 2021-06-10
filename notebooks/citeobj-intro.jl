### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ ef917192-4c69-11eb-3564-252b202719e2
begin
	using Pkg
	Pkg.add(url="https://github.com/cite-architecture/CitableObject.jl")
	Pkg.add("CitableBase")
end

# ╔═╡ ef5f2f02-4c69-11eb-0f7c-236be9573055
using CitableObject, CitableBase

# ╔═╡ dbde96fe-4c69-11eb-1cfe-db135b98715b
md"""
# Introducing the `CitableObject` module
"""

# ╔═╡ 0ebe40a2-4c6a-11eb-0539-6768fc9916ea
u = Cite2Urn("urn:cite2:hmt:msA.v1:12r")

# ╔═╡ c3065b3c-4c6a-11eb-36ba-df487255bdbd


# ╔═╡ c2a96e0e-4c6a-11eb-3d45-4fdc157be814
md"`Cite2Urn` is a subtype of `Urn`."

# ╔═╡ da9f0706-4c6a-11eb-0336-d5eadfb8a06c
supertype(Cite2Urn)

# ╔═╡ e3b0e6c2-4c6a-11eb-14c9-f32e17465699
md"CtsUrns will be in this list very soon once the published package is on Julia Registry"

# ╔═╡ 7ccf2ef0-4c6a-11eb-053a-8d36bef3a6a8
subtypes(Urn)

# ╔═╡ Cell order:
# ╟─dbde96fe-4c69-11eb-1cfe-db135b98715b
# ╠═ef917192-4c69-11eb-3564-252b202719e2
# ╠═ef5f2f02-4c69-11eb-0f7c-236be9573055
# ╠═0ebe40a2-4c6a-11eb-0539-6768fc9916ea
# ╠═c3065b3c-4c6a-11eb-36ba-df487255bdbd
# ╠═c2a96e0e-4c6a-11eb-3d45-4fdc157be814
# ╠═da9f0706-4c6a-11eb-0336-d5eadfb8a06c
# ╟─e3b0e6c2-4c6a-11eb-14c9-f32e17465699
# ╠═7ccf2ef0-4c6a-11eb-053a-8d36bef3a6a8
