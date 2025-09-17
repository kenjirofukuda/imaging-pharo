Extension { #name : #Morph }

{ #category : #'*KFImaging' }
Morph >> invalidLocalRect: damageRect [

	^ self invalidRect: (damageRect translateBy: self innerBounds origin)
]
