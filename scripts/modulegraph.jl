using LightGraphs
using GraphPlot
using Colors


pkglist = ["CitableBase", 
	"CitableObject", 
	"CitableText",
	"CitablePhysicalText",
	"CitableImage",
	"CitableTeiReaders",
	"EditorsRepo",
	"Orthography",
	"EditionBuilders"
]


edgelist = [
	("CitableObject", "CitableBase"),
	("CitableText", "CitableBase"),
	("CitablePhysicalText", "CitableText"),
	("CitablePhysicalText", "CitableObject"),
	("CitablePhysicalText", "CitableImage"),
	("CitableImage","CitableObject"),
	("CitableTeiReaders", "CitableText"),
	
	("EditorsRepo", "CitableText"),
	("EditorsRepo", "CitablePhysicalText"),
	("EditorsRepo", "CitableObject"),
	("EditorsRepo", "CitableTeiReaders"),
	("EditorsRepo", "CitableImage"),
	("EditorsRepo", "Orthography"),
	("EditorsRepo", "EditionBuilders"),
	("EditionBuilders", "CitableText")
]


gr = SimpleDiGraph(length(pkglist) )

for (src, target) in edgelist
	srcidx = findfirst(r -> r == src, pkglist)
	targetidx = findfirst(r -> r == target, pkglist)
	add_edge!(gr, srcidx, targetidx)
end
midindex = 1
citeindex = 2
rootindex = 3


colorlist = [
	rootindex,
	citeindex,
	citeindex,
	citeindex,
	citeindex,
	midindex,
	midindex,
	midindex,
	midindex
	]
nodecolors = [colorant"orange", colorant"lightgrey", colorant"blue"]

nodefillc = nodecolors[colorlist]

gplot(gr, nodelabel=pkglist, nodefillc=nodefillc)


using Cairo, Compose
draw(PDF("modules.pdf", 16cm, 16cm), gplot(gr,  nodelabel=pkglist, nodefillc=nodefillc))