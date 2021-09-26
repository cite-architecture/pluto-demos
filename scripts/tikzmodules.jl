using TikzGraphs

pkglist = [
    "CitableBase", 
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

#  node_style="draw, rounded corners, fill=blue!10", node_styles=Dict(1=>"fill=green!10",3=>"fill=yellow!10")


colormods = Dict(
    # MID modules:
    7=>"fill=green!10",
    8=>"fill=green!10",
    9=>"fill=green!10",
    10=>"fill=green!10",
    # Orthographies
    11=>"fill=orange!10",
    12=>"fill=orange!10",
    13=>"fill=orange!10",
    14=>"fill=orange!10",
    # Text analysis modules:
     
)
TikzGraphs.plot(gr, pkglist, node_style="draw, rounded corners, fill=blue!10", node_styles=colormods)