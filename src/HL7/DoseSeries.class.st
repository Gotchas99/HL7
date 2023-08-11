Class {
	#name : #DoseSeries,
	#superclass : #DoseParts,
	#category : #'HL7-Dose'
}

{ #category : #printing }
DoseSeries >> acquisitionProtocol [

	^ (flds detect: [ :f | f id = 'ACQUISITION_PROTOCOL' ])value
]

{ #category : #'instance creation' }
DoseSeries >> from: coll [

	super from: coll
]

{ #category : #printing }
DoseSeries >> printOn: aStream [



	aStream << 'Series: ' << self acquisitionProtocol
]
