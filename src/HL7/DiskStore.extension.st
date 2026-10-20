Extension { #name : 'DiskStore' }

{ #category : '*HL7' }
DiskStore >> firstFileNameIn: aPath [

	| pathString openDir dirPointer entryData entryName |
	pathString := File encodePathString: (self stringFromPath: aPath).
	(self isDirectory: aPath) ifFalse: [
		^ self signalDirectoryDoesNotExist: aPath ].

	openDir := File primOpendir: pathString.
	openDir ifNil: [ ^ nil ]. 
	dirPointer := openDir at: 3.
	entryData := openDir.
	[
	[ entryData isNotNil ] whileTrue: [
		entryName := entryData first.
		entryData at: 1 put: (File decodePathString: entryName).
		(File isFile: (aPath / entryData first) pathString allButFirst)
			ifTrue: [ ^ entryData first ].
		entryData := File primReaddir: dirPointer ] ] ensure: [
		File primClosedir: dirPointer ].
	^nil.
]
