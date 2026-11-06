Class {
	#name : 'NpoCareDoc',
	#superclass : 'Object',
	#category : 'HL7-NPO',
	#package : 'HL7',
	#tag : 'NPO'
}

{ #category : 'as yet unclassified' }
NpoCareDoc class >> sampleBehandling [

| file |
file:=(self sampleRootFolder / '5 Content - ContractSpecific\5.6 ClinicalDocumentNoteCode_Behandling') files first .
^self new on:file.
	
	"/ '20260409-125150481 - 5.6 ClinicalDocumentNoteCode_Behandling.xml'"
]

{ #category : 'as yet unclassified' }
NpoCareDoc class >> sampleRootFolder [

	^'C:\Users\chras8\OneDrive - Västra Götalandsregionen\VGR DataHub - Dokument\General\02 PoC\Aktiva\Patientöversikt\Underlag\NPÖ-tester\CareDoc\'
		asFileReference
]

{ #category : 'instance creation' }
NpoCareDoc >> on: aFile [

| marker |
marker :='<soap:Envelope'.
aFile match: marker.
aFile position: (aFile position - (marker size)).

	^aFile 
]
