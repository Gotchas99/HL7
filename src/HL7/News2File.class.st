Class {
	#name : 'News2File',
	#superclass : 'Object',
	#instVars : [
		'service'
	],
	#classVars : [
		'Default'
	],
	#category : 'HL7-NEWS2',
	#package : 'HL7',
	#tag : 'NEWS2'
}

{ #category : 'accessing' }
News2File class >> default [

	^ Default ifNil:[Default:= self new]
]

{ #category : 'class initialization' }
News2File class >> initialize [

	SessionManager default registerUserClassNamed: self name
]

{ #category : 'accessing' }
News2File class >> reset [ 
self stop.Default:= nil
]

{ #category : 'start-stop' }
News2File class >> shutDown: quitting [
	"Our system shutDown hook"

	quitting ifTrue:[self stop].
]

{ #category : 'start-stop' }
News2File class >> start [
<example>
	Default ifNotNil: [ self stop ].
	self default start
]

{ #category : 'start-stop' }
News2File class >> startUp: resuming [
	"Our system startUp hook
	We do this using deferred startup actions to allow normal error handling."

	resuming ifTrue: [
		SessionManager default currentSession addDeferredStartupAction: [ 
			self start ] ]
]

{ #category : 'start-stop' }
News2File class >> stop [
<example>
	Default ifNotNil: [ Default stop ]
]

{ #category : 'accessing' }
News2File >> archiveFile: file toFolder: arkivFolder [

	| hl7text h7 timestamp date timestampStr dayFolder |
	hl7text := file contents.
	h7 := (H7Parser on: hl7text) parse.
	timestampStr := h7 msh msgTimestamp value.
	timestamp:=DateAndTime readYMDHMSfromDigits: timestampStr readStream.
	date := timestamp asDate.
	dayFolder:= (arkivFolder / date yyyymmdd)ensureCreateDirectory .
	dayFolder / file basename
		ifExists: [
			self traceCr: 'File exists in arkiv: ' , file pathString.
			file delete ]
		ifAbsent: [ :arkiv | file moveTo: dayFolder ]
]

{ #category : 'accessing' }
News2File >> folders [

^	Smalltalk os platformName = 'Win32'
		ifTrue: [ #( 'C:\Pharo\images\HL7 - 12\inFolder'
	              'P:\MTPHL7' ). ]
		ifFalse: [  ]
]

{ #category : 'testing' }
News2File >> isRunning [ 
^service isRunning
]

{ #category : 'accessing' }
News2File >> moveToInvalid: file folder: folder [

	| invalidFolder |
	invalidFolder := folder / 'invalid'.
	invalidFolder ensureCreateDirectory .
	invalidFolder / file basename
		ifExists: [
			self traceCr: 'File exists in invalid, deleting: ' , file basename.
			file delete ]
		ifAbsent: [ :newfilename | file moveTo: invalidFolder ]
]

{ #category : 'accessing' }
News2File >> processFolders [

	| folders |
	folders := self folders.

	folders do: [ :fld | self processOneFolder: fld ]
]

{ #category : 'accessing' }
News2File >> processOneFolder: aPathString [

	| folder arkivFolder fname file |
	folder := aPathString asFileReference.
	folder exists ifFalse: [
		Error signal: 'Folder är inte tillgänglig. Är P: uppkopplad?'.
		^ self ].
	arkivFolder := folder / 'arkiv'.
	arkivFolder ensureCreateDirectory.
	[
	fname := FileSystem disk store firstFileNameIn: aPathString asPath.
	fname isNotNil ] whileTrue: [
		file := folder / fname.
		[
		News2 new processHl7: file contents.
		self archiveFile: file toFolder: arkivFolder ]
			on: H7Invalid
			do: [ self moveToInvalid: file folder: folder ] ]
]

{ #category : 'accessing' }
News2File >> start [

	<script: 'self stop;start'>
	service := TKTParameterizableService new.
	service name: 'HL7 file watcher service'.
	"service onSetUpDo: [ Transcript show: 'File watcher started' ].
	service onTearDownDo: [ Transcript show: 'File watcher finished' ]."
	service step: [ self processFolders ].
	service stepDelay: 5 seconds.

	service start
]

{ #category : 'accessing' }
News2File >> stop [

	service stop.
]
