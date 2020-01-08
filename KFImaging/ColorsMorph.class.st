Class {
	#name : #ColorsMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'colors'
	],
	#category : #'KFImaging-Morphic'
}

{ #category : #example }
ColorsMorph class >> example [
	"ColorsMorph example"

	(self new initialize colors: Color indexedColors) openInWorld
]

{ #category : #accessing }
ColorsMorph >> colors [
	^colors.
]

{ #category : #accessing }
ColorsMorph >> colors: aColors [
	colors := aColors

]

{ #category : #accessing }
ColorsMorph >> defaultBounds [
	^10@10 extent: 500@60.
]

{ #category : #drawing }
ColorsMorph >> drawOn: aCanvas [
	| itemWidth r |
	self colors ifNil: [super drawOn: aCanvas].

	itemWidth := (self width / colors size) asInteger.
	colors doWithIndex: [ :c :index |
		r := Rectangle origin: (0 @ 0) extent: (itemWidth @ self height).
		r := r translateBy: (((index - 1)*itemWidth) @ 0).
		r := r translateBy: self bounds origin.
		aCanvas fillRectangle: r color: c].
		
]
