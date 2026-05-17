Extension { #name : 'ShiftClassBuilder' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ShiftClassBuilder >> classTraits: aValue [

	^ self classTraitComposition: aValue
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ShiftClassBuilder >> fillClassSideFromEnvironment: anEnvironment [

	| old |
	anEnvironment ifNil: [ ^ self ].
	old := anEnvironment at: name ifAbsent: [ ^ self ].
	self classSlots: old class slots
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ShiftClassBuilder >> fillInstanceSideFromClass: aClass [

	self buildEnvironment: ShSmalltalkGlobalsEnvironment new.
	self name: aClass name.
	self slots: aClass slots.
	self traitComposition: aClass traitComposition.
	self package: aClass packageName.
	aClass packageTagName ~= 'Uncategorized' ifTrue: [
		self tag: aClass packageTagName ].
	self superclass: aClass superclass.
	self layoutClass: aClass classLayout class.
	self sharedVariables: aClass classVariables.
	self sharedPoolsCollectionOfSymbols:
		(aClass sharedPools collect: [ :each | each name asSymbol ]) asArray
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ShiftClassBuilder >> install [

	^ ShiftClassInstaller new makeWithBuilder: self
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ShiftClassBuilder >> layout: aLayoutClass [

	^ self layoutClass: aLayoutClass
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ShiftClassBuilder >> package: aPackageName [

	(Smalltalk at: #PackageOrganizer ifAbsent: [ RPackageOrganizer ])
		default ensurePackage: aPackageName.
	self category: aPackageName asString
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ShiftClassBuilder >> sharedPools: sharedPoolClasses [

	^ self sharedPoolsCollectionOfSymbols:
		  (sharedPoolClasses collect: [ :each | each name asSymbol ]) asArray
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ShiftClassBuilder >> tag: aTagName [

	| package |
	package := (Smalltalk
		            at: #PackageOrganizer
		            ifAbsent: [ RPackageOrganizer ]) default ensurePackage:
		           category.
	package ensureTag: aTagName.
	self category: category asString , '-' , aTagName asString
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ShiftClassBuilder >> traits: aValue [

	^ self traitComposition: aValue
]
