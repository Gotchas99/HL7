Class {
	#name : #H7Field,
	#superclass : #Object,
	#instVars : [
		'txt',
		'comps'
	],
	#category : #'HL7-Core'
}

{ #category : #'instance creation' }
H7Field class >> on: aString [

	^ self new on: aString
]

{ #category : #accessing }
H7Field >> at: anIndex [

	^ comps at: anIndex


]

{ #category : #accessing }
H7Field >> at: anIndex  ifAbsent: aBlock [

	^ comps at: anIndex  ifAbsent: aBlock
]

{ #category : #accessing }
H7Field >> first [
^self at:1
]

{ #category : #testing }
H7Field >> isEmpty [

	^ comps isEmpty or: [ comps first isEmpty ]
]

{ #category : #testing }
H7Field >> isPCD [

	| issuer |
	issuer := self at: 2.
	^ issuer = 'IHE PCD' or: [ ^ issuer = 'IHE_PCD' ] 
]

{ #category : #accessing }
H7Field >> last [

	^ self at: self size
]

{ #category : #'instance creation' }
H7Field >> on: aString [

	txt := aString trimmed.
	comps := txt trimmed splitOn: $^
]

{ #category : #printing }
H7Field >> printOn: aStream [

	| tmp |
	tmp := comps reduce:[:a :b| a , ' * ',b]..
	aStream << tmp
	"	tmp size = 1
		ifTrue: [ ^ tmp first ]
		ifFalse: [ ^ tmp ]."
]

{ #category : #accessing }
H7Field >> value [

	^ comps  last
]
