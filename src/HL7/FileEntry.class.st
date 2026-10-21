Class {
	#name : 'FileEntry',
	#superclass : 'Object',
	#instVars : [
		'entryData'
	],
	#category : 'HL7-NEWS2',
	#package : 'HL7',
	#tag : 'NEWS2'
}

{ #category : 'as yet unclassified' }
FileEntry class >> entryData:aByteArray [ 
^self new entryData:aByteArray 
]

{ #category : 'as yet unclassified' }
FileEntry class >> fileEntriesFor: aPathString [

	| entries openDir dirPointer entryData |
	entries := OrderedCollection new.
	openDir := File primOpendir: aPathString.
	openDir ifNil: [ self halt ].
	dirPointer := openDir at: 3.
	entryData := openDir.
	[
	[ entryData isNotNil ] whileTrue: [
		entries add: (self entryData: entryData).
		"entryName := entryData first."
		"entryData first asString."
		"entryData at: 1 put: (File decodePathString: entryName)."
		"(File isFile: (aPath / entryData first) pathString allButFirst) ifTrue: [ ^ entryData first ]."
		entryData := File primReaddir: dirPointer ] ] ensure: [
		File primClosedir: dirPointer ].
	^ entries
]

{ #category : 'as yet unclassified' }
FileEntry class >> filesFor: aPathString [

	| entries files |
	entries := self fileEntriesFor: aPathString.
	files := entries select: #isFile.
	^files
]

{ #category : 'as yet unclassified' }
FileEntry class >> oldestFileFor: aPathString [

	|  files |
	
	files := (self filesFor: aPathString ).
	files isEmpty ifTrue:[^nil].
	^files sorted first 
]

{ #category : 'as yet unclassified' }
FileEntry >> <= anEntry [

	^self creationDate <= anEntry creationDate 
]

{ #category : 'as yet unclassified' }
FileEntry >> creationDate [

	| attr createTimestamp |
	attr := (entryData second ).
	createTimestamp:= attr at: 12.
^	DateAndTime fromInternalTime: createTimestamp
]

{ #category : 'accessing' }
FileEntry >> entryData: aByteArray [
entryData:= aByteArray 
]

{ #category : 'accessing' }
FileEntry >> fileName [ 
^entryData first asString.
]

{ #category : 'accessing' }
FileEntry >> isFile [

	| fileAttr res masks s_ifmt s_ifdir |
	masks := File primFileMasks.
	s_ifmt := masks at: 1.
	s_ifdir := masks at: 6.

	fileAttr := entryData second at: 2.
	res := (fileAttr bitAnd: s_ifmt) ~= s_ifdir.
	^ res
]
