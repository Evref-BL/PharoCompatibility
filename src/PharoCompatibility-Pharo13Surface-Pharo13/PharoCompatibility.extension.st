Extension { #name : 'PharoCompatibility' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo13' }
PharoCompatibility class >> debuggerMethodImplementorForSession: aDebugSession [

	^ StDebuggerMethodImplementor forSession: aDebugSession
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo13' }
PharoCompatibility class >> refactoringChangeManagerClass [

	^ RBRefactoryChangeManager
]
