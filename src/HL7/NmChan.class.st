Class {
	#name : #NmChan,
	#superclass : #Iso11073,
	#instVars : [
		'eq'
	],
	#category : #'HL7-PCD'
}

{ #category : #'instance creation' }
NmChan >> from: aPcd [
	super from: aPcd.
	"eq := aPcd eq at: 1"
]

{ #category : #accessing }
NmChan >> level [

	^ 3
]
