Extension { #name : 'RBMoveClassTransformation' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RBMoveClassTransformation class >> move: aClassName toPackage: aPackageName [

	^ self
		  move: aClassName
		  to: aPackageName asString
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RBMoveClassTransformation class >> move: aClassName toPackage: aPackageName inTag: aTagName [

	^ self
		  move: aClassName
		  to: aPackageName asString , '-' , aTagName asString
]
