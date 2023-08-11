Class {
	#name : #DoseStudy,
	#superclass : #DoseParts,
	#instVars : [
		'accNo',
		'descr',
		'startTime',
		'endTime',
		'modality',
		'station'
	],
	#category : #'HL7-Dose'
}

{ #category : #adding }
DoseStudy >> addFromOBR: anObrMsg [

	accNo := ((anObrMsg at: 3) at: 3) value.
	descr := ((anObrMsg at: 4) at: 3) value.
	startTime := DateAndTime readYMDHMSfromDigits: ((anObrMsg at: 7) at: 3) value readStream.
	endTime := DateAndTime readYMDHMSfromDigits: ((anObrMsg at: 8) at: 3) value readStream.
	"station := ((anObrMsg at: 21) at: 3) at:1."
	modality := ((anObrMsg at: 21) at: 3) value
]

{ #category : #'instance creation' }
DoseStudy >> from: coll [
super from: coll
]

{ #category : #printing }
DoseStudy >> printOn: aStream [

	aStream << 'Study: ' << descr << ' (' << accNo asString << ')' 
]
