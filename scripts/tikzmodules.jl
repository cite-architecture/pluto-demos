using LightGraphs
using TikzGraphs
using TikzPictures
pkglist = [
    # CITE
    "CitableBase", 
	"CitableObject", 
	"CitableText",
	"CitableCorpus",
	"CitablePhysicalText",
	"CitableImage",
    # MID
	"CitableTeiReaders",
	"EditorsRepo",
	"Orthography",
	"EditionBuilders",
    # Orthographies
	"PolytonicGreek",
	"AtticGreek",
	"ManuscriptGreek",
	"Lycian",
    # Text analysis
    "CitableParserBuilder",
    "Kanones",
    "CitableCorpusAnalysis"
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
	("Lycian", "Orthography"),

    ("CitableParserBuilder", "CitableBase"),
    ("CitableParserBuilder", "CitableText"),
    ("CitableParserBuilder", "CitableCorpus"),
    ("CitableParserBuilder", "CitableObject"),
    ("CitableParserBuilder", "Orthography"),

    ("Kanones", "AtticGreek"),
    ("Kanones", "CitableBase"),
    ("Kanones", "CitableObject"),
    ("Kanones", "CitableParserBuilder"),
    ("Kanones", "Orthography"),
    ("Kanones", "PolytonicGreek"),


    ("CitableCorpusAnalysis", "CitableText"),
    ("CitableCorpusAnalysis", "CitableCorpus"),
    ("CitableCorpusAnalysis", "CitableParserBuilder"),
    ("CitableCorpusAnalysis", "Orthography"),


]

gr = SimpleDiGraph(length(pkglist) )
for (src, target) in edgelist
	srcidx = findfirst(r -> r == src, pkglist)
	targetidx = findfirst(r -> r == target, pkglist)
	add_edge!(gr, srcidx, targetidx)
end



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
    15 =>"fill=cyan!10",
    16 =>"fill=cyan!10",
    17 =>"fill=cyan!10"

)

modulesgraph = TikzGraphs.plot(gr, pkglist, node_style="draw, rounded corners, fill=blue!20", node_styles=colormods)


colorkeygr = SimpleGraph(0)
add_vertices!(colorkeygr, 4)
colorkeydict = Dict(
    1 => "fill=blue!20",
    2 => "fill=green!10",
    3 => "fill=orange!10",
    4 => "fill=cyan!10"
)
grouplabels = [
    "CITE architecture",
    "MID abstractions",
    "Orthographies",
    "Text analysis"
]

tikzplot = TikzGraphs.plot(colorkeygr,grouplabels, node_style="draw, rounded corners, fill=blue!20", node_styles=colorkeydict)


tikzkey = TikzGraphs.plot(colorkeygr,grouplabels, node_style="draw, rounded corners, fill=blue!20", node_styles=colorkeydict) 

TikzPictures.save(PDF("test"),tikzkey)
TikzPictures.save(SVG("test"),tikzkey)


TikzPictures.save(PDF("modules-tikz"),modulesgraph)