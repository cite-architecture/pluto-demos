using LightGraphs
using TikzGraphs
using TikzPictures
pkglist = [
    # 1-7: CITE
    "CitableBase", 
    "CiteEXchange",
	"CitableObject", 
    "CitableImage",

	"CitableText",
	"CitableCorpus",
	"CitablePhysicalText",
	
    
    # 8-11: MID
    "Orthography",
	"CitableTeiReaders",
    "EditionBuilders",
	"EditorsRepo",


    # 12-14: Orthographies
	"PolytonicGreek",
	"AtticGreek",
	"ManuscriptOrthography",
	
    # 15-18: Text analysis
    "CitableParserBuilder",
    "Kanones",
    "CitableCorpusAnalysis",
    "Lycian",
]

colormods = Dict(
    # MID modules:
    8=>"fill=green!10",
    9=>"fill=green!10",
    10=>"fill=green!10",
    11=>"fill=green!10",
    # Orthographies
    12=>"fill=orange!15",
    13=>"fill=orange!15",
    14=>"fill=orange!15",
    # Text analysis modules:
    15 =>"fill=cyan!10",
    16 =>"fill=cyan!10",
    17 =>"fill=cyan!10",
    18 =>"fill=cyan!10",
    # HMT
    # XX =>"fill=olive!15",
)


edgelist = [
	("CitableObject", "CitableBase"),
	("CitableText", "CitableBase"),

	("CitableCorpus", "CitableText"),
    ("CitableCorpus", "CiteEXchange"),

	("CitablePhysicalText", "CitableText"),
	("CitablePhysicalText", "CitableObject"),
	("CitablePhysicalText", "CitableImage"),
    ("CitablePhysicalText", "CiteEXchange"),

	("CitableImage","CitableObject"),

	("CitableTeiReaders", "CitableText"),
	("CitableTeiReaders", "CitableCorpus"),


    ("Orthography", "CitableCorpus"),
    ("Orthography", "CitableText"),

	("EditorsRepo", "CiteEXchange"),
    ("EditorsRepo", "CitableBase"),
	("EditorsRepo", "CitableText"),
	("EditorsRepo", "CitablePhysicalText"),
	("EditorsRepo", "CitableCorpus"),
	("EditorsRepo", "CitableObject"),
	("EditorsRepo", "CitableTeiReaders"),
	("EditorsRepo", "CitableImage"),
	("EditorsRepo", "EditionBuilders"),
    ("EditorsRepo", "Orthography"),
    ("EditorsRepo", "AtticGreek"),
    ("EditorsRepo", "ManuscriptOrthography"),
    ("EditorsRepo", "PolytonicGreek"),

	("EditionBuilders", "CitableText"),
	("EditionBuilders", "CitableCorpus"),
	
	("PolytonicGreek", "Orthography"),
	("AtticGreek", "Orthography"),
    ("ManuscriptOrthography", "Orthography"),
    ("ManuscriptOrthography", "PolytonicGreek"),
    
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


    ("Lycian", "Orthography"),
    ("Lycian", "CitableText"),
    ("Lycian", "CitableCorpus"),
    ("Lycian", "CitableObject"),
    ("Lycian", "CitableParserBuilder"),

   

]

gr = SimpleDiGraph(length(pkglist) )
for (src, target) in edgelist
    @info("Looking at ", src, target)
	srcidx = findfirst(r -> r == src, pkglist)
    @info srcidx
	targetidx = findfirst(r -> r == target, pkglist)
	add_edge!(gr, srcidx, targetidx)
end





modulesgraph = TikzGraphs.plot(gr, pkglist, node_style="draw, rounded corners, fill=blue!20", node_styles=colormods)
TikzPictures.save(PDF("testout/modules-tikz"),modulesgraph)



colorkeygr = SimpleGraph(0)
add_vertices!(colorkeygr, 5)
colorkeydict = Dict(
    1 => "fill=blue!20",
    2 => "fill=green!10",
    3 => "fill=orange!15",
    4 => "fill=cyan!10",
    5 => "fill=olive!15"
)
grouplabels = [
    "CITE architecture",
    "MID abstractions",
    "Orthographies",
    "Text analysis",
    "Homer Multitext"
]

tikzplot = TikzGraphs.plot(colorkeygr,grouplabels, node_style="draw, rounded corners, fill=blue!20", node_styles=colorkeydict)
tikzkey = TikzGraphs.plot(colorkeygr,grouplabels, node_style="draw, rounded corners, fill=blue!20", node_styles=colorkeydict) 

TikzPictures.save(PDF("testout/colorkey"),tikzkey)
TikzPictures.save(SVG("testout/colorkey"),tikzkey)


