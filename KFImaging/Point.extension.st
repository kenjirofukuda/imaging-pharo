Extension { #name : 'Point' }

{ #category : '*KFImaging' }
Point >> isLandscape [
	^x > y
]

{ #category : '*KFImaging' }
Point >> isPortlit [
	^x < y
]
