Class {
	#name : 'News2File',
	#superclass : 'Object',
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

	
	self environment
		at: #SessionManager
		ifPresent: [ :manager |
		manager default registerNetworkClassNamed: self name ]
		ifAbsent: [
			Smalltalk
				addToStartUpList: self;
				addToShutDownList: self ]
]

{ #category : 'accessing' }
News2File class >> reset [ 
self stop.Default:= nil
]

{ #category : 'accessing' }
News2File class >> start [
<example>
	Default ifNotNil: [ self stop ].
	self default start
]

{ #category : 'accessing' }
News2File class >> stop [
<example>
	Default ifNotNil: [ Default stop ]
]
