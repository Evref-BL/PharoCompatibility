"
Installer for the Pharo 13 API surface pieces that can be restored when code is loaded on Pharo 14.
"
Class {
	#name : 'PharoCompatibilityP13Surface',
	#superclass : 'Object',
	#category : 'PharoCompatibility-Pharo13Surface-Pharo14-Surfaces',
	#package : 'PharoCompatibility-Pharo13Surface-Pharo14',
	#tag : 'Surfaces'
}

{ #category : 'class initialization' }
PharoCompatibilityP13Surface class >> initialize [

	self install
]

{ #category : 'installing' }
PharoCompatibilityP13Surface class >> install [

	PharoCompatibility installPharo13Surface
]

{ #category : 'accessing' }
PharoCompatibilityP13Surface class >> surfaceName [

	^ #Pharo13Surface
]
