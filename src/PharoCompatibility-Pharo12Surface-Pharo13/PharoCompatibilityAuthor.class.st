"
Minimal Pharo 12 Author-compatible class for Pharo versions where Author was removed. It intentionally keeps only the small non-interactive protocol needed by tools that still ask for an author.
"
Class {
	#name : 'PharoCompatibilityAuthor',
	#superclass : 'Object',
	#classInstVars : [
		'CurrentFullName'
	],
	#category : 'PharoCompatibility-Pharo12Surface-Pharo13-Surfaces',
	#package : 'PharoCompatibility-Pharo12Surface-Pharo13',
	#tag : 'Surfaces'
}

{ #category : 'convenience' }
PharoCompatibilityAuthor class >> fullName [

	^ self fullNamePerSe
]

{ #category : 'convenience' }
PharoCompatibilityAuthor class >> fullName: aString [

	CurrentFullName := aString ifNil: [ '' ].
	^ CurrentFullName
]

{ #category : 'convenience' }
PharoCompatibilityAuthor class >> fullNamePerSe [

	^ CurrentFullName ifNil: [ '' ]
]

{ #category : 'class initialization' }
PharoCompatibilityAuthor class >> reset [

	CurrentFullName := ''.
	^ self
]

{ #category : 'testing - support' }
PharoCompatibilityAuthor class >> useAuthor: authorName during: aBlock [

	| previousFullName |
	previousFullName := self fullNamePerSe.
	self fullName: authorName.
	^ [ aBlock value ] ensure: [ self fullName: previousFullName ]
]
