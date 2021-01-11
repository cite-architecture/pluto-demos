### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 39cf9c3a-5439-11eb-09f9-d777cd503b95
begin
	using Pkg
	Pkg.add("LightGraphs")
	Pkg.add("GraphPlot")
	
	using LightGraphs
	using GraphPlot
end

# ╔═╡ 5c75a392-5439-11eb-2952-a71dbd0cd250
md"# Dependency relations of Cite Architcture Julia packages"

# ╔═╡ 606bf410-5439-11eb-3796-a3b6bc952d21
md"## Graph data"

# ╔═╡ 65ce68de-5439-11eb-30a3-8511f3cedf12
md"Nodes of the graph are package names:"


# ╔═╡ 6d2cfabe-5439-11eb-1160-63da373a5b25
pkglist = ["CitableBase", "CitableObject", "CitableText"]


# ╔═╡ 745d3218-5439-11eb-0f18-c1085a88de39
md"Edges are pairs of package names:"

# ╔═╡ 78c1a816-5439-11eb-164b-d5878ad7fe8f
edgelist = [
	("CitableObject", "CitableBase"),
	("CitableText", "CitableBase")
	]

# ╔═╡ 81681130-5439-11eb-199d-bf2f79706a96
md"Define graph by number of nodes:"

# ╔═╡ 9801297c-5439-11eb-153c-ab58c5faa2b6
gr = SimpleDiGraph(length(pkglist) )


# ╔═╡ Cell order:
# ╟─39cf9c3a-5439-11eb-09f9-d777cd503b95
# ╟─5c75a392-5439-11eb-2952-a71dbd0cd250
# ╟─606bf410-5439-11eb-3796-a3b6bc952d21
# ╟─65ce68de-5439-11eb-30a3-8511f3cedf12
# ╠═6d2cfabe-5439-11eb-1160-63da373a5b25
# ╟─745d3218-5439-11eb-0f18-c1085a88de39
# ╠═78c1a816-5439-11eb-164b-d5878ad7fe8f
# ╟─81681130-5439-11eb-199d-bf2f79706a96
# ╟─9801297c-5439-11eb-153c-ab58c5faa2b6
