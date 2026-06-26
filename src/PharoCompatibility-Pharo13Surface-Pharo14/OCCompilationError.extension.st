Extension { #name : 'OCCompilationError' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
OCCompilationError >> pharoCompatibilityCompilationAst [

	^ self compilationResult ast
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
OCCompilationError >> pharoCompatibilityUndeclaredVariableNode [

	^ PharoCompatibility undeclaredVariableNodeInAst:
		  self pharoCompatibilityCompilationAst
]
