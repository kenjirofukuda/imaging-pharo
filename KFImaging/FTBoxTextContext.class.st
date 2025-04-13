Class {
	#name : #FTBoxTextContext,
	#superclass : #Object,
	#instVars : [
		'string',
		'morphicBounds',
		'borderWidth',
		'borderColor',
		'fillColor',
		'fontDescription',
		'ttBounds',
		'transform',
		'isPixelWidth',
		'aaLevel'
	],
	#category : 'KFImaging-Core'
}

{ #category : #example }
FTBoxTextContext class >> example [
	"self example"
	|context |
	context := FTBoxTextContext new.
	context fillColor: Color red.

	context drawOn: Display getCanvas string: Time now bounds: Rectangle fromUser.
]

{ #category : #'as yet unclassified' }
FTBoxTextContext class >> exampleKanji [
	"self exampleKanji"
	|context |
	context := FTBoxTextContext new.
	context fillColor: Color blue.
	context drawOn: Display getCanvas string: 'かけます' bounds: Rectangle fromUser.
]

{ #category : #accessing }
FTBoxTextContext >> aaLevel [
	^ aaLevel
	

]

{ #category : #accessing }
FTBoxTextContext >> aaLevel: aLevel [
	aaLevel := aLevel.
	

]

{ #category : #accessing }
FTBoxTextContext >> apiWidth [
	transform ifNil: [^borderWidth].
	 transform a11 isZero ifTrue: [^borderWidth].
	isPixelWidth ifTrue: [^(borderWidth / transform a11) rounded].
	^borderWidth	
]

{ #category : #accessing }
FTBoxTextContext >> borderColor [
	^borderColor
	
]

{ #category : #accessing }
FTBoxTextContext >> borderColor:  aColor [
	borderColor := aColor.
	
]

{ #category : #accessing }
FTBoxTextContext >> borderWidth [
	^borderWidth
	

]

{ #category : #accessing }
FTBoxTextContext >> borderWidth:  anInteger [
	borderWidth := anInteger.
	self calcContext.
	
]

{ #category : #accessing }
FTBoxTextContext >> borderWidthAsKeepTrueTypeValue [
	isPixelWidth := false.
	self calcContext.	
]

{ #category : #accessing }
FTBoxTextContext >> borderWidthAsPixelValue [
	isPixelWidth := true.
	self calcContext.
]

{ #category : #accessing }
FTBoxTextContext >> bounds [
	^morphicBounds
	
]

{ #category : #geometry }
FTBoxTextContext >> bounds:  aRefctangle [
	morphicBounds := aRefctangle.
	self calcContext.
	
]

{ #category : #private }
FTBoxTextContext >> calcContext [
	ttBounds := FTBoxTextPrimitive 
		calcBoundsString: self string
		fontDescription: self fontDescription.
	transform := FTBoxTextPrimitive 
		computeTransform: self bounds
		ttBounds: ttBounds
		ttBorderWidth: self borderWidth
]

{ #category : #drawing }
FTBoxTextContext >> drawOn: aCanvas string: aString bounds: aBounds [ 
	self fontDescription ifNil:[^self].
	string := aString asString.
	morphicBounds := aBounds.
	self calcContext.
	FTBoxTextPrimitive 
		drawOn: aCanvas
		string: string
		fontDescription: self fontDescription
		fillColor: self fillColor
		borderColor: self borderColor
		ttBorderWidth: self apiWidth
		transform: transform
		aaLevel: self aaLevel
]

{ #category : #accessing }
FTBoxTextContext >> fillColor [
	^fillColor
	
]

{ #category : #accessing }
FTBoxTextContext >> fillColor:  aColor [
	fillColor := aColor.
	
]

{ #category : #accessing }
FTBoxTextContext >> fontDescription [
	^fontDescription
]

{ #category : #initialization }
FTBoxTextContext >> initialize [
	super initialize.
	string := SystemVersion current version.
	morphicBounds := 0@0extent:Display extent.
	isPixelWidth := true.
	borderWidth := 0.
	borderColor := Color black.
	fillColor := Color black.
	fontDescription := TextStyle defaultFont realFont.
	aaLevel := 4.
	
]

{ #category : #accessing }
FTBoxTextContext >> string [
	^string
]

{ #category : #accessing }
FTBoxTextContext >> string: aString [
	string := aString.
	self calcContext.
	
]

{ #category : #drawing }
FTBoxTextContext >> strokeClasicalOn: aCanvas string: aString bounds: aBounds [
	string :=  aString asString.
	morphicBounds := aBounds.
	self calcContext.
	"FTBoxTextPrimitive strokeClasicalOn: aCanvas string: string fontDescription: self fontDescription fillColor:  self fillColor borderColor: self borderColor borderWidth: self borderWidth transform: transform."

]

{ #category : #drawing }
FTBoxTextContext >> strokeOn: aCanvas string: aString bounds: aBounds [
	string :=  aString asString.
	morphicBounds := aBounds.
	self calcContext.
	"FTBoxTextPrimitive strokeOn: aCanvas string: string fontDescription: self fontDescription fillColor:  self fillColor borderColor: self borderColor borderWidth: self apiWidth transform: transform  aaLevel: self aaLevel."

]
