Extension { #name : 'OCCodeError' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
OCCodeError >> pharoCompatibilitySyntaxNotice [

	^ self notice
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
OCCodeError >> pharoCompatibilityUndeclaredVariableNode [

	^ self notice ifNotNil: [ :syntaxNotice |
		syntaxNotice pharoCompatibilityUndeclaredVariableNode ]
]
