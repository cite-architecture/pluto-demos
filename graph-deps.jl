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
