Class {
	#name : #MSH,
	#superclass : #H7Segment,
	#instVars : [
		'fs'
	],
	#category : #'HL7-Core'
}

{ #category : #'field definition' }
MSH class >> fields [

	^ #( 1 'Field separator' 2 'Encoding characters'
	     3 'Sending Application' 
	4 'Sending Facility'
	5 'Receiving Application'
	6  'Receiving Facility'
	7 'Date/Time of Message'
	     9 'Message Type' 10 'Message Control Id' 11 'Processing Id' 12 'Version Id' 18 'Character Set')
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
