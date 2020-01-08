Class {
	#name : #FTBoxTextMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'ttContext'
	],
	#category : #'KFImaging-Morphic'
}

{ #category : #example }
FTBoxTextMorph class >> example [
	"self example."
	self new 
		extent: (Display width * 0.5) @ (Display height * 0.3);
		color: Color transparent ;
	 	openCenteredInWorld.
]

{ #category : #drawing }
FTBoxTextMorph >> drawOn: aCanvas [
	super drawOn: aCanvas.
	ttContext drawOn: aCanvas string: ttContext string bounds: self innerBounds.
	
]

{ #category : #geometry }
FTBoxTextMorph >> extent: aBounds [
	super extent: aBounds.
	ttContext bounds: self bounds.
	
]

{ #category : #initialization }
FTBoxTextMorph >> initialize [
	super initialize.
	ttContext := FTBoxTextContext new.
	
	
]
