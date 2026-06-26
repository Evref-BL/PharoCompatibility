Extension { #name : 'PharoCompatibility' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
PharoCompatibility class >> compilationAstFromException: anError [

	^ anError pharoCompatibilityCompilationAst
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
PharoCompatibility class >> debuggerMethodImplementorForSession: aDebugSession [

	^ StDebuggerMethodImplementor forSession: aDebugSession
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
PharoCompatibility class >> refactoringChangeManagerClass [

	^ ReChangeManager
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
PharoCompatibility class >> syntaxErrorNoticeClassName [

	^ #OCSyntaxErrorNotice
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
PharoCompatibility class >> syntaxNoticeFromException: anError [

	^ anError pharoCompatibilitySyntaxNotice
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
PharoCompatibility class >> undeclaredVariableNodeFromException: anError [

	^ anError pharoCompatibilityUndeclaredVariableNode
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
PharoCompatibility class >> undeclaredVariableNodeInAst: anAst [

	anAst ifNil: [ ^ nil ].
	^ anAst variableNodes
		detect: [ :node |
			| variable |
			variable := node variable.
			variable notNil and: [ variable isUndeclaredVariable ] ]
		ifNone: [ nil ]
]
