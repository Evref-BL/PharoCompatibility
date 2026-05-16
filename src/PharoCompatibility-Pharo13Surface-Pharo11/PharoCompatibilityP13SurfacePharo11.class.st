"
Installer for the Pharo 13 API surface pieces that can be restored when code is loaded on Pharo 11.
"
Class {
	#name : 'PharoCompatibilityP13SurfacePharo11',
	#superclass : 'Object',
	#category : 'PharoCompatibility-Pharo13Surface-Pharo11-Surfaces',
	#package : 'PharoCompatibility-Pharo13Surface-Pharo11',
	#tag : 'Surfaces'
}

{ #category : 'class initialization' }
PharoCompatibilityP13SurfacePharo11 class >> initialize [

	self install
]

{ #category : 'installing' }
PharoCompatibilityP13SurfacePharo11 class >> install [

	PharoCompatibility installPharo13Surface
]

{ #category : 'accessing' }
PharoCompatibilityP13SurfacePharo11 class >> surfaceName [

	^ #Pharo13Surface
]
