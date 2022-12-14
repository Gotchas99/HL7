Class {
	#name : #PID,
	#superclass : #H7Segment,
	#category : #'HL7-Core'
}

{ #category : #'field definition' }
PID class >> fields [

	^ #( 1 'Set ID' 2 'Patient ID' 3 'Patient Identifier List'
	     5 'Patient Name' 7 'Date/Time of Birth' 8 'Administrative Sex'
	     9 'Patient Alias' 11 'Patient Address' 13 'Phone Number – Home'
	     16 'Marital Status' 23 'Birth Place' 29 'Patient Death Date and Time' 31 'Identity Unknown Indicator')
]
