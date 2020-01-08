"
A KFSlideshow is xxxxxxxxx.

Instance Variables
	isAbortBlock:		<BlockContext>

isAbortBlock
	- must be Boolean result return block.

"
Class {
	#name : #KFSlideshow,
	#superclass : #Object,
	#instVars : [
		'isAbortBlock',
		'displayBounds'
	],
	#category : #'KFImaging-Core'
}

{ #category : #examples }
KFSlideshow class >> cursorForms [
	^ ([ Cursor class allMethodsInCategory: #constants ]
		on: Error
		do: [ :ex | ex return: (Cursor class allSelectorsInProtocol: #constants) ]) 
			collect: [ :sel | Cursor perform: sel ]
]

{ #category : #accessing }
KFSlideshow class >> displayFull: aImage [
	self displayFull: aImage inBounds: Display boundingBox.
]

{ #category : #accessing }
KFSlideshow class >> displayFull: aImage inBounds: aRectangle [
	| scaledImage |
	scaledImage := aImage scaledToSize: aRectangle extent.	
	Display fadeImageHorFine: scaledImage at: ((aRectangle extent // 2) - (scaledImage extent // 2) + aRectangle origin).
]

{ #category : #examples }
KFSlideshow class >> example [
	"KFSlideshow example."

	| slideShow paths |
	(KFChooserReply on: UIManager default chooseDirectory)
		selectedPathDo: [ :path | 
			slideShow := KFSlideshow new.
			paths := slideShow pathsFromPath: path limit: 500 extensions: #('jpg').
			paths
				ifNotEmpty: [ [ slideShow showFileImages: paths delaySeconds: 3 ] fork ]
				ifEmpty: [ ^ UIManager default inform: 'Image not found!!' ] ]
		onCancel: [ UIManager default inform: 'Cancel''ed' ]
]

{ #category : #examples }
KFSlideshow class >> exampleCursor [
	"KFSlideshow exampleCursor."
	| slideShow images |
	slideShow := KFSlideshow new.
	slideShow displayBounds: Rectangle fromUser.
	images := self cursorForms.
	slideShow 
		showImages: images
		delaySeconds: 1
]

{ #category : #'class initialization' }
KFSlideshow class >> initialize [
	"self openReadMe"
	"self openReadMe. "
]

{ #category : #testing }
KFSlideshow class >> isHighQuorityImage: aForm [
	^((aForm extent y) > (aForm extent x))
		ifTrue: [(aForm extent y >= 640) and: [aForm extent x >= 480]]
		ifFalse: [(aForm extent y >= 480) and: [aForm extent x >= 640]].
]

{ #category : #documentation }
KFSlideshow class >> openReadMe [
	"self openReadMe."
	| window |
	window := SystemWindow allSubInstances 
						detect: [:w | w label sameAs: self readMeTitle] ifNone: [nil].
	window ifNotNil: [window owner ifNotNil: [^self]].
	(StringHolder new contents: self readMeContents)
		openLabel: self readMeTitle.
 
]

{ #category : #documentation }
KFSlideshow class >> readMeContents [
	^self readMeV001
]

{ #category : #documentation }
KFSlideshow class >> readMeTitle [
	^'README - ', 'KFImaging'.

]

{ #category : #documentation }
KFSlideshow class >> readMeV001 [
	^
'
kf 10/7/2009 10:49

remove assignment for closure variable.
(Syntax error on Pharo) 

'
]

{ #category : #'initialize-release' }
KFSlideshow >> abortWhenCursorTop [
	^ActiveHand cursorPoint y <= 20.
	
]

{ #category : #private }
KFSlideshow >> didDisplayImage: aImage [

]

{ #category : #accessing }
KFSlideshow >> displayBounds [
	displayBounds ifNil: [displayBounds := Display boundingBox].
	^displayBounds
	
]

{ #category : #accessing }
KFSlideshow >> displayBounds: aRectangle [
	self assert: [aRectangle width > 0 and: [aRectangle height > 0]].
	displayBounds := aRectangle.
]

{ #category : #private }
KFSlideshow >> displayFull: aForm [
	self class displayFull: aForm inBounds: self displayBounds.
	
]

{ #category : #private }
KFSlideshow >> displayImage: aForm [
	aForm ifNil: [ ^ self ].
	self willDisplayImage: aForm.
	self privateDisplayImage: aForm.
	self didDisplayImage: aForm
]

{ #category : #private }
KFSlideshow >> displayLoop [
	| imageStream abort |
	imageStream := self imageStream.
	abort := false.
	[imageStream atEnd or: [abort]]
		whileFalse: [
			abort := self oneFrameDisplayImage: imageStream next].
]

{ #category : #private }
KFSlideshow >> imageStream [
	^ReadStream on: #().
	
	
]

{ #category : #'*KFImaging-Deprecated60' }
KFSlideshow >> imagesFromPath: aDirectoryPath limit: aLimitCount extensions: extensionArray [
	|col |
	col := OrderedCollection new.
	((aDirectoryPath asDirectoryEntry)  
		filesMatches: [ :fe | extensionArray includes: fe extension])
		do: [ :fe2 |
			(col size <= aLimitCount)
				ifTrue:[
					col add: (ImageReadWriter formFromFileNamed: fe2 pathName)]].
	^col asArray.

]

{ #category : #'initialize-release' }
KFSlideshow >> initialize [
	super initialize.
	self setupDefaultAbortBlock.

	
]

{ #category : #testing }
KFSlideshow >> isAbort [
	isAbortBlock 
		ifNotNil: [ | abort |
			abort := false.
			[abort := isAbortBlock value. ^abort] 
				on: Error do: [:ex | ^false]].
	^false.
]

{ #category : #accessing }
KFSlideshow >> isAbortBlock: aBooleanAbortBlock [
	isAbortBlock := aBooleanAbortBlock
	
]

{ #category : #private }
KFSlideshow >> oneFrameDisplayImage: aImage [
	self isAbort
		ifTrue: [ ^ true ].
	self displayImage: aImage.
	self isAbort
		ifTrue: [ ^ true ].
	^ false
]

{ #category : #'*KFImaging-Deprecated60' }
KFSlideshow >> pathsFromPath: aDirectoryPath limit: aLimitCount extensions: extensionArray [
	|col |
	col := OrderedCollection new.
	((aDirectoryPath asDirectoryEntry)  
		filesMatches: [ :fe | extensionArray includes: fe extension])
		do: [ :fe2 |
			(col size <= aLimitCount)
				ifTrue:[
					col add: (fe2 pathName)]].
	^(col sort: [ :a :b | a < b ]) asArray.

]

{ #category : #service }
KFSlideshow >> pngImagesFromPath: aDirectoryPath limit: aLimitCount [
	self imagesFromPath: aDirectoryPath limit: aLimitCount extensions: #('png')
]

{ #category : #private }
KFSlideshow >> privateDisplayImage: aForm [
	self displayFull: aForm.
	
]

{ #category : #private }
KFSlideshow >> privateShowFileImages: aPaths preDisplayBlock: aPerDisplayBlock [
	aPaths
		do: [ :path | 
			self isAbort
				ifTrue: [ ^ self ].
			aPerDisplayBlock value.
			self isAbort
				ifTrue: [ ^ self ].
			self
				displayImage:
					([ ImageReadWriter formFromFileNamed: path ]
						on: Error
						do: [ :ex | 
							(path -> ex) logCr.
							ex return: nil ]).
			self isAbort
				ifTrue: [ ^ self ] ]
]

{ #category : #private }
KFSlideshow >> privateShowImages: aImages preDisplayBlock: aPerDisplayBlock [ 
	aImages do: 
		[ :img | 
		self isAbort ifTrue: [^self].
		aPerDisplayBlock value.
		self isAbort ifTrue: [^self].
		self displayImage: img.
		self isAbort ifTrue: [^self].]
]

{ #category : #'initialize-release' }
KFSlideshow >> setupDefaultAbortBlock [
	self isAbortBlock: [self abortWhenCursorTop]
	
]

{ #category : #service }
KFSlideshow >> showFileImages: aPaths delaySeconds: aDelaySeconds [ 
	self 
		showFileImages: aPaths
		preDisplayBlock: [ (Delay forSeconds: aDelaySeconds) wait]
]

{ #category : #service }
KFSlideshow >> showFileImages: aImages preDisplayBlock: aPerDisplayBlock [
	self privateShowFileImages: aImages preDisplayBlock: aPerDisplayBlock.
	aPerDisplayBlock value.
	Display restore
]

{ #category : #service }
KFSlideshow >> showImages: aImages delay: aDelay [
	self deprecated: 'use #showImages:delaySeconds:'.
	self showImages: aImages delaySeconds: aDelay
]

{ #category : #service }
KFSlideshow >> showImages: aImages delaySeconds: aDelaySeconds [ 
	self 
		showImages: aImages
		preDisplayBlock: [ (Delay forSeconds: aDelaySeconds) wait]
]

{ #category : #service }
KFSlideshow >> showImages: aImages preDisplayBlock: aPerDisplayBlock [
	self privateShowImages: aImages preDisplayBlock: aPerDisplayBlock.
	aPerDisplayBlock value.
	Display restore
]

{ #category : #private }
KFSlideshow >> willDisplayImage: aImage [

]
