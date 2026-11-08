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
	elv:= self readFile .
	apps:=elv collect:[:e|self createAppFromElvis:e].
	self createBundle: apps.
	self storeBundle.
]

{ #category : 'as yet unclassified' }
Elvis >> readFile [

	| fld file rd |
	fld := 'C:\Users\chras8\OneDrive - Västra Götalandsregionen\VGR DataHub - Dokument\General\02 PoC\Aktiva\Bokning\Arbetsmaterial'
		       asFileReference.
	file := fld / 'elvis.csv'.
	rd := NeoCSVReader on: file readStream.
	rd separator: $;.
	rd namedColumnsConfiguration.
^	rd upToEnd
]
