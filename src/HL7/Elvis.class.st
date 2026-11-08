Class {
	#name : 'Elvis',
	#superclass : 'Object',
	#category : 'HL7-FHIR',
	#package : 'HL7',
	#tag : 'FHIR'
}

{ #category : 'as yet unclassified' }
Elvis >> createAppFromElvis: e [

	| appt |
	appt:= FhirAppointment new.
	appt startTime: (e at:#inskrivningstid).
appt duration: (e at:'tidsåtgång').
appt addPatient: (e at:#personnummer) displayName: nil.
appt addLocation:(e at:#HSA_ID_team) displayName: (e at:#team_klartext).
^appt
]

{ #category : 'as yet unclassified' }
Elvis >> enterAppointments [

	| elv apps |
	elv := self readFile.
	apps := elv collect: [ :e | self createAppFromElvis: e ].
	apps do: [ :a |self storeApp: a ].
	"bundle:=self createBundle: apps."
	"self storeBundle: bundle"
]

{ #category : 'private' }
Elvis >> fhirClient [
	"/Appointment?patient.identifier=191212121212&_include=Appointment:patient&_include=Appointment:location"

	| base cl |
	base := 'http://vgas5954.vgregion.se:8082/fhir/'.
	cl := ZnClient new url: base.
	cl
		beOneShot;
		forJsonREST.
	^ cl
]

{ #category : 'as yet unclassified' }
Elvis >> readFile [

	| fld file rd csv |
	fld := 'C:\Users\chras8\OneDrive - Västra Götalandsregionen\VGR DataHub - Dokument\General\02 PoC\Aktiva\Bokning\Arbetsmaterial'
		       asFileReference.
	file := fld / 'elvis.csv'.
	rd := NeoCSVReader on: file readStream.
	rd separator: $;.
	rd namedColumnsConfiguration.
	csv:=rd upToEnd.
	^csv
]

{ #category : 'as yet unclassified' }
Elvis >> storeApp: appt [

	| cl |
	cl := self fhirClient.
	cl addPath: { 'Appointment' }.
	"cl headerAt: 'If-None-Exist' put: <externt_bokningsID>."
	cl contents: appt asDictionary .
	cl post.
	self assert: cl isSuccess
]
