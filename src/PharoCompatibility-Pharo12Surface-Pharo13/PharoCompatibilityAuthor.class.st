"
Minimal Pharo 12 Author-compatible class for Pharo versions where Author was removed. It intentionally keeps only the small non-interactive protocol needed by tools that still ask for an author.
"
Class {
	#name : 'PharoCompatibilityAuthor',
	#superclass : 'Object',
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

	^ aString
]

{ #category : 'convenience' }
PharoCompatibilityAuthor class >> fullNamePerSe [

	^ ''
]

{ #category : 'class initialization' }
PharoCompatibilityAuthor class >> reset [

	^ self
]

{ #category : 'testing - support' }
PharoCompatibilityAuthor class >> useAuthor: authorName during: aBlock [

	^ aBlock value
]
