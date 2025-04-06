Class {
	#name : 'FormSupport',
	#superclass : 'Object',
	#category : 'KFImaging-Core',
	#package : 'KFImaging',
	#tag : 'Core'
}

{ #category : 'service' }
FormSupport class >> convertToMonocroFilmForm: aForm [
	| dstForm newColor |
	dstForm := aForm asGrayScale as8BitColorForm.
	dstForm colorsUsed
		do: [ :oldColor |
			newColor := (Color gray: 0.0) alpha: ( 1 - oldColor brightness ).
			dstForm replaceColor: oldColor with: newColor].
	^dstForm.

"Example:"
"
	| f |
	Display depth = 32 ifFalse: [^self].
	f := Form fromUser.
	f := self convertToMonocroFilmForm: f.
	Display restoreAfter: [
		false ifTrue: [Display fillWhite].
		f displayOn: Display at: (0@0) rule: Form blend].
"
]

{ #category : 'service' }
FormSupport class >> convertToMonocroFilmMorph: aForm [
	^(self convertToMonocroFilmForm: aForm) asMorph.

"Example:"

"

	| f |
	Display depth = 32 ifFalse: [^self].
	f := Form fromUser.
	(self convertToMonocroFilmMorph: f)
		openInWorld.
"
]

{ #category : 'service' }
FormSupport class >> fillForm: aBaseForm withMask: aFormOrColor [
	| newForm  toneForm rule |
	newForm := aBaseForm deepCopy.
	rule := aBaseForm depth = 1
		ifTrue: [Form and.]
		ifFalse: [Form under.].
	toneForm := self makeHalftoneMaskForm: aBaseForm pattern: aFormOrColor.
	toneForm displayOn: newForm at: (0 @ 0) rule: rule.
	^ newForm.
]

{ #category : 'service' }
FormSupport class >> hexStringOf32BitInteger: aNumber [

	"Transcript cr; show: (self hexStringOf32BitInteger: -1)"
	| r16 str |
	r16 := aNumber radix: 16.
	str := r16 copyReplaceAll: '16r' with: ''. 
	(8 - (str size)) timesRepeat: [
		str := '0', str.
	]. 
	str := '16r', str.
	^str.
	
]

{ #category : 'service' }
FormSupport class >> makeHalftoneMaskForm: aBaseForm pattern: aFormOrColor [
	| bwHalfToneForm |
	bwHalfToneForm := Form extent: aBaseForm extent depth: 1.
	aFormOrColor class = Color
		ifTrue: [bwHalfToneForm fillWithColor: aFormOrColor].
	aFormOrColor class = InfiniteForm
		ifTrue: [aFormOrColor displayOn: bwHalfToneForm].
	aFormOrColor class = Form
		ifTrue: [(InfiniteForm with: aFormOrColor) displayOn: bwHalfToneForm].
	^bwHalfToneForm.

]

{ #category : 'service' }
FormSupport class >> tallyUniqPixelValuesOf: aForm [
	aForm tallyPixelValues asSet.
]

{ #category : 'service' }
FormSupport class >> usedColorsPanelFrom: aForm [ 
	| top colors |
	top := AlignmentMorph newColumn.
	top beTransparent.
	top layoutPolicy: TableLayout new.
	top clipSubmorphs: false.
	top borderWidth: 0.
	top extent: 50 @ 100.
	top vResizing: #shrinkWarp.
	top hResizing: #shrinkWarp.
	top setProperty: #modelForm toValue: aForm.
	colors := ColorSupport sortByLuminanceColors: (aForm colorsUsed ) .
	top setProperty: #colorsUsed toValue: colors.
	top addAllMorphs:
		(ColorSupport sampleMorphsOfColors: colors).

	top changed.
	top openInWorld
]
