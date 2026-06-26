"
Tests runtime-specific Pharo 13 compatibility surface behavior.
"
Class {
	#name : 'PharoCompatibilityP13SurfacePharo13Test',
	#superclass : 'PharoCompatibilityP13SurfaceTest',
	#category : 'PharoCompatibility-Pharo13Surface-Pharo13-Tests-Tests',
	#package : 'PharoCompatibility-Pharo13Surface-Pharo13-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo13Test >> testDebuggerMethodImplementorForSession [

	self
		assert: (PharoCompatibility debuggerMethodImplementorForSession: nil) class
		equals: StDebuggerMethodImplementor
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo13Test >> testRefactoringChangeManagerClass [

	self
		assert: PharoCompatibility refactoringChangeManagerClass
		equals: RBRefactoryChangeManager
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo13Test >> testSyntaxErrorNoticeClassName [

	self
		assert: PharoCompatibility syntaxErrorNoticeClassName
		equals: 'OCSyntaxErrorNotice'
]
