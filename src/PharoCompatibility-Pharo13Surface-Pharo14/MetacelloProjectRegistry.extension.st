Extension { #name : 'MetacelloProjectRegistry' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
MetacelloProjectRegistry >> registrationForClassNamed: aClassName ifAbsent: absentBlock [

	^ self
		  registrationNamed: aClassName
		  ifPresent: [ :registration | registration ]
		  ifAbsent: absentBlock
]
