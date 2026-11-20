Class {
	#name : 'FhirLocation',
	#superclass : 'FhirResource',
	#instVars : [
		'name',
		'alias',
		'hsaid'
	],
	#category : 'HL7-FHIR',
	#package : 'HL7',
	#tag : 'FHIR'
}

{ #category : 'accessing' }
FhirLocation >> alias [

	^ alias
]

{ #category : 'accessing' }
FhirLocation >> alias: anObject [

	alias := anObject
]

{ #category : 'converting' }
FhirLocation >> asDictionary [

	| dict |
	dict := super asDictionary.
	"dict at: #id put: hsaid."
	dict
		at: #name put: self name;
		at: #alias put: alias;
		at: #identifier put: self hsaIdentifier.
	^ dict
]

{ #category : 'accessing' }
FhirLocation >> hsaIdentifier [

	| dict |
	dict:= Dictionary new.
	dict at:#system put: 'urn:oid:1.2.752.29.4.19';
	at:#value put: hsaid .
	^dict
]

{ #category : 'accessing' }
FhirLocation >> hsaid [

	^ hsaid
]

{ #category : 'accessing' }
FhirLocation >> hsaid: anObject [

	hsaid := anObject
]

{ #category : 'accessing' }
FhirLocation >> name [

	^ name
]

{ #category : 'accessing' }
FhirLocation >> name: anObject [

	name := anObject
]
