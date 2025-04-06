Class {
	#name : 'ImageTable',
	#superclass : 'Object',
	#category : 'KFImaging-Morphic',
	#package : 'KFImaging',
	#tag : 'Morphic'
}

{ #category : 'as yet unclassified' }
ImageTable class >> beTableLayout: aMorph [
	aMorph clipSubmorphs: true.
	aMorph vResizing: #shrinkWarp.
	aMorph hResizing: #shrinkWarp.
	aMorph layoutPolicy: TableLayout new.
	aMorph wrapDirection: #leftToRight.
	aMorph cellInset: 10@10.

]

{ #category : 'debugging' }
ImageTable class >> collectTopmostImagesExternalNamed: aExternalName [
	^ImageMorph allInstances
		select: [:m | (m owner class = PasteUpMorph)
				and: [m externalName = aExternalName]]
]

{ #category : 'instance creation' }
ImageTable class >> createIconPanelMorph [
	"self  createIconPanelMorph openInWorld"
	| l |
	l := AlignmentMorph new.
	self beTableLayout: l.
	l borderStyle: (BorderStyle complexAltFramed width: 5).
	l color: (Color r: 0.972 g: 0.972 b: 0.788 alpha: 0.412).
	^l.
]

{ #category : 'as yet unclassified' }
ImageTable class >> openDisplayCenter: aMorph [
	aMorph extent: (Display extent * 0.7) rounded.
	aMorph center: Display center.
	aMorph openInWorld.
]
