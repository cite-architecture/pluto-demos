### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 81dfe088-5435-11eb-27d8-011b1e5f053b
begin
	using Pkg
	Pkg.add("LightGraphs")
	Pkg.add("GraphPlot")
	
	using LightGraphs
	using GraphPlot
end

<<<<<<< HEAD
# ╔═╡ 27301f74-5438-11eb-38ed-0332fb257da1
md"# Dependency relations of Cite Architcture Julia packages"

# ╔═╡ 3e93be32-5438-11eb-1016-6903268f197b
md"## Graph data"


# ╔═╡ 5b9e803e-5438-11eb-3278-536b407d6735
md"Nodes of the graph are package names:"

# ╔═╡ 2148e11a-5436-11eb-237e-070efe632360
pkglist = ["CitableBase", "CitableObject", "CitableText"]

# ╔═╡ 49a27926-5438-11eb-2186-2d300145a1a7
md"Edges are pairs of package names:"

# ╔═╡ 8890c43a-5436-11eb-02b1-e1264a22c2c5
edgelist = [
	("CitableObject", "CitableBase"),
	("CitableText", "CitableBase")
	]

# ╔═╡ 6a9b3b8e-5438-11eb-229e-af2e51393013
md"""
Graph definition
"""

# ╔═╡ b139bda4-5435-11eb-30d4-dde91c20bfed
gr = SimpleDiGraph(length(pkglist) )

# ╔═╡ a8c7fc98-5436-11eb-2e19-9feedbff87cd
for (src, target) in edgelist
	srcidx = findfirst(r -> r == src, pkglist)
	targetidx = findfirst(r -> r == target, pkglist)
	add_edge!(gr, srcidx, targetidx)
end

# ╔═╡ cc8f1608-5435-11eb-272f-a151f2dec205
gplot(gr, nodelabel=pkglist)

# ╔═╡ Cell order:
# ╟─81dfe088-5435-11eb-27d8-011b1e5f053b
# ╟─27301f74-5438-11eb-38ed-0332fb257da1
# ╟─a8c7fc98-5436-11eb-2e19-9feedbff87cd
# ╟─cc8f1608-5435-11eb-272f-a151f2dec205
# ╟─3e93be32-5438-11eb-1016-6903268f197b
# ╟─5b9e803e-5438-11eb-3278-536b407d6735
# ╟─2148e11a-5436-11eb-237e-070efe632360
# ╟─49a27926-5438-11eb-2186-2d300145a1a7
# ╟─8890c43a-5436-11eb-02b1-e1264a22c2c5
# ╟─6a9b3b8e-5438-11eb-229e-af2e51393013
# ╟─b139bda4-5435-11eb-30d4-dde91c20bfed
=======
# ╔═╡ b139bda4-5435-11eb-30d4-dde91c20bfed
G₁ = Graph(3) 

# ╔═╡ c34aae16-5435-11eb-3e36-77aeaea93675
begin
	add_edge!(G₁, 1, 2)
	add_edge!(G₁, 1, 3)
	add_edge!(G₁, 2, 3)
end

# ╔═╡ cc8f1608-5435-11eb-272f-a151f2dec205
gplot(G₁, nodelabel=1:3)

# ╔═╡ Cell order:
# ╠═81dfe088-5435-11eb-27d8-011b1e5f053b
# ╠═b139bda4-5435-11eb-30d4-dde91c20bfed
# ╠═c34aae16-5435-11eb-3e36-77aeaea93675
# ╠═cc8f1608-5435-11eb-272f-a151f2dec205
>>>>>>> 9b2f43de4bbf5da7fffd5b59af9533a881b0f1cb
