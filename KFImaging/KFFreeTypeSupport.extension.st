Extension { #name : #KFFreeTypeSupport }

{ #category : #'*KFImaging-Deprecated60' }
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

{ #category : #'*KFImaging-Deprecated60' }
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
