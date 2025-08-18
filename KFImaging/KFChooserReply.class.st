Class {
	#name : #KFChooserReply,
	#superclass : #Object,
	#instVars : [
		'reply'
	],
	#category : #'KFImaging-Morphic'
}

{ #category : #'instance creation' }
KFChooserReply class >> example [
	"self example."

	(KFChooserReply on: UIManager default chooseDirectory)
		selectedPathDo: [ :path | path inspect ]
		onCancel: [ UIManager inform: 'Cancel''d' ]
]

{ #category : #'instance creation' }
KFChooserReply class >> on: aFileDirectoryOrFileReference [
	^ self new reply: aFileDirectoryOrFileReference; yourself
]

{ #category : #accessing }
KFChooserReply >> pathName [
	reply ifNil: [^''].
	^ reply perform: self pathNameSelector 
]

{ #category : #accessing }
KFChooserReply >> pathNameSelector [
	^ (reply className sameAs: 'FileDirectory')
		ifTrue: [ #pathName ]
		ifFalse: [ #fullName ]
]

{ #category : #accessing }
KFChooserReply >> reply: aDosFileDirectory [ 
	reply := aDosFileDirectory
]

{ #category : #accessing }
KFChooserReply >> selectedPathDo: aChoosedBlock onCancel: aCancelBlock [
	self pathName ifNotEmpty: aChoosedBlock ifEmpty: aCancelBlock
]
