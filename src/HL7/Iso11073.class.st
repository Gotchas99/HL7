Class {
	#name : #Iso11073,
	#superclass : #Object,
	#instVars : [
		'idNo',
		'id',
		'subId',
		'valType',
		'nodes'
	],
	#category : #'HL7-PCD'
}

{ #category : #'instance creation' }
Iso11073 class >> from: aPcd [

	| className item |
	className := 'Nm' , aPcd nodeType.
	item:=(Smalltalk classNamed: className )new.
	^(item from:aPcd)
]

{ #category : #adding }
Iso11073 >> add: aNode [

	| p |
	subId = aNode parentId
		ifTrue: [ nodes add: aNode ]
		ifFalse: [  
			p := self getNode: aNode parentId.
			p add: aNode ]
]

{ #category : #'instance creation' }
Iso11073 >> from: aPcd [

	idNo := aPcd idNo asInteger.
	id := aPcd id.
	subId := aPcd subId at: 1.
	valType := aPcd valType at: 1
]

{ #category : #accessing }
Iso11073 >> getNode: aSubId [

	| res |
	subId = aSubId ifTrue: [ ^ self ].
	nodes ifEmpty: [ ^ nil ]. 
	res := nodes
		       collect: [ :n | n getNode: aSubId ]
		       thenReject: [ :n | n isNil ].
	^ res ifEmpty:   [nil ] ifNotEmpty: [  res first ]
]

{ #category : #accessing }
Iso11073 >> idNo [

	^ idNo 
]

{ #category : #initialization }
Iso11073 >> initialize [ 
nodes:= OrderedCollection new.
]

{ #category : #testing }
Iso11073 >> isMetric [
^false
]

{ #category : #accessing }
Iso11073 >> level [
self subclassResponsibility 
]

{ #category : #accessing }
Iso11073 >> name [
^id allButFirst:4
]

{ #category : #accessing }
Iso11073 >> nodes [
^nodes
]

{ #category : #accessing }
Iso11073 >> parentId [

	| ids tmp |
	ids := $. split: subId.
	ids at: self level put: '0'.
	tmp := $. join: ids.
	^ tmp
]

{ #category : #printing }
Iso11073 >> printOn: aStream [

	"self className allButFirst: 2"

	aStream << (self name) << '(' << subId << ')'
]

{ #category : #accessing }
Iso11073 >> subId [ ^subId 
]

{ #category : #accessing }
Iso11073 >> unit [

	^ ''
]

{ #category : #accessing }
Iso11073 >> value [ ^''
]
