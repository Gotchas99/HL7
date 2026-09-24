Class {
	#name : 'H7MllpTransceiver',
	#superclass : 'Object',
	#instVars : [
		'serverSocket',
		'process',
		'clientStream',
		'endMarker',
		'startMarker'
	],
	#category : 'HL7-MLLP',
	#package : 'HL7',
	#tag : 'MLLP'
}

{ #category : 'as yet unclassified' }
H7MllpTransceiver class >> stopAllServers [

	self allInstances do:[:srv|srv stopServer]
]

{ #category : 'accessing' }
H7MllpTransceiver >> acceptWaitTimeout [
	"How many seconds to wait for a server socket listening for an accept ?"

	^ 300
]

{ #category : 'sender' }
H7MllpTransceiver >> connect [

	clientStream ifNotNil: [ self disconnect ].
	clientStream := SocketStream
		                openConnectionToHost: #[ 127 0 0 1 ]
		                port: self port
		                timeout: 2
]

{ #category : 'sender' }
H7MllpTransceiver >> disconnect [

	clientStream ifNotNil: [
		clientStream close.
		clientStream := nil ]
]

{ #category : 'as yet unclassified' }
H7MllpTransceiver >> executeOneRequestResponseOn: stream [
	"[0x0B] MSA|AA|... [0x1C][0x0D]"

	| msg |
	self traceCr: 'starting to receive message'.
	"	msg := stream upToAll: endMarker."
	msg := self receiveMessage: stream.
	msg inspect.
	self traceCr: 'Message received'.
	stream << startMarker << 'MSA|AA|' << endMarker.
	stream flush.
	self traceCr: 'ACK sent'
]

{ #category : 'initialization' }
H7MllpTransceiver >> initialize [

startMarker :=String fromByteArray: #[ 11].
	endMarker := String fromByteArray: #[ 28 13 ]
]

{ #category : 'connection' }
H7MllpTransceiver >> initializeServerSocket [
	"Set up a new server socket and listen on it"

	serverSocket := Socket newTCP  listenOn:self  port backlogSize: 5
]

{ #category : 'testing' }
H7MllpTransceiver >> isRunning [
	"Return true when I am running"

	^  process isNotNil and: [  serverSocket isNotNil ]
]

{ #category : 'connection' }
H7MllpTransceiver >> listenLoop [
	"We create a listening Socket, then wait for a connection.
	After each connection we also check that the listening Socket is still valid
	- if not we just make a recursive call to this method to start over."

	self initializeServerSocket.
	[ 
	[
	serverSocket isValid ifFalse: [ "will trigger #ifCurtailed: block and destroy socket"
		^ self listenLoop ].
	self serveConnectionOn: serverSocket ] repeat ] ifCurtailed: [
		self releaseServerSocket ]
]

{ #category : 'accessing' }
H7MllpTransceiver >> port [ ^2575
]

{ #category : 'sender' }
H7MllpTransceiver >> receiveAck [
	"[0x0B] MSA|AA|... [0x1C][0x0D]"

	|  msg |
		msg := clientStream upToAll: endMarker.
	msg inspect
]

{ #category : 'sender' }
H7MllpTransceiver >> receiveMessage: anInStream [

	| msg byte |
	msg := ByteArray streamContents: [ :s |
		       anInStream atEnd ifTrue: [ Error signal: 'stream är stängd' ].
		       [
		       byte := anInStream next.
		       self
			       trace: byte;
			       trace: ' '.
		       		       byte = endMarker first asciiValue ] whileFalse:[s << byte.] ].
	byte := anInStream next.
	byte = endMarker last asciiValue ifFalse: [
		Error signal: 'fel tecken efter stop marker' ].
	self traceCr: msg.
	msg inspect.
	^ msg  allButFirst asString.
]

{ #category : 'connection' }
H7MllpTransceiver >> releaseServerSocket [
	"Release our server socket"
	| address port |
	serverSocket ifNil: [ ^ self ].
	address := [ serverSocket address ]
		           on: Error
		           do: [ nil ].
	port := [ serverSocket port ]
		        on: Error
		        do: [ nil ].
	(Delay forMilliseconds: 10) wait.
	serverSocket destroy.
	serverSocket := nil.
	"self logServerSocketReleasedAddress: address port: port"
]

{ #category : 'sender' }
H7MllpTransceiver >> send: aMsg [
	"[0x0B] MSA|AA|... [0x1C][0x0D]"
| newMsg |
newMsg:= aMsg copyReplaceAll: String crlf with:  String cr.
	clientStream << startMarker << newMsg << endMarker.
	clientStream flush.
	self receiveAck
]

{ #category : 'connection' }
H7MllpTransceiver >> serveConnectionOn: listeningSocket [
	"We wait up to acceptWaitTimeout seconds for an incoming connection.
	If we get one we wrap it in a SocketStream and #executeOneRequestResponseOn: on it.
	We do not fork a worker thread/process but stay in the current one for just one request/response cycle."

	| stream socket |
	socket := listeningSocket waitForAcceptFor: self acceptWaitTimeout.
	socket ifNil: [ ^ self "noteAcceptWaitTimedOut" ].
	stream := self socketStreamOn: socket.
	[[ "[	self withDynamicVariablesDo: " "]" self serveStream: stream ] ensure: [ self traceCr:'logConnectionClosed'.
		stream close ]]
		ifCurtailed: [ socket destroy ]
]

{ #category : 'as yet unclassified' }
H7MllpTransceiver >> serveStream: stream [

 [ self executeOneRequestResponseOn: stream ] repeat 
]

{ #category : 'accessing' }
H7MllpTransceiver >> serverProcessName [

	^ String streamContents: [ :stream |
		  stream
			  nextPutAll: self class name;
			  nextPutAll: ' MLLP port ';
			  print: self port.
		  "self serverId ifNotNil: [ :id |
			  stream
				  space;
				  << id ].
		  self route ifNotNil: [ :id |
			  stream
				  space;
				  << id ]" ]
]

{ #category : 'connection' }
H7MllpTransceiver >> socketStreamOn: socket [
	"self logConnectionAccepted: socket."

	| stream |
	stream := SocketStream on: socket.
	stream
		binary;
		shouldSignal: true;
		autoFlush: false.	
	^stream
]

{ #category : 'connection' }
H7MllpTransceiver >> startListeningServer [

	process := [ [ self listenLoop ] repeat ]
		           forkAt: Processor highIOPriority
		           named: self serverProcessName
]

{ #category : 'connection' }
H7MllpTransceiver >> startReceivingServer [

self flag:'incomplete'.
	process := [ [ self listenLoop ] repeat ]
		           forkAt: Processor highIOPriority
		           named: self serverProcessName
]

{ #category : 'connection' }
H7MllpTransceiver >> stopServer [
	"Stop me. I will stop listening on my port for incoming connections.
	Does nothing when I am not running"

	"self isRunning ifFalse: [ ^ self ]."

	process ifNotNil: [
		process terminate.
		process := nil ]. 
	serverSocket ifNotNil: [ 
		serverSocket destroy.
		serverSocket := nil ].
	"self closeDelegate.
	self logStopped"
]
