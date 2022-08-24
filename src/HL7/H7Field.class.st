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
