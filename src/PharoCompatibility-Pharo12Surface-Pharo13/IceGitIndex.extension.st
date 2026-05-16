Extension { #name : 'IceGitIndex' }

{ #category : '*PharoCompatibility-Pharo12Surface-Pharo13' }
IceGitIndex >> commitWithMessage: message andParents: parentCommits [

	^ PharoCompatibility
		  icebergCommandLineCommitModifiedFilePaths: modifiedFilePaths
		  repository: repository
		  message: message
		  parentCommits: parentCommits
]
