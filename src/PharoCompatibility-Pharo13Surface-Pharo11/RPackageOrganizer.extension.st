Extension { #name : 'RPackageOrganizer' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RPackageOrganizer >> ensurePackage: aPackageName [

	(self includesPackageNamed: aPackageName asSymbol) ifTrue: [
		^ self packageNamed: aPackageName asSymbol ].
	^ self ensureExistAndRegisterPackageNamed: aPackageName asSymbol
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RPackageOrganizer >> hasPackage: aPackageName [

	^ self includesPackageNamed: aPackageName asSymbol
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RPackageOrganizer >> packageNamed: aPackageName ifPresent: presentBlock [

	| package |
	package := self packageNamed: aPackageName ifAbsent: [ ^ nil ].
	^ presentBlock value: package
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RPackageOrganizer >> packageNamed: aPackageName ifAbsent: absentBlock ifPresent: presentBlock [

	| package |
	package := self packageNamed: aPackageName ifAbsent: [ ^ absentBlock value ].
	^ presentBlock value: package
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RPackageOrganizer >> packageNamed: aPackageName ifPresent: presentBlock ifAbsent: absentBlock [

	| package |
	package := self packageNamed: aPackageName ifAbsent: [ ^ absentBlock value ].
	^ presentBlock value: package
]

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo11' }
RPackageOrganizer >> removePackage: aPackageOrName [

	aPackageOrName isString ifTrue: [
		^ self unregisterPackageNamed: aPackageOrName asString ].
	aPackageOrName isSymbol ifTrue: [
		^ self unregisterPackageNamed: aPackageOrName asString ].
	^ self unregisterPackage: aPackageOrName
]
