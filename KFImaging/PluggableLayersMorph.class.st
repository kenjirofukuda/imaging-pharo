"
A PluggableLayersMorph is xxxxxxxxx.

Instance Variables
	layerMap:		<Dictionary<Symbol,PluggableLayerMorph>>

layerMap
	- xxxxx

"
Class {
	#name : #PluggableLayersMorph,
	#superclass : #MorphicModel,
	#instVars : [
		'layerMap'
	],
	#category : #'KFImaging-Morphic'
}

{ #category : #'as yet unclassified' }
PluggableLayersMorph class >> example [
	"PluggableLayersMorph example"
	| m |
	m := self  new.
	m color: (Color gray alpha: 0.2).
	(m layerForKey: #blue) setDrawOnBlock: [:canvas :morph |
		|box|
		box := morph localInnerBounds insetBy: 10.
		canvas frameRectangle: box width: 20 color: (Color blue alpha: 0.3)].
	(m layerForKey: #red) setDrawOnBlock: [:canvas :morph |
		|box|
		box := morph localInnerBounds insetBy: 15.
		canvas frameRectangle: box width: 20 color: (Color red alpha: 0.5)].	
	(m layerForKey: #yellow) setDrawOnBlock: [:canvas :morph |
		|box|
		box := morph localInnerBounds insetBy: 20.
		canvas frameRectangle: box width: 20 color: (Color yellow alpha: 0.5)].	
	(m layerForKey: #line) setDrawOnBlock: [:canvas :morph |
		|box|
		box := morph localInnerBounds insetBy: 20.
		canvas line: 0@0 to: morph localInnerBounds bottomRight width: 10 color: Color green ].	
	(m layerForKey: #circle) setStepBlock: [:morph |
		| localPoint prevPoint|
		localPoint := morph localSensorPoint .
		prevPoint := morph valueOfProperty: #mouseLoc ifAbsent: 0@0. 
		prevPoint = localPoint ifFalse:[
			| localUpdateBounds |
			morph setProperty: #mouseLoc toValue: localPoint.
			localUpdateBounds := Rectangle encompassing: {  localPoint . prevPoint}.
			localUpdateBounds := localUpdateBounds expandBy: 20@20.
			morph invalidRect: (localUpdateBounds translateBy: morph innerBounds origin).
			]
		].
	(m layerForKey: #circle) setDrawOnBlock: [:canvas :morph |
		| p |
		p := (morph valueOfProperty: #mouseLoc  ifAbsent: 0@0).		
		canvas fillOval:  (Rectangle center: p extent: 20@20 )color: Color cyan].	
	(m layerForKey: #circle) stepTime: 100.
	m openInWorld.
]

{ #category : #accessing }
PluggableLayersMorph >> borderWidth: aPoint [
	super borderWidth: aPoint.
	layerMap do: [:each | each borderWidth: aPoint].
]

{ #category : #defaults }
PluggableLayersMorph >> defaultBounds [
	^0@0 extent: 512@342.
]

{ #category : #defaults }
PluggableLayersMorph >> defaultLayerClass [
	^PluggableLayerMorph
]

{ #category : #geometry }
PluggableLayersMorph >> extent: aPoint [
	super extent: aPoint.
	layerMap do: [ :each | each extent: aPoint ]
]

{ #category : #initialization }
PluggableLayersMorph >> initialize [
	super initialize.
	layerMap := Dictionary new.
	self color: Color white.
	
]

{ #category : #'element control' }
PluggableLayersMorph >> layerForKey: aSymbol [ 
	^ layerMap 
		at: aSymbol
		ifAbsentPut: 
			[ | m |
			m := self newLayerForKey: aSymbol.
			self addMorph: m.
			m ]
]

{ #category : #'element control' }
PluggableLayersMorph >> newLayerForKey: aSymbol [ 
	| m |
	m := self defaultLayerClass  new.
	m extent: self extent.
	m symbol: aSymbol.
	^ m
]

{ #category : #geometry }
PluggableLayersMorph >> position: aPoint [
	super position: aPoint.
	layerMap do: [ :each | each position: aPoint ]
]

{ #category : #initialization }
PluggableLayersMorph >> release [
	layerMap ifNotNil: [ layerMap do: [ :each | each release ] ].
	layerMap := nil.
	super release
]

{ #category : #'element control' }
PluggableLayersMorph >> setVisible: aBoolean forKey: aSymbol [ 
	^(self layerForKey: aSymbol) visible: aBoolean
	
]
