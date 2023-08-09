Class {
	#name : #OBR,
	#superclass : #H7Segment,
	#category : #'HL7-Core'
}

{ #category : #'field definition' }
OBR class >> fields [

	^ #( 2 'Placer Order Number' 3 'Filler Order Number (Accession no)'
	4 'Universal Service ID'
	     7 'Observation Date/Time' 8 'Observation End Date/Time'
	     20 'Filler Field 1 (Site ID)' 21 'Filler Field 2 (Modality)' )
]
