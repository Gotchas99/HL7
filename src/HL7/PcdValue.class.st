Class {
	#name : #PcdValue,
	#superclass : #Object,
	#instVars : [
		'h7',
		'idNo',
		'id',
		'subId',
		'valType',
		'value',
		'unit',
		'eq'
	],
	#category : #'HL7-PCD'
}

{ #category : #'instance creation' }
PcdValue class >> from: anObxMsg [

	^ self new from: anObxMsg
]

{ #category : #accessing }
PcdValue >> eq [

	^ eq
]

{ #category : #'instance creation' }
PcdValue >> from: anObxMsg [

	| idFld  |
	h7 := anObxMsg.
	valType := (anObxMsg at: 2) at: 3.
	idFld := (anObxMsg at: 3) at: 3.
	idNo := idFld at: 1.
	id := idFld at: 2.
	subId := (anObxMsg at: 4) at: 3.
	value := (anObxMsg at: 5) at: 3.
	unit := (anObxMsg at: 6) at: 3.
	eq := (anObxMsg at: 18 ifAbsent: [ #( 0 0 nil ) ]) at: 3
]

{ #category : #accessing }
PcdValue >> id [

	^ id
]

{ #category : #accessing }
PcdValue >> idNo [

	^ idNo
]

{ #category : #accessing }
PcdValue >> nodeType [

	| ids |
	ids := $. split: (subId at: 1).
	ids second = '0' ifTrue: [ ^ #MDS ].
	ids third = '0' ifTrue: [ ^ #VMD ].
	ids fourth = '0' ifTrue: [ ^ #Chan ].^#Metric
]

{ #category : #printing }
PcdValue >> printOn: aStream [

	aStream << id

]

{ #category : #accessing }
PcdValue >> subId [

	^ subId
]

{ #category : #accessing }
PcdValue >> unit [

	^ unit
]

{ #category : #accessing }
PcdValue >> valType [

	^ valType
]

{ #category : #accessing }
PcdValue >> value [

	^ value
]
