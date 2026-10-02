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

{ #category : 'class initialization' }
News2File class >> shutDown: quitting [
	"Our system shutDown hook"

	quitting ifTrue:[self stop].
]

{ #category : 'accessing' }
News2File class >> start [
<example>
	Default ifNotNil: [ self stop ].
	self default start
]

{ #category : 'class initialization' }
News2File class >> startUp: resuming [
	"Our system startUp hook
	We do this using deferred startup actions to allow normal error handling."

	resuming ifTrue: [
		SessionManager default currentSession addDeferredStartupAction: [ "	self managedServers do: [ :each | each start ] "
		self start	 ] ]
]

{ #category : 'accessing' }
News2File class >> stop [
<example>
	Default ifNotNil: [ Default stop ]
]

{ #category : 'accessing' }
News2File >> processFiles [

	|  folder |
	folder := 'C:\Pharo\images\HL7 - 12\inFolder' asFileReference.
	folder files do: [ :file | News2 new processHl7: file contents ]
]

{ #category : 'accessing' }
News2File >> start [

	service := TKTParameterizableService new.
	service name: 'HL7 watcher service'.
	service onSetUpDo: [ Transcript show: 'File watcher started' ].
	service onTearDownDo: [ Transcript show: 'File watcher finished' ].
	service step: [ self processFiles ].
 
	service start
]

{ #category : 'accessing' }
News2File >> stop [

	service stop.
]
