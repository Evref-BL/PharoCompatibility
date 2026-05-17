Extension { #name : 'ReClassRepackagingChange' }

{ #category : '*PharoCompatibility-Pharo13Surface-Pharo14' }
ReClassRepackagingChange >> generateChanges [

	((self changeClass packageOrganizer ensurePackage: packageName)
		 ensureTag: tagName)
		addClass: self changeClass
]
