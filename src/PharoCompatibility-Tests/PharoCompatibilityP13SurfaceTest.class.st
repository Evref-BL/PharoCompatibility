"
Shared assertions for compatibility packages that provide the Pharo 13 surface on earlier Pharo versions.
"
Class {
	#name : 'PharoCompatibilityP13SurfaceTest',
	#superclass : 'TestCase',
	#category : 'PharoCompatibility-Tests-Tests',
	#package : 'PharoCompatibility-Tests',
	#tag : 'Tests'
}

{ #category : 'testing' }
PharoCompatibilityP13SurfaceTest class >> isAbstract [

	^ self = PharoCompatibilityP13SurfaceTest
]

{ #category : 'asserting' }
PharoCompatibilityP13SurfaceTest >> assertPharo13SurfacePreservesP13Globals [

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

{ #category : 'asserting' }
PharoCompatibilityP13SurfaceTest >> assertPharo13SurfaceProvidesLegacyFileStreamBinding [

	PharoCompatibility installPharo13Surface.
	self assert: (Smalltalk includesKey: #FileStream)
]

{ #category : 'asserting' }
PharoCompatibilityP13SurfaceTest >> assertPharo13SurfaceProvidesMillisecondSemaphoreTimeout [

	self assert: (Semaphore new waitTimeoutMilliseconds: 1)
]

{ #category : 'tests' }
PharoCompatibilityP13SurfaceTest >> testCompilerExceptionHelpersIgnoreOrdinaryExceptions [

	| exception |
	exception := MessageNotUnderstood new.
	self assert: (PharoCompatibility syntaxNoticeFromException: exception) isNil.
	self assert: (PharoCompatibility undeclaredVariableNodeFromException: exception) isNil.
	self assert: (PharoCompatibility compilationAstFromException: exception) isNil
]
