Class {
	#name : 'FhirResource',
	#superclass : 'Object',
	#category : 'HL7-FHIR',
	#package : 'HL7',
	#tag : 'FHIR'
}

{ #category : 'converting' }
FhirResource >> asDictionary [

	| dict |
	dict:= Dictionary new.
	dict at:#resourceType put: self resourceType .
	^dict
]

{ #category : 'converting' }
FhirResource >> asJSON [

	| dict |
	dict := self asDictionary.
	^ NeoJSONWriter toStringPretty: dict
]

{ #category : 'initialization' }
FhirResource >> initialize [

	super initialize.
]

{ #category : 'accessing' }
FhirResource >> resourceType [

	"self subclassResponsibility"
	^self class name allButFirst:4.
]
