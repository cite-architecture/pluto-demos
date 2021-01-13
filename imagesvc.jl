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

# ╔═╡ c53478d6-55b0-11eb-10a6-e95f652db5dd
# Dynamically create notebook's julia environment:
begin
	using Pkg
	Pkg.add("CitableImage")
	Pkg.add("CitableObject")
	Pkg.add("PlutoUI")
	
	using CitableObject
	using CitableImage
	using PlutoUI
end

# ╔═╡ 89a48b5c-55b1-11eb-2480-01b9182018a9
md"## Example of using `CitableImage` module in Julia"

# ╔═╡ 97353ba2-55b1-11eb-38c2-2d8842ff15e1
img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.2096,0.2112,0.1617,0.01892")

# ╔═╡ ff98fb40-55b1-11eb-276a-af9cee4f0520
md"Width of image: $(@bind w Slider(100:800, show_value=true))"

# ╔═╡ d3cd4fca-55b1-11eb-34dd-cb71e018d127
md"Caption: $(@bind caption TextField(default=\"Iliad 1\"))"

# ╔═╡ 164912a4-55b1-11eb-1477-ff6c05969735
md"""
---

Define two image services:
"""

# ╔═╡ 3212d812-55b1-11eb-05c5-1bbaac417341
iiifsvc = begin
	baseurl = "http://www.homermultitext.org/iipsrv"
	root = "/project/homer/pyramidal/deepzoom"
	IIIFservice(baseurl, root)
end


# ╔═╡ 75473060-55b1-11eb-3d41-3fc0f7ce893f
ict = "http://www.homermultitext.org/ict2/?"

# ╔═╡ dd05a92e-55b2-11eb-347b-4f21cc095782
begin 
	url  = "$(linkedMarkdownImage(ict, img, iiifsvc, w, caption))"
	Markdown.parse(url)
	
end


# ╔═╡ Cell order:
# ╟─c53478d6-55b0-11eb-10a6-e95f652db5dd
# ╟─89a48b5c-55b1-11eb-2480-01b9182018a9
# ╟─97353ba2-55b1-11eb-38c2-2d8842ff15e1
# ╟─ff98fb40-55b1-11eb-276a-af9cee4f0520
# ╟─d3cd4fca-55b1-11eb-34dd-cb71e018d127
# ╠═dd05a92e-55b2-11eb-347b-4f21cc095782
# ╟─164912a4-55b1-11eb-1477-ff6c05969735
# ╟─3212d812-55b1-11eb-05c5-1bbaac417341
# ╟─75473060-55b1-11eb-3d41-3fc0f7ce893f
