Class {
	#name : #ColorSupport,
	#superclass : #Object,
	#category : #'KFImaging-Core'
}

{ #category : #service }
ColorSupport class >> codeGenarateOn: aStream colors:  aColorArray varNamePrefix: aPrefix [
	
	aStream
		cr;
		nextPutAll: '| '.
	1 to: aColorArray size do: [ :index |
		aStream nextPutAll: aPrefix.
		aStream nextPutAll:(index printString).
		aStream nextPut: Character space].
	aStream
		nextPut: $|;
		cr.
	(self hexStringArrayFromColors: aColorArray)
		doWithIndex: [ :hexColorExpr :index |
			aStream
				nextPutAll: aPrefix; 
				nextPutAll: (index printString);
				nextPutAll: ' := ';
				nextPutAll: 'Color fromString: '; 
				nextPutAll: hexColorExpr;
				nextPut: $.;
				cr.
			].
	aStream cr; flush.

]

{ #category : #service }
ColorSupport class >> hexStringArrayFromColors: aColorArray [
	^aColorArray
		collect: [ :color | '#', color hex].
]

{ #category : #service }
ColorSupport class >> mergeByLuminanceColors: aColorArray1 withColors: aColorArray2 [ 
	| colorSet colors |

	colorSet := Set new.
	colorSet addAll: aColorArray1.
	colorSet addAll: aColorArray2.
	colors := SortedCollection new.
	colors
		sortBlock: [:c1 :c2 | c1 luminance < c2 luminance].
	colors addAll: colorSet.
	^ colors asArray.
]

{ #category : #service }
ColorSupport class >> pureColorOf: aColor [
	aColor isGray
		ifTrue: [
			aColor luminance <= 0.5
				ifTrue: [^Color black]
				ifFalse: [^Color white].]
		ifFalse: [^Color h: (aColor hue ) s: 1.0 v: 1.0].

]

{ #category : #service }
ColorSupport class >> sampleMorphOfColor: aColor [ 
	"(self sampleMorphOfColor: Color blue) openInWorld."

	| r |	
	r := BorderedMorph new.
	r hResizing: #spaceFill.
	r vResizing: #spaceFill.
	r minimumExtent: 10 @ 10.
	r borderWidth: 0.
	r color: aColor.
	r name: '#' , aColor hex.
	^ r
]

{ #category : #service }
ColorSupport class >> sampleMorphsOfColors: aColorArray [ 
	^aColorArray
		collect: [ :color | self sampleMorphOfColor: color].
]

{ #category : #service }
ColorSupport class >> sortByLuminanceColors: aColorArray [
	| colorSet colors |

	colorSet := Set new.
	colorSet addAll: aColorArray.
	colors := SortedCollection new.
	colors
		sortBlock: [:c1 :c2 | c1 luminance < c2 luminance].
	colors addAll: colorSet.
	^ colors asArray.
]
