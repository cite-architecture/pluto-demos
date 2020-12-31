### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 2c2cc564-4b59-11eb-1c05-bd9711a4a255
begin
	using Pkg
	Pkg.add(url="https://github.com/cite-architecture/CitableText.jl")
	Pkg.add("HTTP")
	Pkg.add("CSV")
end

# ╔═╡ 6c780750-4b59-11eb-1802-a9789ae3b447
using CitableText

# ╔═╡ d5557334-4b59-11eb-20c1-7dfae2006a8a
using CSV, HTTP

# ╔═╡ 1b8c61f6-4b59-11eb-18fd-8fcdfdddc637
md"# Corpus experiments


## Using the `CitableText` module

`CitableText` has been submitted to the Julia package registry.  While waiting for it to be registered, you can use it directly from its github repository.
"

# ╔═╡ 994facd6-4b60-11eb-12c2-c91b7a6951f2
md"## Manually build a corpus

Let's manually build one from a CEX file using Julia's `CSV` module.

"

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
md"## Working with the array of citable nodes

Slice and dice, filter, whatever you like."

# ╔═╡ 0f92ccbc-4b60-11eb-2841-2dba4816906f
c.corpus[100:120]

# ╔═╡ 4fa371da-4b60-11eb-237a-0fd324cd1a2f
argonautsUrn = CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:14pr")

# ╔═╡ 5388caa2-4b60-11eb-0cd3-59a9ca43cf12
argonauts = filter(cn -> urncontains(argonautsUrn,cn.urn), c.corpus)

# ╔═╡ 9fe79104-4b78-11eb-0918-0d009561f84a
md"## Prototyping navigation

"

# ╔═╡ a610fe26-4b78-11eb-2186-517fe436321d
argotitle = argonauts[1]

# ╔═╡ cd2e2cf4-4b78-11eb-3f72-3b2990aa36b9
function nextnode(n::CitableNode,c::CitableCorpus)
	idx = findfirst(isequal(n),c.corpus)
	if idx == size(c.corpus)
		nothing
	else 
		c.corpus[idx + 1]
	end
end

# ╔═╡ 2f687dde-4b79-11eb-1283-c7423b1ff2b4
function prevnode(n::CitableNode,c::CitableCorpus)
	idx = findfirst(isequal(n),c.corpus)
	if idx == 1
		nothing
	else 
		c.corpus[idx - 1]
	end
end

# ╔═╡ 03e2810c-4b79-11eb-03d1-21a83006ab04
nextnode(argotitle,c)

# ╔═╡ 3f1f5c16-4b79-11eb-1d3b-eb7c99f3d0b3
prevnode(argotitle,c)

# ╔═╡ 4b39d6de-4b79-11eb-381e-b95904a1e018
argocorp = CitableCorpus(argonauts)

# ╔═╡ 54e53ade-4b79-11eb-1875-13d9dc979a2c
prevnode(argotitle, argocorp)

# ╔═╡ 61273e64-4b79-11eb-3b18-6955a930ad65
lastargo = argonauts[size(argonauts, 1)]

# ╔═╡ 9d76c81c-4b79-11eb-28b5-25ee882b7e5e


# ╔═╡ Cell order:
# ╟─1b8c61f6-4b59-11eb-18fd-8fcdfdddc637
# ╠═2c2cc564-4b59-11eb-1c05-bd9711a4a255
# ╠═6c780750-4b59-11eb-1802-a9789ae3b447
# ╠═d5557334-4b59-11eb-20c1-7dfae2006a8a
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
# ╠═9fe79104-4b78-11eb-0918-0d009561f84a
# ╠═a610fe26-4b78-11eb-2186-517fe436321d
# ╠═cd2e2cf4-4b78-11eb-3f72-3b2990aa36b9
# ╠═2f687dde-4b79-11eb-1283-c7423b1ff2b4
# ╠═03e2810c-4b79-11eb-03d1-21a83006ab04
# ╠═3f1f5c16-4b79-11eb-1d3b-eb7c99f3d0b3
# ╠═4b39d6de-4b79-11eb-381e-b95904a1e018
# ╠═54e53ade-4b79-11eb-1875-13d9dc979a2c
# ╠═61273e64-4b79-11eb-3b18-6955a930ad65
# ╠═9d76c81c-4b79-11eb-28b5-25ee882b7e5e
