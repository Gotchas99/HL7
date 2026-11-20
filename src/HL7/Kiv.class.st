Class {
	#name : 'Kiv',
	#superclass : 'Object',
	#instVars : [
		'client'
	],
	#category : 'HL7-FHIR',
	#package : 'HL7',
	#tag : 'FHIR'
}

{ #category : 'as yet unclassified' }
Kiv >> createLocFromKiv: e [

	| loc |
	loc := FhirLocation new.
	loc name: (e at: #orgnamn ifAbsent: [e at: 'oushort']).
	loc alias: (e at: 'oushort' ifAbsent: ['']).
	loc hsaid: (e at: #hsaid_pk) .
	^ loc
]

{ #category : 'as yet unclassified' }
Kiv >> enterLocations [

	| kiv locs |
	client := self fhirClient.
	client addPath: { 'Location' }.
	kiv := self readFile.
	locs := kiv collect: [ :k | self createLocFromKiv: k ].
	locs do: [ :a | self storeLocation: a ].
	client := nil
]

{ #category : 'private' }
Kiv >> fhirClient [

	| base cl |
	base := 'http://vgas5954.vgregion.se:8082/fhir/'.
	cl := ZnClient new url: base.
	cl
		forJsonREST;
		enforceHttpSuccess: true;
		logToTranscript.
	^ cl
]

{ #category : 'content' }
Kiv >> readFile [

	| fld file rd csv |
	fld := 'C:\Users\chras8\OneDrive - Västra Götalandsregionen\VGR DataHub - Dokument\General\02 PoC\Aktiva\Bokning\Arbetsmaterial\Testdata'
		       asFileReference.
	file := fld / 'KiV.csv'.
	rd := NeoCSVReader on: file readStream.
	rd separator: $;.
	rd namedColumnsConfiguration.
	csv := rd upToEnd.
	^ csv
]

{ #category : 'as yet unclassified' }
Kiv >> storeLocation: loc [

	
	
	client contents: loc asDictionary.
	client post.
	
]
