Class {
	#name : 'KFEventSupport',
	#superclass : 'Object',
	#category : 'KFImaging-Morphic',
	#package : 'KFImaging',
	#tag : 'Morphic'
}

{ #category : 'testing' }
KFEventSupport class >> isWheelDownEvent: aEvent [
	(aEvent isMouseWheel)
		ifFalse: [ ^ false ].
	(aEvent respondsTo: #isDown)
		ifTrue: [ ^ aEvent perform: #isDown ].
	^ aEvent direction = #down.
]

{ #category : 'testing' }
KFEventSupport class >> isWheelUpEvent: aEvent [
	(aEvent isMouseWheel)
		ifFalse: [ ^ false ].
	(aEvent respondsTo: #isUp)
		ifTrue: [ ^ aEvent perform: #isUp ].
	^ aEvent direction = #up.
]
