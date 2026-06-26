Extension { #name : 'PharoCompatibility' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo13' }
PharoCompatibility class >> compilationAstFromException: anError [

	^ nil
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo13' }
PharoCompatibility class >> debuggerMethodImplementorForSession: aDebugSession [

	^ StDebuggerMethodImplementor forSession: aDebugSession
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo13' }
PharoCompatibility class >> refactoringChangeManagerClass [

	^ RBRefactoryChangeManager
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo13' }
PharoCompatibility class >> syntaxErrorNoticeClassName [

	^ 'OCSyntaxErrorNotice'
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo13' }
PharoCompatibility class >> syntaxNoticeFromException: anError [

	^ anError notice
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo13' }
PharoCompatibility class >> undeclaredVariableNodeFromException: anError [

	^ anError notice node
]
