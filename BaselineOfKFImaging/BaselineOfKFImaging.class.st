Class {
	#name : #BaselineOfKFImaging,
	#superclass : #BaselineOf,
	#category : #BaselineOfKFImaging
}

{ #category : #baselines }
BaselineOfKFImaging >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				package: 'GeometryUtils'
				with: [ spec repository: 'github://kenjirofukuda/geom-pharo:Pharo6.1' ].
			spec package: #KFImaging with: [ spec requires: #('GeometryUtils') ] ]
]
