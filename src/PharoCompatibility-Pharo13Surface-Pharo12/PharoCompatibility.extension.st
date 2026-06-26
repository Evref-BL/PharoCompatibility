Extension { #name : 'PharoCompatibility' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo12' }
PharoCompatibility class >> compilationAstFromException: anError [

	^ anError pharoCompatibilityCompilationAst
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo12' }
PharoCompatibility class >> debuggerMethodImplementorForSession: aDebugSession [
	"Pharo 12 does not provide the Pharo 13 debugger method implementor. Answer nil so callers keep their explicit fallback path instead of probing runtime globals."

	^ nil
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo12' }
PharoCompatibility class >> refactoringChangeManagerClass [

	^ RBRefactoryChangeManager
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo12' }
PharoCompatibility class >> syntaxErrorNoticeClassName [

	^ #RBSyntaxErrorNotice
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo12' }
PharoCompatibility class >> syntaxNoticeFromException: anError [

	^ anError pharoCompatibilitySyntaxNotice
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo12' }
PharoCompatibility class >> undeclaredVariableNodeFromException: anError [

	^ anError pharoCompatibilityUndeclaredVariableNode
]
