Class {
	#name : 'NmMDS',
	#superclass : 'Iso11073',
	#instVars : [
		'eq'
	],
	#category : 'HL7-PCD',
	#package : 'HL7',
	#tag : 'PCD'
}

{ #category : 'instance creation' }
NmMDS >> from: aPcd [
	super from: aPcd.
	"eq := aPcd eq at: 1"
]

{ #category : 'accessing' }
NmMDS >> level [

	^ 1
]
