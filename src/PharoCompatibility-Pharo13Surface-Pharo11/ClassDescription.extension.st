Extension { #name : 'ClassDescription' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ClassDescription >> comment [

	^ self instanceSide organization classComment
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ClassDescription >> packageName [

	^ self package
		  ifNil: [ '' ]
		  ifNotNil: [ :aPackage | aPackage name ]
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
ClassDescription >> packageTagName [

	| category package tagName |
	self isMeta ifTrue: [ ^ self instanceSide packageTagName ].
	package := self package ifNil: [ ^ '' ].
	category := self category ifNil: [ ^ '' ].
	tagName := package toTagName: category.
	tagName asString = package name asString ifTrue: [ ^ 'Uncategorized' ].
	^ tagName ifNil: [ '' ]
]
