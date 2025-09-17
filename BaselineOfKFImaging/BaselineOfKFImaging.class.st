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
				with: [ spec repository: 'github://kenjirofukuda/geom-pharo:master' ].
			spec package: #KFImaging with: [ spec requires: #('GeometryUtils') ].
			spec package: #'KFImaging-Support'.
			spec package: #'KFImaging-LayerMorph'.
			spec package: #'KFImaging-BitEdit'.
			 ]
]
