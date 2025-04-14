Class {
	#name : #KFFreeTypeSupport,
	#superclass : #Object,
	#category : 'KFImaging-Core'
}

{ #category : #'as yet unclassified' }
KFFreeTypeSupport class >> detectFontPath [
	"self detectFontPath"
	self favaritMonoSpaceFamilyNames do: [:assoc |
		(self ttcFontPathFamilyNamed: assoc key fileShortName: assoc value)
			ifNotNil: [:path | ^path]].
	^nil.
]

{ #category : #'as yet unclassified' }
KFFreeTypeSupport class >> detectPointArrayClassFullRange: aBoolean [ 
	| shortPointArrayClazz |
	shortPointArrayClazz := Smalltalk at: #ShortPointArray ifAbsent: [ PointArray ].
	^aBoolean
		ifTrue: [ PointArray]
		ifFalse:[ shortPointArrayClazz]
]

{ #category : #'as yet unclassified' }
KFFreeTypeSupport class >> doFontPloviderClass: aClassArgBlock [
	"don't call this method".
	"execute each line"

	self freeTypeFontProviderClass 
		ifNotNil: [:clazz | 
			aClassArgBlock value: clazz].


]

{ #category : #'as yet unclassified' }
KFFreeTypeSupport class >> favaritMonoSpaceFamilyNames [
	"specify only ttf. can't specify ttc".
	"  key: familyName"
	"value: nameWithoutExtension"
	^ {'FreeMono'->'FreeMono' . 'Bitstream Vera Sans Mono'->'VeraMono' . 'Osaka'->'OsakaMono' . 'MS Gothic'->'MS Gothic' . 'IPAGothic'->'ipag'}.
	"^ { 'IPAGothic'->'ipag' . 'MS UI Gothic'->'msgothic' . 'FreeMono'->'FreeMono' . 'Bitstream Vera Sans Mono'->'VeraMono' .}"
]

{ #category : #'as yet unclassified' }
KFFreeTypeSupport class >> fixTTFontDescriptionNilProblem [
	<script>
	| descClass |
	"self fixTTFontDescriptionNilProblem"
	descClass := (Smalltalk at: #TTFontDescription ifAbsent: []).
	descClass ifNil: [^nil].
	descClass default 
		ifNil: [FreeTypeFontProvider current updateFromSystem.] 
		ifNotNil: [^nil]. "already set".
	self detectFontPath
		ifNotNil: [:fontPath |
			descClass setDefaultFromPath: fontPath.
			descClass initialize].
	^descClass
	


]

{ #category : #'as yet unclassified' }
KFFreeTypeSupport class >> freeMonoFontPath [
	"self freeMonoFontPath"
	^self ttcFontPathFamilyNamed: 'FreeMono' fileShortName: 'FreeMono'.
]

{ #category : #'as yet unclassified' }
KFFreeTypeSupport class >> freeTypeFontProviderClass [
	^Smalltalk at: #FreeTypeFontProvider ifAbsent: []
]

{ #category : #'as yet unclassified' }
KFFreeTypeSupport class >> ttcFontPathFamilyNamed: aFontFamilyName fileShortName: aShortName [
	"self freeMonoFontPath"
	self doFontPloviderClass: [:clazz |
		(clazz current families at: aFontFamilyName ifAbsent:[]) 
			ifNotNil: [: family |
				(family members detect: [:each |
					each fileInfo absolutePath asFileReference  base sameAs: aShortName] ifNone:[])
						ifNotNil: [:fm |
							^fm fileInfo absolutePath]]].
	^nil


]

{ #category : #'as yet unclassified' }
KFFreeTypeSupport class >> workspace [
	"don't call this method".
	"execute each line"

self doFontPloviderClass: [:clazz | 
	clazz current families explore].


self doFontPloviderClass: [:clazz | 
	clazz current families keys sort explore].

self doFontPloviderClass: [:clazz | 
	(clazz current families at: 'Courier New') explore].


self doFontPloviderClass: [:clazz | 
	((clazz current families at: 'Courier New') members detect: [:each |
		each fileInfo absolutePath asFileEntry name asLowercase beginsWith: 'cour'] ifNone:[]) explore ].


"get only ttf family"
((((Smalltalk at: #FreeTypeFontFamilyMember) 
	allSubInstances 
		select: [:fm | 
			fm fileInfo absolutePath asFileEntry extension sameAs: 'ttf']
		thenCollect: [:fm | 
			(fm fileInfo familyName) ->
			(fm fileInfo absolutePath asFileEntry name)])) sort: [:a :b | a key < b key]) explore.
	
self detectFontPath explore.


]
