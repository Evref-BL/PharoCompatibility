"
PharoCompatibility installs narrowly scoped compatibility surfaces for projects that were developed against a specific Pharo version and are loaded in another Pharo version.
"
Class {
	#name : 'PharoCompatibility',
	#superclass : 'Object',
	#category : 'PharoCompatibility-Core-Core',
	#package : 'PharoCompatibility-Core',
	#tag : 'Core'
}

{ #category : 'errors' }
PharoCompatibility class >> compilationAstFromException: anError [

	| compilationResult |
	(anError respondsTo: #compilationResult) ifFalse: [ ^ nil ].
	compilationResult := anError compilationResult.
	(compilationResult respondsTo: #ast) ifTrue: [
		^ compilationResult ast ].
	^ [ compilationResult instVarNamed: 'ast' ]
		  on: Error
		  do: [ :ignored | nil ]
]

{ #category : 'accessing' }
PharoCompatibility class >> currentMajorVersion [

	^ SystemVersion current major
]

{ #category : 'private' }
PharoCompatibility class >> firstExistingGlobalFrom: globalNames [

	| global |
	globalNames do: [ :globalName |
		global := Smalltalk at: globalName ifAbsent: [ nil ].
		global ifNotNil: [ ^ global ] ].
	^ nil
]

{ #category : 'installing' }
PharoCompatibility class >> installAuthorCompatibility [

	| authorClass |
	(Smalltalk includesKey: #Author) ifTrue: [ ^ Smalltalk at: #Author ].
	authorClass := Smalltalk
		               at: #PharoCompatibilityAuthor
		               ifAbsent: [ ^ nil ].
	Smalltalk at: #Author put: authorClass.
	^ authorClass
]

{ #category : 'installing' }
PharoCompatibility class >> installLoadedSurfaces [

	| surfaceClass |
	#( PharoCompatibilityP12Surface PharoCompatibilityP13Surface ) do: [
		:surfaceClassName |
		surfaceClass := Smalltalk at: surfaceClassName ifAbsent: [ nil ].
		surfaceClass ifNotNil: [ surfaceClass install ] ]
]

{ #category : 'private' }
PharoCompatibility class >> installMissingGlobalNamed: missingGlobalName from: replacementGlobalNames [

	| replacement |
	(Smalltalk includesKey: missingGlobalName) ifTrue: [
		^ Smalltalk at: missingGlobalName ].
	replacement := self firstExistingGlobalFrom: replacementGlobalNames.
	replacement ifNil: [ ^ nil ].
	Smalltalk at: missingGlobalName put: replacement.
	^ replacement
]

{ #category : 'installing' }
PharoCompatibility class >> installPharo12Surface [

	self
		installMissingGlobalNamed: #SyntaxErrorNotification
		from: #( OCSyntaxErrorNotice RBSyntaxErrorNotice ).
	self
		installMissingGlobalNamed: #RBPullUpInstanceVariableRefactoring
		from: #( RePullUpInstanceVariableRefactoring ).
	self
		installMissingGlobalNamed: #RBPushDownInstanceVariableRefactoring
		from: #( RePushDownInstanceVariableRefactoring ).
	self installAuthorCompatibility
]

{ #category : 'installing' }
PharoCompatibility class >> installPharo13Surface [

	self
		installMissingGlobalNamed: #OCSyntaxErrorNotice
		from: #( SyntaxErrorNotification RBSyntaxErrorNotice ).
	self
		installMissingGlobalNamed: #RePullUpInstanceVariableRefactoring
		from: #( RBPullUpInstanceVariableRefactoring ).
	self
		installMissingGlobalNamed: #FileStream
		from: #( Stdio ).
	self
		installMissingGlobalNamed: #IceBranchAlreadyExists
		from: #( IceBranchAlreadyExistsError )
]

{ #category : 'testing' }
PharoCompatibility class >> isPharo13OrLater [

	^ self currentMajorVersion >= 13
]

{ #category : 'accessing' }
PharoCompatibility class >> loadedSurfaces [

	| surfaceClass surfaces |
	surfaces := OrderedCollection new.
	#( PharoCompatibilityP12Surface PharoCompatibilityP13Surface ) do: [
		:surfaceClassName |
		surfaceClass := Smalltalk at: surfaceClassName ifAbsent: [ nil ].
		surfaceClass ifNotNil: [ surfaces add: surfaceClass surfaceName ] ].
	^ surfaces asArray
]

{ #category : 'errors' }
PharoCompatibility class >> noticeFromException: anError ifKindOfAnyNamed: classNames [

	| candidate |
	candidate := anError.
	(anError respondsTo: #notice) ifTrue: [
		anError notice ifNotNil: [ :notice | candidate := notice ] ].
	^ (self object: candidate isKindOfAnyClassNamed: classNames)
		  ifTrue: [ candidate ]
		  ifFalse: [ nil ]
]

{ #category : 'private' }
PharoCompatibility class >> object: anObject isKindOfAnyClassNamed: classNames [

	classNames do: [ :className |
		| class |
		class := Smalltalk at: className ifAbsent: [ nil ].
		(class notNil and: [ anObject isKindOf: class ]) ifTrue: [
			^ true ] ].
	^ false
]

{ #category : 'errors' }
PharoCompatibility class >> resumeDeprecationsDuring: aBlock [

	| deprecationClass |
	deprecationClass := Smalltalk at: #Deprecation ifAbsent: [ nil ].
	deprecationClass ifNil: [ ^ aBlock value ].
	^ [ aBlock value ]
		  on: deprecationClass
		  do: [ :deprecation | deprecation resume ]
]

{ #category : 'accessing' }
PharoCompatibility class >> runtimeVersionString [

	^ SystemVersion current version
]

{ #category : 'errors' }
PharoCompatibility class >> syntaxErrorNoticeClassName [

	| syntaxErrorClass |
	(Smalltalk at: #OCSyntaxErrorNotice ifAbsent: [ nil ]) ifNotNil: [
		:ocSyntaxErrorClass |
		ocSyntaxErrorClass name = #OCSyntaxErrorNotice ifTrue: [
			^ ocSyntaxErrorClass name asString ] ].
	syntaxErrorClass := self firstExistingGlobalFrom:
		                    #( RBSyntaxErrorNotice OCSyntaxErrorNotice
		                       SyntaxErrorNotification ).
	^ syntaxErrorClass
		  ifNil: [ 'SyntaxErrorNotification' ]
		  ifNotNil: [ syntaxErrorClass name asString ]
]

{ #category : 'errors' }
PharoCompatibility class >> syntaxNoticeFromException: anError [

	^ self
		  noticeFromException: anError
		  ifKindOfAnyNamed:
		  { self syntaxErrorNoticeClassName asSymbol }
]

{ #category : 'compatibility' }
PharoCompatibility class >> temporaryNamesForContext: aContext [

	^ aContext perform: (self currentMajorVersion >= 14
			   ifTrue: [ #temporaryVariableNames ]
			   ifFalse: [ #tempNames ])
]

{ #category : 'errors' }
PharoCompatibility class >> undeclaredVariableNodeFromException: anError [

	| ast notice |
	notice := self
		          noticeFromException: anError
		          ifKindOfAnyNamed:
		          #( OCUndeclaredVariableNotice OCUndeclaredVariableWarning ).
	(notice notNil and: [ notice respondsTo: #node ]) ifTrue: [
		^ notice node ].
	ast := self compilationAstFromException: anError.
	(ast notNil and: [ ast respondsTo: #variableNodes ]) ifFalse: [
		^ nil ].
	^ ast variableNodes
		  detect: [ :node |
			  | variable |
			  variable := node variable.
			  variable notNil and: [
				  (variable respondsTo: #isUndeclaredVariable) and: [
					  variable isUndeclaredVariable ] ] ]
		  ifNone: [ nil ]
]

{ #category : 'authoring' }
PharoCompatibility class >> withNonInteractiveAuthorNamed: authorName during: aBlock [

	| authorClass fullName |
	authorClass := Smalltalk at: #Author ifAbsent: [ nil ].
	authorClass ifNil: [ ^ aBlock value ].
	(authorClass respondsTo: #fullNamePerSe) ifFalse: [ ^ aBlock value ].
	fullName := authorClass perform: #fullNamePerSe.
	(fullName isNil or: [ fullName isEmpty ]) ifTrue: [
		(authorClass respondsTo: #useAuthor:during:) ifTrue: [
			^ authorClass
				  perform: #useAuthor:during:
				  with: authorName
				  with: aBlock ] ].
	^ aBlock value
]
