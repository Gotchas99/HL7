Class {
	#name : 'FhirAppointment',
	#superclass : 'FHIR',
	#instVars : [
		'startTime',
		'endTime',
		'status',
		'participants'
	],
	#category : 'HL7-FHIR',
	#package : 'HL7',
	#tag : 'FHIR'
}

{ #category : 'adding' }
FhirAppointment >> addLocation: aHsaId displayName: aString [

	| actor dict |
	actor := Dictionary new.
	actor
		at: #reference
		put: 'Location?identifier=urn:oid:1.2.752.29.4.19|' , aHsaId.
	aString isEmptyOrNil ifFalse: [ actor at: #display put: aString ].
	dict := Dictionary new.
	dict at: #actor put: actor.
	dict at: #status put: #accepted.
	participants add: dict.
	^ dict
]

{ #category : 'adding' }
FhirAppointment >> addPatient: personNr displayName: aString [

	| actor dict |
	actor := Dictionary new.
	actor
		at: #reference
		put:
			'Patient?identifier=http://electronichealth.se/identifier/personnummer|'
			, personNr.
	aString isEmptyOrNil ifFalse: [ actor at: #display put: aString ].
	dict:= Dictionary new.
	dict at:#actor put:actor.
	dict at: #status put: #accepted.
	participants add:dict.
	^ dict
]

{ #category : 'converting' }
FhirAppointment >> asDictionary [

	| dict |
	dict := super asDictionary.
	dict
		at: #status put: self status;
		at: #start put: startTime;
		at: #end put: endTime;
		at: #participant put: participants.
	^ dict
]

{ #category : 'accessing' }
FhirAppointment >> duration:aDuration [
endTime:=startTime + aDuration asInteger minutes
]

{ #category : 'initialization' }
FhirAppointment >> initialize [

	super initialize.
	participants:=OrderedCollection new.
]

{ #category : 'accessing' }
FhirAppointment >> resourceType [ 
^'Appointment'
]

{ #category : 'accessing' }
FhirAppointment >> startTime: aDateAndTime [

	startTime := DateAndTime fromString: aDateAndTime 
]

{ #category : 'accessing' }
FhirAppointment >> status [ ^status ifNil: [status:=#booked]
]
