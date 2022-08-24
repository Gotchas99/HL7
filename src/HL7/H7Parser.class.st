Class {
	#name : #H7Parser,
	#superclass : #Object,
	#instVars : [
		'txt'
	],
	#category : #'HL7-Core'
}

{ #category : #'instance creation' }
H7Parser class >> on: aString [
^self new on: aString
]

{ #category : #'instance creation' }
H7Parser >> extractConfig [

	| seps |
	(txt beginsWith: 'MSH') ifFalse: [ 
		Error signal: 'Invalid message. Doesn''t start with MSH' ].
	seps := Dictionary new.
	seps at: #fs put: (txt at: 4).
	seps at: #compSep put: (txt at: 5).
	seps at: #repSep put: (txt at: 6).
	seps at: #escape put: (txt at: 7).
	seps at: #subCompSep put: (txt at: 8).
	^ seps
]

{ #category : #'instance creation' }
H7Parser >> on: aString [

	txt := aString trimmed
]

{ #category : #'instance creation' }
H7Parser >> parse [

	| segs conf |
	conf := self extractConfig.
	segs := txt lines collect: [ :segLine | 
		        | segType |
		        segType := H7Segment segmentFromLine: segLine.
		        segType on: segLine config: conf ].
	^ H7Message new segs: segs
]
