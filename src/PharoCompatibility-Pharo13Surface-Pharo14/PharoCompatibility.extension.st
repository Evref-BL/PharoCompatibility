Extension { #name : 'PharoCompatibility' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
PharoCompatibility class >> debuggerMethodImplementorForSession: aDebugSession [

	^ StDebuggerMethodImplementor forSession: aDebugSession
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
PharoCompatibility class >> refactoringChangeManagerClass [

	^ ReChangeManager
]
