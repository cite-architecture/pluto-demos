### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ cddba1fa-4a12-11eb-0083-8b60d520b800
# Ensure we don't depend on local installation of Julia by adding
# all packages here.

begin
	using Pkg
	Pkg.add("CitableText")
end

# ╔═╡ f53ece4a-4a12-11eb-2a0b-d7d17bfbcd67
using CitableText

# ╔═╡ ec8b8502-4a03-11eb-3d17-59ea4967eb39
md"""
# Canonical citation of texts with the Julia `CitableText` module

This notebook illustrates usage of the `CtsUrn` type in Julia's `CitableText` module.

"""

# ╔═╡ d4b8ff16-4a13-11eb-363c-0159c3f7e747
md"## `CtsUrn`s

The `CtsUrn` defines a syntax and semantics for citing passges of text. (See  [http://cite-architecture.org/ctsurn/](http://cite-architecture.org/ctsurn/) for more details and a formal specification of the syntax.)

The `CitableText` module's `CtsUrn` type supports:

- constructing and validating the syntax of CTS URNs
- manipulating the contents of URNs and generating new URNs programmatically
- comparison  using the semantics the CTS URN

"

# ╔═╡ 666545f8-4a14-11eb-2de4-4118a5c51831
md"# Constructing CTS URNs

The `CtsUrn` type has a single string member, called `urn`.
"


# ╔═╡ 7578892e-4a14-11eb-3b0c-ddd0451b19d9
iliadlines = CtsUrn("urn:cts:greekLit:tlg0012.tlg001.msA:1.1-1.2@οὐλομένην")

# ╔═╡ a40c3312-4a14-11eb-314f-6789b6bc0e3e
typeof(iliadlines)

# ╔═╡ acf5983a-4a14-11eb-3872-3fca6569e79b
iliadlines.urn

# ╔═╡ b1ea3844-4a14-11eb-2c78-472504fa39ba
typeof(iliadlines.urn)

# ╔═╡ 1b958d54-4a16-11eb-0347-515e8a3dcbe0
md"""See the long section below on "Validating URN syntax" for examples of the kinds of error checking the module performs."""


# ╔═╡ 3c650b42-4a16-11eb-06ff-d5f5ce59c690
md"## Manipulating CTS URNs

The module includes a series of functions taking a `CtsUrn` argument to extract and manipulate elements from a CTS URN.
"

# ╔═╡ 4b844980-4a16-11eb-1ac4-df2f5944d7fe
namespace(iliadlines)

# ╔═╡ 6f437da0-4a16-11eb-2d0b-e385e772d029
workcomponent(iliadlines)

# ╔═╡ 77324fd2-4a16-11eb-1b70-114bfa5ad980
passagecomponent(iliadlines)

# ╔═╡ cea3c344-4a17-11eb-04e3-81a82217e022
workdepth(iliadlines)

# ╔═╡ df0e0a28-4a17-11eb-2875-a560b11d11a9
passagedepth(iliadlines)

# ╔═╡ 230f2f54-4a18-11eb-237d-5958bcdd7e31
droppassage(iliadlines)

# ╔═╡ 29d2f398-4a18-11eb-332b-99a40cb2a155
dropversion(iliadlines)

# ╔═╡ 2fa4ba04-4a18-11eb-1985-7166b7840d5f
dropexemplar(iliadlines)

# ╔═╡ 3ba57c8a-4a18-11eb-3554-3d17012833cb
addexemplar(iliadlines,"tokens")

# ╔═╡ 47592478-4a18-11eb-10b8-731c35f95cc2
addversion(iliadlines,"version2")

# ╔═╡ 80183c10-4a16-11eb-2c56-99c34b1c907c
isrange(iliadlines)

# ╔═╡ bd997194-4a16-11eb-18f8-cb7c2d52c629
rangebegin(iliadlines)

# ╔═╡ c355597e-4a16-11eb-3588-2556d8535568
rangeend(iliadlines)

# ╔═╡ 9f78d164-4a16-11eb-3ce8-67318509a164
hassubref(iliadlines)

# ╔═╡ c8971998-4a16-11eb-27d5-0121fe54cdb0
#trimmed = dropsubref(iliadlines)

# ╔═╡ 717a5622-4a17-11eb-1522-4782b397a71c
collapsePassageTo(iliadlines,1)

# ╔═╡ 8a52bbc8-4a17-11eb-2e45-6ba00ba7b34f
collapsePassageBy(iliadlines,1)

# ╔═╡ 5a36f020-4a18-11eb-1238-4fbd740184d0
md"## Comparing pairs of URNs

"

# ╔═╡ 63d1dcb2-4a18-11eb-3d9b-69775eadf766
begin
	urn1 = CtsUrn("urn:cts:greekLit:tlg0012.tlg001.msA:1.1")
	urn2 = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
	urn3 =  CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1")
end

# ╔═╡ 8ba6360c-4a18-11eb-19e0-a1199a3ee4c1
workContains(urn2,urn1)

# ╔═╡ 921c2c26-4a18-11eb-33af-1f5ba380403a
workContains(urn1,urn2)

# ╔═╡ 9c902826-4a18-11eb-22f9-f78dcf7a37fe
passageContains(urn3, urn1)

# ╔═╡ a11dbece-4a18-11eb-0b89-0365764317d6
passageContains(urn1, urn3)

# ╔═╡ b5836ba2-4a18-11eb-0aff-1b695c6007be
urn2 > urn1

# ╔═╡ bf32d1c4-4a18-11eb-3367-3d7181676c5e
urn1 > urn2

# ╔═╡ c5f1bc32-4a18-11eb-322f-25318630fe49
urn3 > urn2

# ╔═╡ cfde7644-4a14-11eb-3ffe-6944c0124fa6
md"## Validating URN syntax

The following examples of *invalid* syntax in the `CtsUrn` constructor all throw `ArgumentError`s.
"

# ╔═╡ ef397248-4a14-11eb-3fdd-4da8296cf5ab
CtsUrn("way:too:short:")

# ╔═╡ 00ac1ef2-4a15-11eb-0584-89e8d81222a8
CtsUrn("urnX:cts:namespace:group:")

# ╔═╡ 134d1244-4a15-11eb-1692-73d97af3ef91
CtsUrn("urn:ctsX:namespace:group:")

# ╔═╡ 3966f7c8-4a15-11eb-192a-f1e7700da48f
CtsUrn("urn:cts::group:")


# ╔═╡ 605b82b6-4a15-11eb-0682-716ae7f2710e
CtsUrn("urn:cts:namespace::1")

# ╔═╡ 7dade5c0-4a15-11eb-105c-abbbd2df9fc4
md"It's OK for a passage component to be empty, but this must be explicitly indicatd with an empty fifth component."

# ╔═╡ 8cc0dd18-4a15-11eb-214d-5b522be1b829
CtsUrn("urn:cts:greekLit:tlg0012.tlg001:")

# ╔═╡ a86c4310-4a15-11eb-18c7-9df5dbf4f433
CtsUrn("urn:cts:greekLit:tlg0012.tlg001")

# ╔═╡ b08e1938-4a15-11eb-16e4-753e0ecd1ebb
md"### Validating ranges

If the passage component includes a range, it must comply with the proper range syntax.
"

# ╔═╡ c7747228-4a15-11eb-3457-f16ddde4ef1e
CtsUrn("urn:cts:ns:work:1-")

# ╔═╡ dbb9c544-4a15-11eb-02e5-75f20316d60a
CtsUrn("urn:cts:ns:work:1-2-3")

# ╔═╡ e66183e2-4a15-11eb-1b6b-bf6dc959c93b
CtsUrn("urn:cts:ns:work:-1")

# ╔═╡ 02c79b8e-4a16-11eb-3bc7-519120c18851
md"### Validating subreferences

If the passage component includes a subreference, it must comply with the proper  syntax.
"

# ╔═╡ 0fd79360-4a16-11eb-235d-3d9647bb116f


# ╔═╡ Cell order:
# ╟─ec8b8502-4a03-11eb-3d17-59ea4967eb39
# ╟─cddba1fa-4a12-11eb-0083-8b60d520b800
# ╠═f53ece4a-4a12-11eb-2a0b-d7d17bfbcd67
# ╠═d4b8ff16-4a13-11eb-363c-0159c3f7e747
# ╟─666545f8-4a14-11eb-2de4-4118a5c51831
# ╠═7578892e-4a14-11eb-3b0c-ddd0451b19d9
# ╠═a40c3312-4a14-11eb-314f-6789b6bc0e3e
# ╠═acf5983a-4a14-11eb-3872-3fca6569e79b
# ╠═b1ea3844-4a14-11eb-2c78-472504fa39ba
# ╟─1b958d54-4a16-11eb-0347-515e8a3dcbe0
# ╟─3c650b42-4a16-11eb-06ff-d5f5ce59c690
# ╠═4b844980-4a16-11eb-1ac4-df2f5944d7fe
# ╠═6f437da0-4a16-11eb-2d0b-e385e772d029
# ╠═77324fd2-4a16-11eb-1b70-114bfa5ad980
# ╠═cea3c344-4a17-11eb-04e3-81a82217e022
# ╠═df0e0a28-4a17-11eb-2875-a560b11d11a9
# ╠═230f2f54-4a18-11eb-237d-5958bcdd7e31
# ╠═29d2f398-4a18-11eb-332b-99a40cb2a155
# ╠═2fa4ba04-4a18-11eb-1985-7166b7840d5f
# ╠═3ba57c8a-4a18-11eb-3554-3d17012833cb
# ╠═47592478-4a18-11eb-10b8-731c35f95cc2
# ╠═80183c10-4a16-11eb-2c56-99c34b1c907c
# ╠═bd997194-4a16-11eb-18f8-cb7c2d52c629
# ╠═c355597e-4a16-11eb-3588-2556d8535568
# ╠═9f78d164-4a16-11eb-3ce8-67318509a164
# ╠═c8971998-4a16-11eb-27d5-0121fe54cdb0
# ╠═717a5622-4a17-11eb-1522-4782b397a71c
# ╠═8a52bbc8-4a17-11eb-2e45-6ba00ba7b34f
# ╟─5a36f020-4a18-11eb-1238-4fbd740184d0
# ╠═63d1dcb2-4a18-11eb-3d9b-69775eadf766
# ╠═8ba6360c-4a18-11eb-19e0-a1199a3ee4c1
# ╠═921c2c26-4a18-11eb-33af-1f5ba380403a
# ╠═9c902826-4a18-11eb-22f9-f78dcf7a37fe
# ╠═a11dbece-4a18-11eb-0b89-0365764317d6
# ╠═b5836ba2-4a18-11eb-0aff-1b695c6007be
# ╠═bf32d1c4-4a18-11eb-3367-3d7181676c5e
# ╠═c5f1bc32-4a18-11eb-322f-25318630fe49
# ╟─cfde7644-4a14-11eb-3ffe-6944c0124fa6
# ╠═ef397248-4a14-11eb-3fdd-4da8296cf5ab
# ╠═00ac1ef2-4a15-11eb-0584-89e8d81222a8
# ╠═134d1244-4a15-11eb-1692-73d97af3ef91
# ╠═3966f7c8-4a15-11eb-192a-f1e7700da48f
# ╠═605b82b6-4a15-11eb-0682-716ae7f2710e
# ╟─7dade5c0-4a15-11eb-105c-abbbd2df9fc4
# ╠═8cc0dd18-4a15-11eb-214d-5b522be1b829
# ╠═a86c4310-4a15-11eb-18c7-9df5dbf4f433
# ╟─b08e1938-4a15-11eb-16e4-753e0ecd1ebb
# ╠═c7747228-4a15-11eb-3457-f16ddde4ef1e
# ╠═dbb9c544-4a15-11eb-02e5-75f20316d60a
# ╠═e66183e2-4a15-11eb-1b6b-bf6dc959c93b
# ╟─02c79b8e-4a16-11eb-3bc7-519120c18851
# ╠═0fd79360-4a16-11eb-235d-3d9647bb116f
