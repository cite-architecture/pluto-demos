using LightGraphs
using GraphPlot
using Colors
using Cairo, Compose

midindex = 1
citeindex = 2
rootindex = 3
orthoindex = 4
nodecolors = [colorant"green",  colorant"orange",colorant"blue",colorant"lightgrey"]

# Package list and color list need to be synced.
# Read this from a table?
pkglist = ["CitableBase", 
	"CitableObject", 
	"CitableText",
	"CitableCorpus",
	"CitablePhysicalText",
	"CitableImage",
	"CitableTeiReaders",
	"EditorsRepo",
	"Orthography",
	"EditionBuilders",
	"PolytonicGreek",
	"AtticGreek",
	"ManuscriptGreek",
	"Lycian"
]
colorlist = [
	rootindex,
	citeindex,
	citeindex,
	citeindex,
	citeindex,
	citeindex,
	midindex,
	midindex,
	midindex,
	midindex,
	orthoindex,
	orthoindex,
	orthoindex,
	orthoindex
]
nodefillc = nodecolors[colorlist]


edgelist = [
	("CitableObject", "CitableBase"),
	("CitableText", "CitableBase"),
	("CitableCorpus", "CitableText"),
	("CitablePhysicalText", "CitableText"),
	("CitablePhysicalText", "CitableObject"),
	("CitablePhysicalText", "CitableImage"),
	("CitableImage","CitableObject"),
	("CitableTeiReaders", "CitableText"),
	("CitableTeiReaders", "CitableCorpus"),
	
	("EditorsRepo", "CitableText"),
	("EditorsRepo", "CitablePhysicalText"),
	("EditorsRepo", "CitableCorpus"),
	("EditorsRepo", "CitableObject"),
	("EditorsRepo", "CitableTeiReaders"),
	("EditorsRepo", "CitableImage"),
	("EditorsRepo", "Orthography"),
	("EditorsRepo", "EditionBuilders"),
	("EditionBuilders", "CitableText"),
	("EditionBuilders", "CitableCorpus"),
	
	
	("PolytonicGreek", "Orthography"),
	("AtticGreek", "Orthography"),
	("ManuscriptGreek", "Orthography"),
	("ManuscriptGreek", "PolytonicGreek"),
	("Lycian", "Orthography")
]

gr = SimpleDiGraph(length(pkglist) )
for (src, target) in edgelist
	srcidx = findfirst(r -> r == src, pkglist)
	targetidx = findfirst(r -> r == target, pkglist)
	add_edge!(gr, srcidx, targetidx)
end










gplot(gr, nodelabel=pkglist, nodefillc=nodefillc, arrowlengthfrac=0.07)



draw(PDF("modules.pdf", 16cm, 16cm), gplot(gr,  nodelabel=pkglist, nodefillc=nodefillc, arrowlengthfrac=0.05))