Class {
	#name : #KFBitEditMorph,
	#superclass : #MorphicModel,
	#instVars : [
		'gridStep',
		'pointToStateMap',
		'form',
		'colors'
	],
	#category : #'KFImaging-BitEdit'
}

{ #category : #drawing }
KFBitEditMorph >> drawGridOn: aCanvas [

	| xMax yMax xSteps ySteps |
	xMax := self innerBounds extent x.
	yMax := self innerBounds extent y.

	xSteps := 0 to: xMax by: gridStep.
	xSteps do: [ :x | 
		aCanvas
			line: x @ 0
			to: x @ yMax
			width: 1
			color: Color gray ].

	ySteps := 0 to: yMax by: gridStep.
	ySteps do: [ :y | 
		aCanvas
			line: 0 @ y
			to: xMax @ y
			width: 1
			color: Color gray ]
]

{ #category : #drawing }
KFBitEditMorph >> drawLocalOn: aCanvas [

	self drawTilesOn: aCanvas.
	self drawGridOn: aCanvas
]

{ #category : #drawing }
KFBitEditMorph >> drawOn: aCanvas [

	super drawOn: aCanvas.
	aCanvas
		translateBy: self innerBounds origin
		clippingTo: self innerBounds
		during: [ :offsetCanvas | 
			 self drawLocalOn: offsetCanvas ] 
]

{ #category : #drawing }
KFBitEditMorph >> drawTilesOn: aCanvas [

	| xMax yMax xSteps ySteps |
	xMax := self innerBounds extent x.
	yMax := self innerBounds extent y.

	xSteps := 0 to: xMax by: gridStep.
	ySteps := 0 to: yMax by: gridStep.
	ySteps do: [ :y | 
		xSteps do: [ :x | 
			| r c formPoint val |
			formPoint := x @ y // gridStep.
			val := pointToStateMap at: formPoint ifAbsentPut: [ 0 ].
			r := Rectangle origin: x @ y extent: gridStep asPoint.
			c := colors at: val + 1.
			aCanvas fillRectangle: r color: c ] ]
]

{ #category : #accessing }
KFBitEditMorph >> form: aForm [

	| cols rows |
	form := aForm.
	colors := form colorsUsed.
	cols := form width.
	rows := form height.
	0 to: rows - 1 do: [ :y | 
		0 to: cols - 1 do: [ :x | 
			| pos |
			pos := x @ y.
			pointToStateMap at: pos put: (aForm pixelValueAt: pos) ] ].
	self extent: form width * gridStep @ (form height * gridStep).
	self changed
]

{ #category : #accessing }
KFBitEditMorph >> gridStep: anInteger [

	gridStep := (anInteger max: 3) min: 20.
	self changed
]

{ #category : #'event handling' }
KFBitEditMorph >> handlesMouseDown: aMouseEvent [
	^ true
]

{ #category : #'event handling' }
KFBitEditMorph >> handlesMouseWheel: event [

	^ true
]

{ #category : #initialization }
KFBitEditMorph >> initialize [
	super initialize.
	gridStep := 20.
	pointToStateMap := Dictionary new.
	
]

{ #category : #'event handling' }
KFBitEditMorph >> mouseDown: aMouseEvent [

	| localPoint formPoint val |
	aMouseEvent redButtonChanged ifFalse: [ ^ self ].
	localPoint := aMouseEvent cursorPoint - self innerBounds origin.
	Transcript
		cr;
		show: localPoint printString.
	formPoint := localPoint // gridStep.
	Transcript
		cr;
		show: formPoint printString.
	val := pointToStateMap at: formPoint ifAbsentPut: [ 0 ].
	val = 0 ifTrue: [ pointToStateMap at: formPoint put: 1 ].
	val = 1 ifTrue: [ pointToStateMap at: formPoint put: 2 ].
	val = 2 ifTrue: [ pointToStateMap at: formPoint put: 0 ].
	self invalidRect:
		((formPoint * gridStep extent: gridStep asPoint) translateBy:
			 self innerBounds origin)
]

{ #category : #'event handling' }
KFBitEditMorph >> mouseWheel: event [

	| dir |
	dir := 1.
	(KFEventSupport isWheelUpEvent: event) ifTrue: [ dir := 1.0 ].
	(KFEventSupport isWheelDownEvent: event) ifTrue: [ dir := -1.0 ].
	self gridStep: gridStep + dir
]
