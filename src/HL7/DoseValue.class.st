Class {
	#name : #DoseValue,
	#superclass : #Object,
	#instVars : [
		'h7',
		'valType',
		'idFld',
		'idNo',
		'id',
		'subId',
		'value',
		'unit',
		'uidFld',
		'uid',
		'uidType',
		'obsTime',
		'refRange',
		'alertFlags'
	],
	#category : #'HL7-Dose'
}

{ #category : #'instance creation' }
DoseValue >> from: anObxMsg [

	h7 := anObxMsg.
	valType := ((anObxMsg at: 2) at: 3) value.
	idFld := (anObxMsg at: 3) at: 3.
	idNo := idFld at: 1.
	id := idFld at: 2.
	subId := ((anObxMsg at: 4) at: 3) at: 1.
	value := ((anObxMsg at: 5) at: 3) value.
	unit := ((anObxMsg at: 6) at: 3) value.
	refRange := ((anObxMsg at: 7) at: 3)value.
	"HH: Above upper panic limits"
	alertFlags := ((anObxMsg at: 8) at: 3) value.
	obsTime := ((anObxMsg at: 14) at: 3) value.
	uidFld := (anObxMsg at: 17) at: 3.
	uid := uidFld at: 2.
	uidType := (uidFld at: 1) = '110180'
		           ifTrue: [ #Study ]
		           ifFalse: [ #Series ]
]

{ #category : #accessing }
DoseValue >> id [ ^id 
]

{ #category : #accessing }
DoseValue >> obsTime [
^obsTime 

]

{ #category : #printing }
DoseValue >> printOn: aStream [

	aStream << id << ': ' << value value asString << ' ' << unit value
	<< ' ' << alertFlags " << '('<< ' subId: ' << subId asString << ')'"
]

{ #category : #accessing }
DoseValue >> subId [ ^subId
]

{ #category : #accessing }
DoseValue >> uid [

	^ uid
]

{ #category : #accessing }
DoseValue >> uidType [ ^uidType 
]

{ #category : #accessing }
DoseValue >> unit [

	^ unit 
]

{ #category : #accessing }
DoseValue >> value [

	^ value
]
