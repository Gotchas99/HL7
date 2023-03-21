Class {
	#name : #NmMetric,
	#superclass : #Iso11073,
	#instVars : [
		'value',
		'unit',
		'unitNo'
	],
	#category : #'HL7-PCD'
}

{ #category : #'instance creation' }
NmMetric >> from: aPcd [

	super from: aPcd.
	value := aPcd value at: 1.
	unitNo := aPcd unit at: 1.
	aPcd unit isEmpty ifFalse: [ unit := aPcd unit at: 2 ]
]

{ #category : #testing }
NmMetric >> isMetric [ ^true
]

{ #category : #accessing }
NmMetric >> level [
^4
]

{ #category : #accessing }
NmMetric >> unit [

	^ unit
]

{ #category : #accessing }
NmMetric >> value [

	^ value
]
