Class {
	#name : #H7Segment,
	#superclass : #H7Entity,
	#instVars : [
		'txt',
		'config'
	],
	#classInstVars : [
		'fieldCat'
	],
	#category : #'HL7-Core'
}

{ #category : #initialization }
H7Segment class >> fieldCat [
^fieldCat
]

{ #category : #initialization }
H7Segment class >> fields [

	^#()
]

{ #category : #initialization }
H7Segment class >> initialize [

	self allSubclassesDo: [ :cl | cl initialize].
		fieldCat := Dictionary newFromPairs: self fields 
]

{ #category : #'instance creation' }
H7Segment class >> on: aString config: aConf [

	^ self new on: aString config: aConf
]

{ #category : #'as yet unclassified' }
H7Segment class >> segmentFromLine: aSegLine [

	| code |
	code := ($| split: aSegLine) first.
	^ self allSubclasses detect: [ :c | c name = code ]ifNone:[Error signal: ('Not found segment:',code)]
]

{ #category : #'as yet unclassified' }
H7Segment >> inspectionString [

	<inspectorPresentationOrder: -10 title: 'nutool'>
	^ SpTablePresenter new
		  addColumn:
			  ((SpStringTableColumn title: 'Index' evaluated: #first) width: 15);
		  addColumn: (SpStringTableColumn title: 'Field' evaluated: #second);
		  addColumn: (SpStringTableColumn title: 'Value' evaluated: #last);
		  items: self parse;
		  yourself
]

{ #category : #'instance creation' }
H7Segment >> on: aString config: aConf [

	txt := aString.
	config := aConf .self parse
]

{ #category : #'instance creation' }
H7Segment >> parse [

	| pieces flds |
	pieces := txt splitOn: (config at: #fs).
	flds := self parseFields: pieces.
	^ flds
]

{ #category : #'instance creation' }
H7Segment >> parseField: piece [

	| tmp |
	tmp := piece splitOn: $^.
	tmp size = 1
		ifTrue: [ ^ tmp first ]
		ifFalse: [ ^ tmp ].
	^ tmp
]

{ #category : #'instance creation' }
H7Segment >> parseFields: pieces [

	| tmp fld |
	tmp := pieces allButFirst withIndexCollect: [ :each :index | 
		       fld := self class fieldCat at: index ifAbsent: [ '***' ].
		       Array with: index with: fld with: (self parseField: each) ].
	^ tmp 
]

{ #category : #accessing }
H7Segment >> txt [
^txt
]