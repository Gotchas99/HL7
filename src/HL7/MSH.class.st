Class {
	#name : #MSH,
	#superclass : #H7Segment,
	#category : #'HL7-Core'
}

{ #category : #'field definition' }
MSH class >> fields [

	^ #( 1 'Field separator' 2 'Encoding characters'
	     3 'Sending Application' 4 'Sending Facility' 5 'Receiving Application'
	     6 'Receiving Facility' 7 'Date/Time of Message'
	     9 'Message Type' 10 'Message Control Id' 11 'Processing Id'
	     12 'Version Id' 15 'Accept Acknowledgement Type'
	     16 'Application Acknowledgement Type'
	     18 'Character Set' 21 'Message Profile Identifier')
]

{ #category : #testing }
MSH >> isPCD [

	| fld |
	fld := (self at: 21 ifAbsent: [ ^ false ]) third.
	^fld isPCD
]

{ #category : #testing }
MSH >> msgType [

	^ (self at: 9) last at: 3
]

{ #category : #parsing }
MSH >> parseFields: pieces [

	| tmp fsep fld |
	tmp := super parseFields: pieces.
	fsep := { 
		        1.
		        'Field separator'.
		        (txt at: 4) asString }.
	tmp addFirst: fsep.
	tmp := tmp withIndexCollect: [ :each :index | 
		fld := self class fieldCat at: index ifAbsent: [ '***' ].
		       Array with: index with: fld with: each third ].
	^ tmp
]

{ #category : #printing }
MSH >> printOn: aStream [

	aStream << 'MSH: ' <<self trigger
]

{ #category : #testing }
MSH >> profileOid [

	| fld |
	fld := (self at: 21) third.
	^ fld at:3
]

{ #category : #testing }
MSH >> sendingApplication [

	^ (self at: 3)  last at:1
]

{ #category : #testing }
MSH >> trigger [

	| fld |
	fld := (self at: 9) third.
	^ (fld at: 1), '^',(fld at: 2)
]
