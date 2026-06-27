"
Tests for the Pharo 13 surface restored on Pharo 12.
"
Class {
	#name : 'PharoCompatibilityP13SurfacePharo12Test',
	#superclass : 'PharoCompatibilityP13SurfaceTest',
	#category : 'PharoCompatibility-Pharo13Surface-Pharo12-Tests-Tests',
	#package : 'PharoCompatibility-Pharo13Surface-Pharo12-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo12Test >> testDebuggerMethodImplementorForSession [

	self assert:
		(PharoCompatibility debuggerMethodImplementorForSession: nil) isNil
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo12Test >> testInstallPharo13SurfacePreservesP13Globals [

	self assertPharo13SurfacePreservesP13Globals
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo12Test >> testInstallPharo13SurfaceProvidesLegacyFileStreamBinding [

	self assertPharo13SurfaceProvidesLegacyFileStreamBinding
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo12Test >> testInstallPharo13SurfaceProvidesMillisecondSemaphoreTimeout [

	self assertPharo13SurfaceProvidesMillisecondSemaphoreTimeout
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo12Test >> testRefactoringChangeManagerClass [

	self
		assert: PharoCompatibility refactoringChangeManagerClass
		equals: RBRefactoryChangeManager
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo12Test >> testSyntaxErrorNoticeClassName [

	self
		assert: PharoCompatibility syntaxErrorNoticeClassName
		equals: #RBSyntaxErrorNotice
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo12Test >> testUndeclaredVariableNodeFromCompileWarning [

	| node |
	[ Object
		compile: 'pharoCompatibilityBrokenMethod ^ missingCompatibilityVariable' ]
		on: Exception
		do: [ :error |
			node := PharoCompatibility undeclaredVariableNodeFromException: error ].
	self assert: node notNil.
	self assert: node name equals: #missingCompatibilityVariable
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo12Test >> testWithNonInteractiveAuthorUsesAuthorWhenNoAuthorIsConfigured [

	| observedFullName |
	Author useAuthor: '' during: [
		self
			assert:
				(PharoCompatibility
					 withNonInteractiveAuthorNamed: 'MCP'
					 during: [
						 observedFullName := Author fullNamePerSe.
						 42 ])
			equals: 42.
		self assert: observedFullName equals: 'MCP'.
		self assert: Author fullNamePerSe isEmpty ]
]
