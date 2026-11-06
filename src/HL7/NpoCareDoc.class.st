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

{ #category : 'as yet unclassified' }
NpoCareDoc >> anteckningstypLista [

	| txt assoc t |
	txt := 'utr	Utredning
atb	Åtgärd/Behandling
sam	Sammanfattning
sao	Samordning
ins	Inskrivning
slu	Slutanteckning
auf	Anteckning utan fysiskt möte
sva	Slutenvårdsanteckning
bes	Besöksanteckning' lines.
	assoc := txt collect: [ :l | t := Character tab split: l. t first->t last ].
	^ assoc asDictionary
]

{ #category : 'instance creation' }
NpoCareDoc >> on: aFile [

	| marker xml stream resp docs |
	stream := aFile readStream.
	marker := '<soap:Envelope'.
	stream match: marker.
	stream position: stream position - marker size.
	xml := XMLDOMParser parse: stream.
	resp := xml root firstElement firstElement .
docs:= resp elements allButLast collect: [:x| self parseDoc:x].
	^ docs
]

{ #category : 'instance creation' }
NpoCareDoc >> parseDoc: xml [

	| dict header body code not |
	dict := Dictionary new.
	header := xml firstNode.
	dict at:#patId put:( (header findElementNamed: 'patientId')contentStringAt:'extension').
	dict at:#auth: put:( (header findElementNamed: 'author')contentStringAt:'name').
	dict at: #careUnit: put:( (header findElementNamed: 'orgUnitName')contentString).
	dict at:#timestamp: put: ( (header findElementNamed: 'author')contentStringAt:'timestamp').
	body:= xml lastNode.
	code:= (body  findElementNamed: 'code')contentString.
	dict at:#typ put: (self anteckningstypLista at:code).
	not:= self parseNote:((body  findElementNamed: 'clinicalDocumentNoteText')contentString).
	dict at:#title put:not first.
	dict at:#text put:not last.
	^ dict
]

{ #category : 'as yet unclassified' }
NpoCareDoc >> parseNote: aEncodedXml [

	| not info title para sections |
	not := (XMLDOMParser parse: aEncodedXml) firstElement.
	info := (not elementAt: 'info') contentStringAt: 'title'. 
	sections := (not elementsAt: 'section') collect: [ :s |
		            title := s contentStringAt: 'title'.
		            para := s contentStringAt: 'para' . {title. para}].
	^ {
		  info.
		  sections }
]
