Class {
	#name : #KFImagingSettings,
	#superclass : #Object,
	#instVars : [
		'pngSaveDirectory'
	],
	#classVars : [
		'Instance'
	],
	#category : 'KFImaging-Morphic'
}

{ #category : #accessing }
KFImagingSettings class >> instance [
	^ Instance := Instance ifNil: [ self new ].
]

{ #category : #settings }
KFImagingSettings class >> settingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #KFImaging)
		with: [ 
			(aBuilder setting: #pngSaveDirectory)
				type: #Directory;
				target: self;
				targetSelector: #instance;
				description: 'The path of a directory where png file';
				label: 'PNG Save directory' ].

]

{ #category : #'menu items' }
KFImagingSettings class >> windowMenuOn: aBuilder [
	"Window Shot utility"

	<windowMenu>
	(self instance pngSaveDirectory asString asFileReference isDirectory)
		ifTrue: [ 
			(aBuilder item: #'Save As PNG')
				action: [ self instance savePngMorph: aBuilder model ];
				iconName: #image;
				order: 300;
				withSeparatorAfter ]
]

{ #category : #accessing }
KFImagingSettings >> pngSaveDirectory [
	^ pngSaveDirectory ifNil: [
		pngSaveDirectory :=  FileSystem workingDirectory fullName].
]

{ #category : #accessing }
KFImagingSettings >> pngSaveDirectory: aFileReference [
	pngSaveDirectory := aFileReference
]

{ #category : #'menu items' }
KFImagingSettings >> savePngMorph: aMorph [
	PNGReadWriter
		putForm: aMorph imageForm
		onFileNamed:
			(self pngSaveDirectory asFileReference / (aMorph asString , '.png'))
				nextVersion
]
