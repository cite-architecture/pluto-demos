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

# ╔═╡ 3740f7be-4b8a-11eb-354c-d971845a192d
begin
	using Pkg
	Pkg.add(url="https://github.com/cite-architecture/CitableText.jl")
	Pkg.add("HTTP")
	Pkg.add("CSV")
end

# ╔═╡ 3ec55130-4b8a-11eb-3246-f5c38cbbd9ce
using CSV, HTTP, CitableText, PlutoUI

# ╔═╡ 189536c2-4b8a-11eb-1b90-4b88e25c7d08
md"# Browsing a corpus

Load a corpus from a CEX file retreived from the URL in the next cell.
"

# ╔═╡ 6807cdbe-4b8a-11eb-2000-87db7a04c957
url = 
"https://raw.githubusercontent.com/LinguaLatina/texts/master/texts/latin23/hyginus.cex"


# ╔═╡ 46149d1c-4b8e-11eb-0a26-2980182a01c5
html"""
<p> <span class="highlight">Important!</span> Less so.</p>
"""

# ╔═╡ 4bd027a4-4b8f-11eb-24a6-e1181025abbc
begin
	sections = 
end

# ╔═╡ 43d2ad54-4b91-11eb-1c47-d1a5f3dea0a8
manual = "urn:cts:latinLit:stoa1263.stoa001.hc:8pr"

# ╔═╡ 3e4ea634-4b8d-11eb-2c7d-65bd10735550
css = html"""
<style>
.highlight {
  background: yellow;  
}
</style>
"""

# ╔═╡ 2e654794-4b8a-11eb-1ee5-f5537a85792f
md"---

Code requirements
"

# ╔═╡ 4d80c81a-4b8a-11eb-3cf4-c3329e9a1cad
md"---

Manually load and build a corpus for Hyginus.
"

# ╔═╡ 82addbb8-4b8f-11eb-1a63-29e04343ca15


# ╔═╡ 8bfc763e-4b8a-11eb-08d2-c782c24cabf3
raw = HTTP.get(url).body

# ╔═╡ 846531b8-4b8a-11eb-160b-bf97ff3a74fd
rawarray = CSV.File(raw, skipto=2, delim="#")  |> Array

# ╔═╡ cbc377b8-4b8a-11eb-3b4a-21c50dba8dbb
corpusdata = map(row -> (CitableNode(CtsUrn(row[1]), row[2])),  rawarray)

# ╔═╡ d4554974-4b8a-11eb-02ea-5d49e1c9fb5d
c = CitableCorpus(corpusdata)

# ╔═╡ d4917098-4b8f-11eb-28ea-fd42a0977f05
function retrieve(s::String)
	u = CtsUrn(s)
	filtered = filter(n -> urncontains(u,n.urn), c.corpus)
	filtered
	
end

# ╔═╡ 4b74c150-4b91-11eb-14af-0f65a41191d6
retrieve(manual)

# ╔═╡ 04044e72-4b8b-11eb-2ce3-f7260785dbe0
chapters = unique(map(cn -> collapsePassageBy(cn.urn, 1).urn, c.corpus))

# ╔═╡ e11393a4-4b8b-11eb-36ec-f92776686cba
md"""
Loaded a corpus with $(size(c.corpus, 1)) citable nodes in $(size(chapters,1)) chapters

"""

# ╔═╡ 667448dc-4b8e-11eb-1d03-2d54c3159bcd
md"""
Select a chapter $(@bind chapter Select(chapters))
"""

# ╔═╡ 4032f868-4b8f-11eb-0292-09c51ef7d558
chapter

# ╔═╡ 8e951a72-4b8f-11eb-3434-e3a4fbbc7ed9
retrieve(chapter)

# ╔═╡ fdc87cf8-4b90-11eb-0d5b-8104b5a3b8dd
c.corpus[100]

# ╔═╡ Cell order:
# ╟─189536c2-4b8a-11eb-1b90-4b88e25c7d08
# ╟─6807cdbe-4b8a-11eb-2000-87db7a04c957
# ╟─e11393a4-4b8b-11eb-36ec-f92776686cba
# ╟─46149d1c-4b8e-11eb-0a26-2980182a01c5
# ╟─667448dc-4b8e-11eb-1d03-2d54c3159bcd
# ╠═4032f868-4b8f-11eb-0292-09c51ef7d558
# ╠═4bd027a4-4b8f-11eb-24a6-e1181025abbc
# ╠═8e951a72-4b8f-11eb-3434-e3a4fbbc7ed9
# ╠═d4917098-4b8f-11eb-28ea-fd42a0977f05
# ╠═43d2ad54-4b91-11eb-1c47-d1a5f3dea0a8
# ╠═4b74c150-4b91-11eb-14af-0f65a41191d6
# ╟─3e4ea634-4b8d-11eb-2c7d-65bd10735550
# ╟─2e654794-4b8a-11eb-1ee5-f5537a85792f
# ╠═3740f7be-4b8a-11eb-354c-d971845a192d
# ╠═3ec55130-4b8a-11eb-3246-f5c38cbbd9ce
# ╠═4d80c81a-4b8a-11eb-3cf4-c3329e9a1cad
# ╠═82addbb8-4b8f-11eb-1a63-29e04343ca15
# ╟─04044e72-4b8b-11eb-2ce3-f7260785dbe0
# ╠═8bfc763e-4b8a-11eb-08d2-c782c24cabf3
# ╠═846531b8-4b8a-11eb-160b-bf97ff3a74fd
# ╠═cbc377b8-4b8a-11eb-3b4a-21c50dba8dbb
# ╠═d4554974-4b8a-11eb-02ea-5d49e1c9fb5d
# ╠═fdc87cf8-4b90-11eb-0d5b-8104b5a3b8dd
