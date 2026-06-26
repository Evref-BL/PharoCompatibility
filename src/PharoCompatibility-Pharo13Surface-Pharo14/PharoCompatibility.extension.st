Extension { #name : 'PharoCompatibility' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
PharoCompatibility class >> compilationAstFromException: anError [

	^ anError compilationResult ast
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

	^ nil
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
PharoCompatibility class >> undeclaredVariableNodeFromException: anError [

	^ self undeclaredVariableNodeInAst:
		(anError compilationResult ast)
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
