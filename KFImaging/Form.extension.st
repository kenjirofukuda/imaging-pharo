Extension { #name : #Form }

{ #category : #'*KFImaging-extension' }
Form >> gtInspectorForm2In: composite [
	<gtInspectorPresentationOrder: 100>  
	^ composite morph 
		title: 'Morph2';
		display: [ (self scaledToSize: 500@500) asMorph ]
]

{ #category : #'*KFImaging-extension' }
Form >> isLandscape [
	^self extent isLandscape 
]

{ #category : #'*KFImaging-extension' }
Form >> isPortlit [
	^self extent isPortlit 
]
