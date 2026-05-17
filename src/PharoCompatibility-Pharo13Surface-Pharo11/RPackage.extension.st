Extension { #name : 'RPackage' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RPackage >> isUndefined [

	^ false
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RPackage >> ensureTag: aTagName [

	^ self
		  classTagNamed: aTagName
		  ifAbsent: [ self addClassTag: aTagName ]
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RPackage >> hasTag: aTagName [

	^ self includesClassTagNamed: aTagName
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RPackage >> name [

	^ self packageName
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RPackage >> tagNames [

	| tagNames |
	tagNames := OrderedCollection new.
	self classTagCategoryNames do: [ :each |
		tagNames add: (self toTagName: each) asString ].
	self definedClasses do: [ :each |
		tagNames add: each packageTagName asString ].
	^ (tagNames reject: [ :each |
		   each isEmpty or: [
			   each = self name asString or: [ each = 'Uncategorized' ] ] ])
		  asSet asArray asSortedCollection asArray
]
