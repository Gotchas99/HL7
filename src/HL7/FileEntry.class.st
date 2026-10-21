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

	| entries openDir  dirPointer entryData |
	entries := OrderedCollection new.
	openDir := File primOpendir: aPathString.
	openDir ifNil: [ self halt ].
	dirPointer := openDir at: 3.
	entryData := openDir.
	[
	[ entryData isNotNil ] whileTrue: [
		entries add: (self entryData:entryData).
		"entryName := entryData first."
		"entryData first asString."
		"entryData at: 1 put: (File decodePathString: entryName)."
		"(File isFile: (aPath / entryData first) pathString allButFirst) ifTrue: [ ^ entryData first ]."
		entryData := File primReaddir: dirPointer ] ] ensure: [
		File primClosedir: dirPointer ].
	^entries
]

{ #category : 'accessing' }
FileEntry >> entryData: aByteArray [
entryData:= aByteArray 
]
