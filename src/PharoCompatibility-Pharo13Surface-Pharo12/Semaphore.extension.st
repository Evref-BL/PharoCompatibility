Extension { #name : 'Semaphore' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo12' }
Semaphore >> waitTimeoutMilliseconds: millisecondCount [

	^ self waitTimeoutMSecs: millisecondCount
]
