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
	surfaceClass := Smalltalk
		                at: #PharoCompatibilityP12Surface
		                ifAbsent: [ nil ].
	surfaceClass ifNotNil: [ surfaceClass install ]
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

{ #category : 'testing' }
PharoCompatibility class >> isPharo13OrLater [

	^ self currentMajorVersion >= 13
]

{ #category : 'accessing' }
PharoCompatibility class >> loadedSurfaces [

	| surfaces |
	surfaces := OrderedCollection new.
	(Smalltalk includesKey: #PharoCompatibilityP12Surface) ifTrue: [
		surfaces add: #Pharo12Surface ].
	^ surfaces asArray
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
	syntaxErrorClass := self firstExistingGlobalFrom:
		                    #( OCSyntaxErrorNotice RBSyntaxErrorNotice
		                       SyntaxErrorNotification ).
	^ syntaxErrorClass
		  ifNil: [ 'SyntaxErrorNotification' ]
		  ifNotNil: [ syntaxErrorClass name asString ]
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
