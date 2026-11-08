Class {
	#name : 'FHIR',
	#superclass : 'Object',
	#category : 'HL7-FHIR',
	#package : 'HL7',
	#tag : 'FHIR'
}

{ #category : 'converting' }
FHIR >> asDictionary [

	| dict |
	dict:= Dictionary new.
	dict at:#resourceType put: self resourceType .
	^dict
]

{ #category : 'converting' }
FHIR >> asJSON [

	| dict |
	dict := self asDictionary.
	^ NeoJSONWriter toStringPretty: dict
]

{ #category : 'initialization' }
FHIR >> initialize [

	super initialize.
]

{ #category : 'as yet unclassified' }
FHIR >> resourceType [
	self subclassResponsibility 
]
