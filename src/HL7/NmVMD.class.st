Class {
	#name : #NmVMD,
	#superclass : #Iso11073,
	#instVars : [
		'eq'
	],
	#category : #'HL7-PCD'
}

{ #category : #'instance creation' }
NmVMD >> from: aPcd [
	super from: aPcd.
	eq := aPcd eq at: 1
]

{ #category : #accessing }
NmVMD >> level [

	^ 2
]
