"
Tests for the Pharo 12 surface restored on Pharo 13 and later.
"
Class {
	#name : 'PharoCompatibilityP12SurfacePharo13Test',
	#superclass : 'TestCase',
	#category : 'PharoCompatibility-Pharo12Surface-Pharo13-Tests-Tests',
	#package : 'PharoCompatibility-Pharo12Surface-Pharo13-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PharoCompatibilityP12SurfacePharo13Test >> testAuthorCompatibilityProtocol [

	| authorClass observedFullName previousFullName |
	PharoCompatibility installPharo12Surface.
	authorClass := Smalltalk at: #Author ifAbsent: [ nil ].
	self assert: authorClass notNil.
	self assert: (authorClass respondsTo: #fullNamePerSe).
	self assert: (authorClass respondsTo: #useAuthor:during:).
	previousFullName := authorClass fullNamePerSe.
	self
		assert: (authorClass useAuthor: 'MCP' during: [
				 observedFullName := authorClass fullNamePerSe.
				 42 ])
		equals: 42.
	self assert: observedFullName equals: 'MCP'.
	self assert: authorClass fullNamePerSe equals: previousFullName
]

{ #category : 'tests' }
PharoCompatibilityP12SurfacePharo13Test >> testInstallPharo12SurfacePreservesMissingGlobals [

	PharoCompatibility installPharo12Surface.
	self assert: (Smalltalk includesKey: #SyntaxErrorNotification).
	self assert:
		(Smalltalk includesKey: #RBPullUpInstanceVariableRefactoring).
	self assert:
		(Smalltalk includesKey: #RBPushDownInstanceVariableRefactoring)
]
