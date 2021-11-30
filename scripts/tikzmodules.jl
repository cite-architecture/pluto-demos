using LightGraphs
using TikzGraphs
using TikzPictures
pkglist = [
    # 1-2: abstractions
    "CitableBase", 
    "CitableLibrary",

    # 3-9: CITE
    "CiteEXchange",
	"CitableObject", 
    "CitableImage",

	"CitableText",
	"CitableCorpus",
	"CitablePhysicalText",

    "CitableCollection",
	
    # 10-12: MID abstractions
    "Orthography",
	"CitableTeiReaders",
    "EditionBuilders",
	


    # 13-15: Orthographies
	"PolytonicGreek",
	"AtticGreek",
	"ManuscriptOrthography",
	
    # 16-20: Text analysis
    "CitableParserBuilder",
    "Kanones",
    "CitableCorpusAnalysis",
    "Lycian",
    "Tabulae",

    # 21-22: Project repositories
    "EditorsRepo",
    "HmtArchive"

   
]

colormods = Dict(
    # Abstractions:
    1=>"fill=yellow",
    2=>"fill=yellow",

    # MID modules:
    10=>"fill=green!10",
    11=>"fill=green!10",
    12=>"fill=green!10",

    # Orthographies
    
    13=>"fill=orange!15",
    14=>"fill=orange!15",
    15=>"fill=orange!15",

    # Text analysis modules:
    
    16 =>"fill=cyan!10",
    17 =>"fill=cyan!10",
    18 =>"fill=cyan!10",   
    19 =>"fill=cyan!10",    
    20 =>"fill=cyan!10",

    # Project repo management:
    21 =>"fill=olive!15",
    22 =>"fill=olive!15",
)


edgelist = [
    ("CitableLibrary", "CitableBase"),
    ("CitableLibrary", "CitableObject"),

	("CitableObject", "CitableBase"),
	("CitableText", "CitableBase"),

    ("CiteEXchange", "CitableObject"),

	("CitableCorpus", "CitableText"),
    ("CitableCorpus", "CiteEXchange"),

	("CitablePhysicalText", "CitableText"),
	("CitablePhysicalText", "CitableObject"),
	("CitablePhysicalText", "CitableImage"),
    ("CitablePhysicalText", "CiteEXchange"),

	("CitableImage","CitableObject"),

    ("CitableCollection", "CitableBase"),
    ("CitableCollection", "CitableObject"),
    ("CitableCollection", "CiteEXchange"),


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


    ("Tabulae", "CitableParserBuilder"),
    ("Tabulae", "CitableObject"),

    ("CitableCorpusAnalysis", "CitableText"),
    ("CitableCorpusAnalysis", "CitableCorpus"),
    ("CitableCorpusAnalysis", "CitableParserBuilder"),
    ("CitableCorpusAnalysis", "Orthography"),


    ("Lycian", "Orthography"),
    ("Lycian", "CitableText"),
    ("Lycian", "CitableCorpus"),
    ("Lycian", "CitableObject"),
    ("Lycian", "CitableParserBuilder"),


    ("HmtArchive", "EditorsRepo"),

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
    1 => "fill=yellow",
    2 => "fill=blue!20",
    3 => "fill=green!10",
    4 => "fill=orange!15",
    5 => "fill=cyan!10",
    6 => "fill=olive!15"
)
grouplabels = [
    "CITE concepts",
    "CITE implementations",
    "Abstractions from HC MID",
    "Orthographies",
    "Text analysis",
    "Project repository management"
]

tikzplot = TikzGraphs.plot(colorkeygr,grouplabels, node_style="draw, rounded corners, fill=blue!20", node_styles=colorkeydict)
tikzkey = TikzGraphs.plot(colorkeygr,grouplabels, node_style="draw, rounded corners, fill=blue!20", node_styles=colorkeydict) 

TikzPictures.save(PDF("testout/colorkey"),tikzkey)
TikzPictures.save(SVG("testout/colorkey"),tikzkey)


