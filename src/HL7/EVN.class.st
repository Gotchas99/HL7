Class {
	#name : #EVN,
	#superclass : #H7Segment,
	#category : #'HL7-Core'
}

{ #category : #'field definition' }
EVN class >> fields [

	^ #( 1 'Event Type Code' 2 'Recorded Date/Time' 3 'Date/Time Planned Event' 4 'Event Reason Code' 5 'Operator ID' 6 'Event Occurred' 7 'Event Facitlity')
]
