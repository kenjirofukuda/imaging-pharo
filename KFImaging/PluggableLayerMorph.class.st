"
A PluggableLayerMorph is xxxxxxxxx.

Instance Variables
	drawOnBlock:		<BlockContext>
	stepBlock:		<BlockContext>
	stepTime:		<Integer>
	symbol:		<Symbol>
	updateBlock:		<BlockContext>

drawOnBlock
	- xxxxx

stepBlock
	- xxxxx

stepTime
	- xxxxx

symbol
	- xxxxx

updateBlock
	- xxxxx

"
Class {
	#name : 'PluggableLayerMorph',
	#superclass : 'MorphicModel',
	#instVars : [
		'symbol',
		'drawOnBlock',
		'stepBlock',
		'stepTime',
		'updateBlock'
	],
	#category : 'KFImaging-Morphic',
	#package : 'KFImaging',
	#tag : 'Morphic'
}

{ #category : 'drawing' }
PluggableLayerMorph >> drawLocalOn: aCanvas [

]

{ #category : 'drawing' }
PluggableLayerMorph >> drawOn: aCanvas [
	super drawOn: aCanvas.
	aCanvas
		translateBy: self innerBounds origin
		clippingTo: self innerBounds
		during: [ :offsetCanvas | 
			drawOnBlock
				ifNotNil: [ 
					[ drawOnBlock value: offsetCanvas value: self ]
						on: Error
						do: [ :ex | 
							"nop"
							 ] ]
				ifNil: [ self drawLocalOn: offsetCanvas ] ]
]

{ #category : 'event handling' }
PluggableLayerMorph >> handlesMouseOver: anEvent [
	^true
]

{ #category : 'initialization' }
PluggableLayerMorph >> initialize [
	super initialize.
	self color: Color transparent.
	
]

{ #category : 'geometry' }
PluggableLayerMorph >> innerExtent [
	^self innerBounds extent.
]

{ #category : 'geometry' }
PluggableLayerMorph >> localInnerBounds [
	^0@0 extent: self innerExtent.
]

{ #category : 'geometry' }
PluggableLayerMorph >> localPointOf: aPoint [
	^aPoint - self innerBounds origin.
]

{ #category : 'geometry' }
PluggableLayerMorph >> localSensorPoint [

	^ self localPointOf: self activeHand cursorPoint
]

{ #category : 'event handling' }
PluggableLayerMorph >> mouseEnter: anEvent [
	self startStepping.
]

{ #category : 'event handling' }
PluggableLayerMorph >> mouseLeave: anEvent [
	self stopStepping.
]

{ #category : 'testing' }
PluggableLayerMorph >> name [
	^symbol asString.
]

{ #category : 'initialization' }
PluggableLayerMorph >> release [
	self stopStepping.
	drawOnBlock := nil.
	stepBlock := nil.
	stepTime := nil.
	symbol := nil.
	updateBlock := nil.
	super release.
	
]

{ #category : 'addapter' }
PluggableLayerMorph >> setDrawOnBlock: aBlock [
	"arg1: Canvas
	 arg2: layerMorph"
	drawOnBlock := aBlock.
	
]

{ #category : 'addapter' }
PluggableLayerMorph >> setStepBlock: aBlock [
	stepBlock := aBlock.
]

{ #category : 'addapter' }
PluggableLayerMorph >> setUpdateBlock: aBlock [
	"arg1: aParameter
	 arg2: layerMorph"
	updateBlock := aBlock.
	
]

{ #category : 'stepping and presenter' }
PluggableLayerMorph >> step [
	stepBlock ifNotNil: [stepBlock value: self].
]

{ #category : 'testing' }
PluggableLayerMorph >> stepTime [
	stepTime ifNil: [stepTime := 100000].
	^stepTime.
]

{ #category : 'accessing' }
PluggableLayerMorph >> stepTime: aNumber [
	stepTime := aNumber
]

{ #category : 'accessing' }
PluggableLayerMorph >> symbol: aSymbol [
	symbol := aSymbol.
	
	
]

{ #category : 'updating' }
PluggableLayerMorph >> update: aParameter [
	updateBlock ifNotNil: [updateBlock value: aParameter value: self].
	super update: aParameter.
]
