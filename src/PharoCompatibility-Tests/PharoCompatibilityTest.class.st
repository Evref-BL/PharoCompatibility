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

{ #category : 'tests' }
PharoCompatibilityTest >> testSyntaxErrorNoticeClassNameIsConcrete [

	self assert: PharoCompatibility syntaxErrorNoticeClassName isString.
	self deny: PharoCompatibility syntaxErrorNoticeClassName isEmpty
]

{ #category : 'tests' }
PharoCompatibilityTest >> testTemporaryNamesForContextReturnsContextTemporaryNames [

	| names temporaryValue |
	temporaryValue := 42.
	names := PharoCompatibility temporaryNamesForContext: thisContext.
	self assert:
		((names collect: [ :each | each asString ]) includes:
			 'temporaryValue')
]
