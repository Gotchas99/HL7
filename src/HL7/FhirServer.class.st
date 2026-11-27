Class {
	#name : 'FhirServer',
	#superclass : 'Object',
	#instVars : [
		'baseUrl'
	],
	#category : 'HL7-FHIR',
	#package : 'HL7',
	#tag : 'FHIR'
}

{ #category : 'as yet unclassified' }
FhirServer class >> poc [

	| srv |
	srv := self new.
	srv base: 'http://vgas5954.vgregion.se:8082/fhir/'.
	^ srv
]

{ #category : 'accessing' }
FhirServer >> base [

	^baseUrl
]

{ #category : 'accessing' }
FhirServer >> base: aBaseUrl [
baseUrl:=aBaseUrl 
]

{ #category : 'as yet unclassified' }
FhirServer >> deleteAppointments [

	| cl |
	cl := self fhirClient.
	cl addPath: { 'Appointment' }.
	cl queryAt:'_lastUpdated' put: 'ge2000-01-01'.
	cl delete.
]

{ #category : 'private' }
FhirServer >> fhirClient [

	|  cl |
	cl := ZnClient new url: self base.
	cl
		forJsonREST;
		enforceHttpSuccess: true;
		logToTranscript.
	^ cl
]
