Class {
	#name : 'NTE',
	#superclass : 'H7Segment',
	#category : 'HL7-Core',
	#package : 'HL7',
	#tag : 'Core'
}

{ #category : 'field definition' }
NTE class >> fields [

	^ #(  )
]

{ #category : 'printing' }
NTE >> printOn: aStream [

	aStream << 'NTE (Note)'
]
