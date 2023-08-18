Class {
	#name : #OBX,
	#superclass : #H7Segment,
	#category : #'HL7-Core'
}

{ #category : #'field definition' }
OBX class >> fields [

	^ #( 1 'Set ID – OBX' 2 'Value Type (TX=Text, CE=Code)'
	     3 'Observation Identifier' 4 'Observation Sub-Id'
	     5 'Observation Value' 6 'Units' 7 'Reference Range'
	     11 'Observ Result Status' 12 'Version Id' 14 'Date/Time of the Observation'
	     16 'Responsible Observer' 17 'Observation Method'
	     18 'Equipment Instance Identifier' )
]

{ #category : #printing }
OBX >> printOn: aStream [

	aStream << 'OBX: ' << (((self at: 3) at: 3) at: 2) << ': '
	<< ((self at: 5) at: 3) asString << ' '
	<< ((self at: 6) at: 3) asString << ' ('
	<< ((self at: 7) at: 3) asString << ')' "| tmp |
	tmp := comps reduce: [ :a :b | a , ' * ' , b ].
	aStream << tmp"

	"	tmp size = 1
		ifTrue: [ ^ tmp first ]
		ifFalse: [ ^ tmp ]."
]
