Extension { #name : 'Semaphore' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
Semaphore >> waitTimeoutMilliseconds: millisecondCount [

	^ self waitTimeoutMSecs: millisecondCount
]
