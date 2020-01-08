Class {
	#name : #FTBoxTextPrimitive,
	#superclass : #Object,
	#category : #'KFImaging-Core'
}

{ #category : #'as yet unclassified' }
FTBoxTextPrimitive class >> calcBoundsString: aString fontDescription: aFreeTypeFont [
	"import from TTFontDescription's  initializeString"
	"
	self calcBoundsString: 'UNTITLED' fontDescription: TTFontDescription default.
	"
	| xStart char glyph ttBounds |
	self assert: aFreeTypeFont notNil.
	xStart := 0.
	ttBounds := 0@0 corner: 0@0.
	1 to: aString size do:
		[:i | | bounds |
		char := aString at: i.
		glyph := aFreeTypeFont face glyphOfCharacter: char.
		bounds := GeometryUtils lookupDataBounds: glyph outline pointCollection.	
		ttBounds := ttBounds quickMerge: (bounds translateBy: xStart@0).
		xStart := xStart + glyph advanceX].
	^ttBounds
]

{ #category : #'as yet unclassified' }
FTBoxTextPrimitive class >> computeTransform: aMorphicBounds ttBounds: aDescriptionBounds ttBorderWidth: aTTwidth [ 
	"WARNING: aTTborderWidth is not a final pixel width"
	"import from TTSampleStringMorph's  computeTransform"
	| cy transform |
	aDescriptionBounds extent isZero
		ifTrue: [ ^ MatrixTransform2x3 identity ].
	cy := (aMorphicBounds origin y + aMorphicBounds corner y) * 0.5.
	transform := MatrixTransform2x3 
		transformFromLocal: (aDescriptionBounds insetBy: aTTwidth negated)
		toGlobal: aMorphicBounds.
	transform := transform composedWithGlobal: (MatrixTransform2x3 withOffset: 0 @ cy negated).
	transform := transform composedWithGlobal: (MatrixTransform2x3 withScale: 1.0 @ -1.0).
	transform := transform composedWithGlobal: (MatrixTransform2x3 withOffset: 0 @ cy).
	^ transform
]

{ #category : #queries }
FTBoxTextPrimitive class >> defaultFont [
	^ TextStyle defaultFont realFont
]

{ #category : #'as yet unclassified' }
FTBoxTextPrimitive class >> drawOn: aCanvas string: aString fontDescription: aFreeTypeFont fillColor: aFillColor borderColor: aBorderCollor ttBorderWidth: aTTborderWidth transform: aTransform aaLevel: anAALebel [ 
	"WARNING: aTTborderWidth is not a final pixel width"
	"import from TTSimpleStringMorph's  drawOn:"
	| xStart glyph |
	xStart := 0.
	aCanvas asBalloonCanvas preserveStateDuring: 
		[ :balloonCanvas | 
		balloonCanvas transformBy: aTransform.
		balloonCanvas aaLevel: anAALebel.
		aString do: 
			[ :char | | contors |
			glyph := aFreeTypeFont face glyphOfCharacter: char.
			contors := 	glyph outline contoursCollection collect: [ :assoc | 
					assoc value, { assoc value first } ].						
			balloonCanvas preserveStateDuring: 
				[ :subCanvas | 
				subCanvas transformBy: (MatrixTransform2x3 withOffset: xStart @ 0).
				subCanvas 
					drawGeneralPolygon: contors
					color: aFillColor
					borderWidth: aTTborderWidth
					borderColor: aBorderCollor ].
			xStart := xStart + glyph advanceX ] ]
]

{ #category : #examples }
FTBoxTextPrimitive class >> example1 [
	"Display restoreAfter: [self example1]"
	| string ttBounds morphicBounds transform borderWidth borderColor fillColor canvas fontDescription aaLevel |
	string := '監獄学園'.
	morphicBounds := Rectangle fromUser.
	borderWidth := 10.
	borderColor := Color red.
	fillColor := Color blue.
	canvas := Display getCanvas.
	fontDescription := self defaultFont.
	aaLevel := 4.
	ttBounds := FTBoxTextPrimitive 
		calcBoundsString: string
		fontDescription: fontDescription.
	transform := FTBoxTextPrimitive 
		computeTransform: morphicBounds
		ttBounds: ttBounds
		ttBorderWidth: borderWidth.
	FTBoxTextPrimitive 
		drawOn: canvas
		string: string
		fontDescription: fontDescription
		fillColor: fillColor
		borderColor: borderColor
		ttBorderWidth: borderWidth
		transform: transform
		aaLevel: aaLevel
]

{ #category : #examples }
FTBoxTextPrimitive class >> example2 [
	<script>
	(self defaultFont face glyphOfCharacter:  $a)  explore.
]
