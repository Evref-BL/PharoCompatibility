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

	| observedFullName previousFullName |
	PharoCompatibility installPharo12Surface.
	previousFullName := PharoCompatibilityAuthor fullNamePerSe.
	self
		assert: (PharoCompatibilityAuthor useAuthor: 'MCP' during: [
			observedFullName := PharoCompatibilityAuthor fullNamePerSe.
			42 ])
		equals: 42.
	self assert: observedFullName equals: 'MCP'.
	self assert: PharoCompatibilityAuthor fullNamePerSe equals: previousFullName
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

{ #category : 'tests' }
PharoCompatibilityP12SurfacePharo13Test >> testWithNonInteractiveAuthorUsesShimWhenNoAuthorIsConfigured [

	| observedFullName previousFullName |
	PharoCompatibility installPharo12Surface.
	previousFullName := PharoCompatibilityAuthor fullNamePerSe.
	PharoCompatibilityAuthor fullName: ''.
	[
	self
		assert: (PharoCompatibility
				withNonInteractiveAuthorNamed: 'MCP'
				during: [
					observedFullName := PharoCompatibilityAuthor fullNamePerSe.
					42 ])
		equals: 42.
	self assert: observedFullName equals: 'MCP'.
	self assert: PharoCompatibilityAuthor fullNamePerSe isEmpty ]
		ensure: [ PharoCompatibilityAuthor fullName: previousFullName ]
]
