Class {
	#name : #DoseMessage,
	#superclass : #Object,
	#instVars : [
		'h7',
		'subIds',
		'study',
		'series',
		'alerts'
	],
	#category : #'HL7-Dose'
}

{ #category : #'instance creation' }
DoseMessage >> alertsFrom: dict [

	^(dict at:'')collect:[:a| DoseAlert new from:a]
]

{ #category : #'instance creation' }
DoseMessage >> from: aH7Msg [

	| obxs vals |
	aH7Msg sendingApplication = 'TQMDOSE' ifFalse: [ 
		self error: 'Not a Dose message' ].
	h7 := aH7Msg.
	obxs := h7 segments select: [ :seg | seg segType = 'OBX' ].
	vals := obxs collect: [ :o | DoseValue new from: o ].
	subIds := Dictionary new.
	vals do: [ :v | 
		| arr |
		arr := subIds at: v subId ifAbsentPut: OrderedCollection new.
		arr add: v ].
		self halt.
	study :=self studyFrom: subIds  .
	study addFromOBR: ( h7 segments detect: [ :seg | seg segType = 'OBR' ]).
	series:=self seriesFrom: subIds.
	alerts :=self alertsFrom: subIds .
	self inspect
]

{ #category : #'instance creation' }
DoseMessage >> seriesFrom: dict [

	| seriesDict |
	seriesDict := dict copy.
	seriesDict removeKey: '0'.
	seriesDict removeKey: '' ifAbsent: [ nil ].
	^ (seriesDict collect: [ :s | DoseSeries new from: s ])values
]

{ #category : #'instance creation' }
DoseMessage >> studyFrom: dict [

	^ DoseStudy new from: (subIds at: '0') 
]
