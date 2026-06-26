Extension { #name : 'OCCodeError' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo13' }
OCCodeError >> pharoCompatibilitySyntaxNotice [

	^ self notice
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo13' }
OCCodeError >> pharoCompatibilityUndeclaredVariableNode [

	^ self notice ifNotNil: [ :syntaxNotice |
		syntaxNotice pharoCompatibilityUndeclaredVariableNode ]
]
