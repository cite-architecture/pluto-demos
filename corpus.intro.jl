### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 2c2cc564-4b59-11eb-1c05-bd9711a4a255
# Idiom to keep definition of julia environment self-contained 
# in a replicable Pluto notebook.
begin
	using Pkg
	Pkg.add(url="https://github.com/cite-architecture/CitableText.jl")
	Pkg.add("HTTP")
	Pkg.add("CSV")
end

# ╔═╡ 6c780750-4b59-11eb-1802-a9789ae3b447
using CitableText, CSV, HTTP

# ╔═╡ 1b8c61f6-4b59-11eb-18fd-8fcdfdddc637
md"# Corpus experiments


## Using the `CitableText` module

`CitableText` has been submitted to the Julia package registry.  While waiting for it to be registered, you can use it directly from its github repository.
"

# ╔═╡ 8897c3d8-4b60-11eb-08bf-7bb72571eaa9
md"## Type for citable corpus 

This defines the new type we want to add to the package.
"

Let's manually build one from a CEX file using Julia's `CSV` module.

# ╔═╡ 994facd6-4b60-11eb-12c2-c91b7a6951f2
md"## Build from URL

Let's build one from a CEX file using Julia's `CSV` module."

# ╔═╡ f9b08e70-4b5a-11eb-25e4-c5a2928de42c
url = "https://raw.githubusercontent.com/LinguaLatina/texts/master/texts/latin23/hyginus.cex"

# ╔═╡ eeb3ffa0-4b5c-11eb-1cb5-45d8111a38cf
rawread = HTTP.get(url).body

# ╔═╡ f8bcd34e-4b59-11eb-380f-e1f0f1107e0c
f = CSV.File(rawread, skipto=2, delim="#")  |> Array

# ╔═╡ c79173f4-4b60-11eb-30e5-c972da4d4329
md"Map array of CSV rows to an array of `CitableNode`s, and we're as good as done."

# ╔═╡ 4d5e271e-4b5b-11eb-1a2c-298e2bcf6a7a
corpusdata = map(row -> (CitableNode(CtsUrn(row[1]), row[2])),  f)

# ╔═╡ fd3e82f4-4b5f-11eb-124c-579720e348d1
c = CitableCorpus(corpusdata)

# ╔═╡ e0761370-4b60-11eb-059e-0f7ee030193e
md"## Use the corpus

Slice and dice, filter, whatever you like."

# ╔═╡ 0f92ccbc-4b60-11eb-2841-2dba4816906f
c.corpus[100:120]

# ╔═╡ 4fa371da-4b60-11eb-237a-0fd324cd1a2f
argonautsUrn = CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:14pr")

# ╔═╡ 5388caa2-4b60-11eb-0cd3-59a9ca43cf12
argonauts = filter(cn -> urncontains(argonautsUrn,cn.urn), c.corpus)

# ╔═╡ 8919b148-4b62-11eb-29dc-bfcb23544f74
n1 = argonauts[1]

# ╔═╡ ab409d04-4b62-11eb-24bd-dd70aed72491
findfirst(isequal(n1), c.corpus)

# ╔═╡ d971a2e0-4b62-11eb-30e0-67cd81f88d99
c.corpus[98]

# ╔═╡ e8273c62-4b62-11eb-2d4c-13600de238f1
function indexof(n::CitableNode, corp::Corpus)
	findfirst(isequal(n), corp.corpus)
end

# ╔═╡ 58067cc0-4b63-11eb-040c-4d1d3feff520
function nextnode(n::CitableNode, corp::Corpus)
	idx = indexof(n,corp)
	if  idx == size(corp.corpus)
		throw(ArgumentError("Last node already."))
	else
		corp.corpus[idx + 1]
	end
end

# ╔═╡ 2b1d7cfe-4b63-11eb-2cbe-bd5aa27b2460
indexof(argonauts[4], c)

# ╔═╡ c622a79c-4b63-11eb-11ea-bd03e795bd36
argotitle = argonauts[1]

# ╔═╡ d7ec34fc-4b63-11eb-3e3e-dd4721536f98
nextnode(argotitle, c)

# ╔═╡ Cell order:
# ╟─1b8c61f6-4b59-11eb-18fd-8fcdfdddc637
# ╠═2c2cc564-4b59-11eb-1c05-bd9711a4a255
# ╠═6c780750-4b59-11eb-1802-a9789ae3b447
# ╟─8897c3d8-4b60-11eb-08bf-7bb72571eaa9
# ╠═faba8762-4b5f-11eb-1ed3-5d844bc5159e
# ╟─994facd6-4b60-11eb-12c2-c91b7a6951f2
# ╟─f9b08e70-4b5a-11eb-25e4-c5a2928de42c
# ╠═eeb3ffa0-4b5c-11eb-1cb5-45d8111a38cf
# ╠═f8bcd34e-4b59-11eb-380f-e1f0f1107e0c
# ╟─c79173f4-4b60-11eb-30e5-c972da4d4329
# ╠═4d5e271e-4b5b-11eb-1a2c-298e2bcf6a7a
# ╠═fd3e82f4-4b5f-11eb-124c-579720e348d1
# ╟─e0761370-4b60-11eb-059e-0f7ee030193e
# ╠═0f92ccbc-4b60-11eb-2841-2dba4816906f
# ╠═4fa371da-4b60-11eb-237a-0fd324cd1a2f
# ╠═5388caa2-4b60-11eb-0cd3-59a9ca43cf12
# ╠═8919b148-4b62-11eb-29dc-bfcb23544f74
# ╠═ab409d04-4b62-11eb-24bd-dd70aed72491
# ╠═d971a2e0-4b62-11eb-30e0-67cd81f88d99
# ╠═e8273c62-4b62-11eb-2d4c-13600de238f1
# ╠═58067cc0-4b63-11eb-040c-4d1d3feff520
# ╠═2b1d7cfe-4b63-11eb-2cbe-bd5aa27b2460
# ╠═c622a79c-4b63-11eb-11ea-bd03e795bd36
# ╠═d7ec34fc-4b63-11eb-3e3e-dd4721536f98
