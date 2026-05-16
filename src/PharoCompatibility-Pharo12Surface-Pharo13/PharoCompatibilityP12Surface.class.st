"
Installer for the Pharo 12 API surface pieces that need restoration when code is loaded on Pharo 13 or newer.
"
Class {
	#name : 'PharoCompatibilityP12Surface',
	#superclass : 'Object',
	#category : 'PharoCompatibility-Pharo12Surface-Pharo13-Surfaces',
	#package : 'PharoCompatibility-Pharo12Surface-Pharo13',
	#tag : 'Surfaces'
}

{ #category : 'class initialization' }
PharoCompatibilityP12Surface class >> initialize [

	self install
]

{ #category : 'installing' }
PharoCompatibilityP12Surface class >> install [

	PharoCompatibility installPharo12Surface
]

{ #category : 'accessing' }
PharoCompatibilityP12Surface class >> surfaceName [

	^ #Pharo12Surface
]
