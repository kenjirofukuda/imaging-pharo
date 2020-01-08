Extension { #name : #KFSlideshow }

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
