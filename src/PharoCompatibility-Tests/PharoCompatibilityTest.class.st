"
Tests for the PharoCompatibility core behavior that is independent of a specific compatibility surface.
"
Class {
	#name : 'PharoCompatibilityTest',
	#superclass : 'TestCase',
	#category : 'PharoCompatibility-Tests-Tests',
	#package : 'PharoCompatibility-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PharoCompatibilityTest >> testResumeDeprecationsDuringReturnsBlockValue [

	self
		assert: (PharoCompatibility resumeDeprecationsDuring: [ 42 ])
		equals: 42
]
