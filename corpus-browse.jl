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

# ╔═╡ 596c1884-4b9c-11eb-3273-35a043fa22b6
md"""# Browse a citable corpus

This Julia note lets you browse a citable corpus by:

1. Loading a CEX file at the URL give in the next cell (default:  Hyginus, *Fabulae*).
2. Constructing a selection menu by collapsing all URNs in the corpus one level (for Hyginus, collapse sections to chaptes).
3. Using URN matching on the citable corpus to retrieve and display content for the selected chapter.
"""

# ╔═╡ 6807cdbe-4b8a-11eb-2000-87db7a04c957
url = 
"https://raw.githubusercontent.com/LinguaLatina/texts/master/texts/latin23/hyginus.cex"


# ╔═╡ 80d9b0ee-4b9b-11eb-1f46-d74e7e633333
md"""---

Selection and formatting
"""

# ╔═╡ 3e4ea634-4b8d-11eb-2c7d-65bd10735550
css = html"""
<style>
.highlight {
  background: yellow;  
}
.urn {
	color: silver;
}
</style>
"""

# ╔═╡ 7785a634-4b97-11eb-0bc8-37261c2e5f06
# Format a single node.
function formatnode(n::CitableNode)
	"""<p><span class='urn'>$(passagecomponent(n.urn))</span>  $(n.text)</p>"""
end

# ╔═╡ 2e654794-4b8a-11eb-1ee5-f5537a85792f
md"---

Code requirements: imports and using statments in the next two cells.
"

# ╔═╡ 4d80c81a-4b8a-11eb-3cf4-c3329e9a1cad
md"---

Manually load and build a corpus for Hyginus.
"

# ╔═╡ 846531b8-4b8a-11eb-160b-bf97ff3a74fd
rawarray = CSV.File(HTTP.get(url).body, skipto=2, delim="#")  |> Array

# ╔═╡ cbc377b8-4b8a-11eb-3b4a-21c50dba8dbb
corpusdata = map(row -> (CitableNode(CtsUrn(row[1]), row[2])),  rawarray)

# ╔═╡ d4554974-4b8a-11eb-02ea-5d49e1c9fb5d
c = CitableCorpus(corpusdata)

# ╔═╡ d4917098-4b8f-11eb-28ea-fd42a0977f05
# Short-term manual work around until proper retrieval methods are
# added to the Julia module.
# Get an array of CitableNodes using URN matching.
function retrieve(urnString::String)
	u = CtsUrn(urnString)
	filtered = filter(n -> urncontains(u,n.urn), c.corpus)
	filtered
	
end

# ╔═╡ 04044e72-4b8b-11eb-2ce3-f7260785dbe0
# Make array of strings for user-selectable menu choices
chapters = unique(map(cn -> collapsePassageBy(cn.urn, 1).urn, c.corpus))

# ╔═╡ e11393a4-4b8b-11eb-36ec-f92776686cba
md"""
Loaded a corpus with **$(size(c.corpus, 1))** citable nodes in **$(size(chapters,1))** chapters.

"""

# ╔═╡ 667448dc-4b8e-11eb-1d03-2d54c3159bcd
md"""## Read a passage

Select a chapter $(@bind chapter Select(chapters))
"""

# ╔═╡ 8e951a72-4b8f-11eb-3434-e3a4fbbc7ed9
# Nodes in currently selected chapter
nodes = retrieve(chapter)

# ╔═╡ 4bd027a4-4b8f-11eb-24a6-e1181025abbc
# Format all selected nodes
function formatnodes()
	items = map(n -> formatnode(n), nodes)
	return HTML("<p><b>Chapter $(passagecomponent(CtsUrn(chapter)))</b>:</p>" *  join(items,"\n\n"))
end

# ╔═╡ 94c21b1a-4b9a-11eb-0536-4746bbfb433e
formatnodes()

# ╔═╡ Cell order:
# ╟─596c1884-4b9c-11eb-3273-35a043fa22b6
# ╟─6807cdbe-4b8a-11eb-2000-87db7a04c957
# ╟─e11393a4-4b8b-11eb-36ec-f92776686cba
# ╟─667448dc-4b8e-11eb-1d03-2d54c3159bcd
# ╠═94c21b1a-4b9a-11eb-0536-4746bbfb433e
# ╟─80d9b0ee-4b9b-11eb-1f46-d74e7e633333
# ╟─3e4ea634-4b8d-11eb-2c7d-65bd10735550
# ╟─8e951a72-4b8f-11eb-3434-e3a4fbbc7ed9
# ╟─d4917098-4b8f-11eb-28ea-fd42a0977f05
# ╟─4bd027a4-4b8f-11eb-24a6-e1181025abbc
# ╟─7785a634-4b97-11eb-0bc8-37261c2e5f06
# ╟─2e654794-4b8a-11eb-1ee5-f5537a85792f
# ╠═3740f7be-4b8a-11eb-354c-d971845a192d
# ╠═3ec55130-4b8a-11eb-3246-f5c38cbbd9ce
# ╟─4d80c81a-4b8a-11eb-3cf4-c3329e9a1cad
# ╟─04044e72-4b8b-11eb-2ce3-f7260785dbe0
# ╟─d4554974-4b8a-11eb-02ea-5d49e1c9fb5d
# ╟─cbc377b8-4b8a-11eb-3b4a-21c50dba8dbb
# ╟─846531b8-4b8a-11eb-160b-bf97ff3a74fd
