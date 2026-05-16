"
Tests for the currently implemented PharoCompatibility surfaces.
"
Class {
	#name : 'PharoCompatibilityTest',
	#superclass : 'TestCase',
	#category : 'PharoCompatibility-Tests-Tests',
	#package : 'PharoCompatibility-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PharoCompatibilityTest >> testAuthorCompatibilityProtocol [

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
PharoCompatibilityTest >> testInstallPharo12SurfacePreservesMissingGlobals [

	PharoCompatibility installPharo12Surface.
	self assert: (Smalltalk includesKey: #SyntaxErrorNotification).
	self assert:
		(Smalltalk includesKey: #RBPullUpInstanceVariableRefactoring).
	self assert:
		(Smalltalk includesKey: #RBPushDownInstanceVariableRefactoring)
]

{ #category : 'tests' }
PharoCompatibilityTest >> testInstallPharo13SurfacePreservesP13Globals [

	| ocSyntaxErrorNoticeClass syntaxErrorNotificationClass |
	PharoCompatibility installPharo13Surface.
	self assert: (Smalltalk includesKey: #OCSyntaxErrorNotice).
	self assert:
		(Smalltalk includesKey: #RePullUpInstanceVariableRefactoring).
	ocSyntaxErrorNoticeClass := Smalltalk at: #OCSyntaxErrorNotice.
	syntaxErrorNotificationClass := Smalltalk at: #SyntaxErrorNotification.
	self assert:
		(syntaxErrorNotificationClass new isKindOf: ocSyntaxErrorNoticeClass)
]

{ #category : 'tests' }
PharoCompatibilityTest >> testInstallPharo13SurfaceProvidesLegacyFileStreamBinding [

	SystemVersion current major >= 13 ifTrue: [ ^ self ].
	PharoCompatibility installPharo13Surface.
	self assert: (Smalltalk includesKey: #FileStream)
]

{ #category : 'tests' }
PharoCompatibilityTest >> testInstallPharo13SurfaceProvidesMillisecondSemaphoreTimeout [

	self assert: (Semaphore new respondsTo: #waitTimeoutMilliseconds:).
	self assert: (Semaphore new waitTimeoutMilliseconds: 1)
]

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
