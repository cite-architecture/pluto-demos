### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 39cf9c3a-5439-11eb-09f9-d777cd503b95
begin
	using Pkg
	Pkg.add("LightGraphs")
	Pkg.add("GraphPlot")
	Pkg.add("PlutoUI")
	
	using LightGraphs
	using GraphPlot
	using PlutoUI
end

# ╔═╡ 5c75a392-5439-11eb-2952-a71dbd0cd250
md"# Dependency relations of Cite Architcture Julia packages"

# ╔═╡ 970f8a8c-543a-11eb-0d5c-47d27c9a8bb3
md"""
Click to refresh the graph after editing:  $(@bind redraw Button("Redraw"))
"""

# ╔═╡ 606bf410-5439-11eb-3796-a3b6bc952d21
md"## Edit graph data"

# ╔═╡ 65ce68de-5439-11eb-30a3-8511f3cedf12
md"Nodes of the graph are package names:"


# ╔═╡ 6d2cfabe-5439-11eb-1160-63da373a5b25
pkglist = ["CitableBase", 
	"CitableObject", 
	"CitableText",
	"CitablePhysicalText"
]


# ╔═╡ 745d3218-5439-11eb-0f18-c1085a88de39
md"Edges are pairs of package names:"

# ╔═╡ 78c1a816-5439-11eb-164b-d5878ad7fe8f
edgelist = [
	("CitableObject", "CitableBase"),
	("CitableText", "CitableBase"),
	("CitablePhysicalText", "CitableText")
]

# ╔═╡ c159fa7c-5439-11eb-0a53-55b14afc4e5e
md"### Graph construction"

# ╔═╡ 81681130-5439-11eb-199d-bf2f79706a96
md"Define graph by number of nodes:"

# ╔═╡ 9801297c-5439-11eb-153c-ab58c5faa2b6
gr = SimpleDiGraph(length(pkglist) )


# ╔═╡ f14377e2-5439-11eb-1ecf-1fe748494042
begin 
	redraw
	gplot(gr, nodelabel=pkglist)
end

# ╔═╡ c81e0cb0-5439-11eb-0926-4783ab5b2bda
# Add edges to graph
begin
	for (src, target) in edgelist
		srcidx = findfirst(r -> r == src, pkglist)
		targetidx = findfirst(r -> r == target, pkglist)
		add_edge!(gr, srcidx, targetidx)
	end
	md"Added $(length(edgelist)) edges to graph."
end

# ╔═╡ Cell order:
# ╟─39cf9c3a-5439-11eb-09f9-d777cd503b95
# ╟─5c75a392-5439-11eb-2952-a71dbd0cd250
# ╟─970f8a8c-543a-11eb-0d5c-47d27c9a8bb3
# ╟─f14377e2-5439-11eb-1ecf-1fe748494042
# ╟─606bf410-5439-11eb-3796-a3b6bc952d21
# ╟─65ce68de-5439-11eb-30a3-8511f3cedf12
# ╠═6d2cfabe-5439-11eb-1160-63da373a5b25
# ╟─745d3218-5439-11eb-0f18-c1085a88de39
# ╠═78c1a816-5439-11eb-164b-d5878ad7fe8f
# ╟─c159fa7c-5439-11eb-0a53-55b14afc4e5e
# ╟─81681130-5439-11eb-199d-bf2f79706a96
# ╟─9801297c-5439-11eb-153c-ab58c5faa2b6
# ╠═c81e0cb0-5439-11eb-0926-4783ab5b2bda
