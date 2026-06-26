Extension { #name : 'PharoCompatibility' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo12' }
PharoCompatibility class >> debuggerMethodImplementorForSession: aDebugSession [
	"Pharo 12 does not provide the Pharo 13 debugger method implementor. Answer nil so callers keep their explicit fallback path instead of probing runtime globals."

	^ nil
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo12' }
PharoCompatibility class >> refactoringChangeManagerClass [

	^ RBRefactoryChangeManager
]
