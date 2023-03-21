Class {
	#name : #PcdMessage,
	#superclass : #Object,
	#instVars : [
		'h7',
		'mds'
	],
	#category : #'HL7-PCD'
}

{ #category : #'instance creation' }
PcdMessage class >> from: aH7Msg [

	^self new from: aH7Msg

	
]

{ #category : #'instance creation' }
PcdMessage >> from: aH7Msg [

	| obxs vals  |
	aH7Msg isPCD ifFalse: [ self error: 'Not a PCD message' ].
	h7 := aH7Msg.
	obxs := h7 segments select: [ :seg | seg segType = 'OBX' ].
	vals := obxs collect: [ :o | PcdValue from: o ].
	mds := Iso11073 from: vals first.
	vals allButFirst do: [ :val | mds add: (Iso11073 from: val) ]
]

{ #category : #'instance creation' }
PcdMessage >> mds [ ^mds
]
