"
Baseline for PharoCompatibility, a small compatibility surface library for projects developed against one Pharo version and loaded in another.
"
Class {
	#name : 'BaselineOfPharoCompatibility',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPharoCompatibility',
	#package : 'BaselineOfPharoCompatibility'
}

{ #category : 'baselines' }
BaselineOfPharoCompatibility >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec postLoadDoIt: #postload:package:.
		spec
			package: 'PharoCompatibility-Core';
			package: 'PharoCompatibility-Tests'
			with: [ spec requires: #( 'PharoCompatibility-Core' ) ];
			group: 'default' with: #( 'PharoCompatibility-Core' );
			group: 'Pharo12Surface' with: #( 'PharoCompatibility-Core' );
			group: 'Tests' with: #( 'PharoCompatibility-Tests' ) ].

	spec for: (self pharoVersionsFrom: 13) do: [
		spec
			package: 'PharoCompatibility-Pharo12Surface-Pharo13'
			with: [ spec requires: #( 'PharoCompatibility-Core' ) ];
			package: 'PharoCompatibility-Tests'
			with: [
				spec requires: #( 'PharoCompatibility-Pharo12Surface-Pharo13' ) ];
			group: 'Pharo12Surface'
			with: #( 'PharoCompatibility-Pharo12Surface-Pharo13' ) ]
]

{ #category : 'actions' }
BaselineOfPharoCompatibility >> postload: loader package: packageSpec [

	(Smalltalk at: #PharoCompatibility ifAbsent: [ ^ self ])
		installLoadedSurfaces
]
