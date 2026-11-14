Class {
	#name : 'NpoCareDoc',
	#superclass : 'Object',
	#category : 'HL7-NPO',
	#package : 'HL7',
	#tag : 'NPO'
}

{ #category : 'as yet unclassified' }
NpoCareDoc class >> allSamples [

	| folders allFiles |
	folders := #( '3 Content - SJF' '5 Content - ContractSpecific' ).
	allFiles := folders collect: [ :fld |
		            (self sampleRootFolder / fld) allFiles ].
	^allFiles flattened
]

{ #category : 'as yet unclassified' }
NpoCareDoc class >> sampleBehandling [

	| file |
	file := (self sampleRootFolder
	         /
	         '5 Content - ContractSpecific\5.6 ClinicalDocumentNoteCode_Behandling')
		        files first.
	^ self new onTestFile: file

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

{ #category : 'as yet unclassified' }
NpoCareDoc >> fillFlat: aFlatTemplate with: aDict [

	
	| json result |
	json := aFlatTemplate format: aDict.
	result := STONJSON fromString:'{', json,'}'.
	^ result
]

{ #category : 'flats' }
NpoCareDoc >> flatFeeder [

	^'
"visit_note/_feeder_audit/originating_system_audit|system_id": "SE2321000131-S000000002253",
  "visit_note/_feeder_audit/originating_system_audit|time": "2025-10-06T11:35:08+02:00",
  "visit_note/_feeder_audit/originating_system_item_id:0|id": "melior:voo:sourcesystem:4016|tst_a_fss:folderid:319328:activityid:250:termid:1511",
  "visit_note/_feeder_audit/originating_system_item_id:0|type": "RIV_RECORD_ID",
  "visit_note/_feeder_audit/originating_system_item_id:0|issuer": "SE2321000131-S000000002253"
'
]

{ #category : 'flats' }
NpoCareDoc >> flatNote [

	^ '
  "visit_note/ad_hoc_heading:{3}/_name": "{1}",
  "visit_note/ad_hoc_heading:{3}/clinical_synopsis/synopsis": "{2}"
'
]

{ #category : 'flats' }
NpoCareDoc >> flatVisitNote [

	^ '
  "visit_note/_name": "{title}",
  "visit_note/category|code": "433",
  "visit_note/category|value": "event",
  "visit_note/category|terminology": "openehr",
  "visit_note/language|code": "sv",
  "visit_note/language|terminology": "ISO_639-1",
  "visit_note/territory|code": "SE",
  "visit_note/territory|terminology": "ISO_3166-1",
  "visit_note/composer|name": "{auth}",
  "visit_note/composer|id": "SE2321000131-P000000082137",
  "visit_note/composer|id_scheme": "HSA",
  "visit_note/composer|id_namespace": "SE",

  "visit_note/context/start_time": "{timestamp}",
  "visit_note/context/setting|code": "232",
  "visit_note/context/setting|value": "secondary medical care",
  "visit_note/context/setting|terminology": "openehr",
  "visit_note/context/_health_care_facility|name": "{careUnit}",
  "visit_note/context/_health_care_facility|id": "SE2321000131-E000000010447",
  "visit_note/context/_health_care_facility|id_scheme": "HSA",
  "visit_note/context/_health_care_facility|id_namespace": "SE",

  "visit_note/context/care_unit/name": "{careUnit}",
  "visit_note/context/care_unit/identifier:0/identifier_value|id": "SE2321000131-E000000015697",
  "visit_note/context/care_unit/identifier:0/identifier_value|issuer": "HSA",
  "visit_note/context/care_unit/role|code": "43741000",
  "visit_note/context/care_unit/role|value": "vårdenhet",
  "visit_note/context/care_unit/role|terminology": "http://snomed.info/sct/900000000000207008",
  "visit_note/context/care_unit/care_provider/name": "Västra Götalandsregionen",
  "visit_note/context/care_unit/care_provider/organisational_number/identifier_value|id": "<organisational number>",
  "visit_note/context/care_unit/care_provider/identifier:0/identifier_value|id": "SE2321000131-E000000000001",
  "visit_note/context/care_unit/care_provider/identifier:0/identifier_value|issuer": "HSA",
  "visit_note/context/care_unit/care_provider/role|code": "143591000052",
  "visit_note/context/care_unit/care_provider/role|value": "vårdgivare",
  "visit_note/context/care_unit/care_provider/role|terminology": "http://snomed.info/sct/45991000052106",

  "visit_note/context/source_document/note_type|code": "auf",
  "visit_note/context/source_document/note_type|value": "{typ}",
  "visit_note/context/source_document/note_type|terminology": "KV_Anteckningstyp",
  "visit_note/context/source_document/approved_for_patient": true,
  "visit_note/context/source_document/author_role": "Läk"
'
]

{ #category : 'instance creation' }
NpoCareDoc >> onStringOrStream: aStringOrStream [

	|  xml  resp docs |
	xml := XMLDOMParser parse: aStringOrStream.
	resp := xml root firstElement firstElement.
	docs := resp elements allButLast collect: [ :x | self parseDoc: x ].
	^ docs
]

{ #category : 'instance creation' }
NpoCareDoc >> onTestFile: aFile [

	| marker docs stream |
	stream := aFile readStream. 
	marker := '<soap:Envelope'.
	stream match: marker.
	stream position: stream position - marker size.
	docs := self onStringOrStream: stream.
	^ docs
]

{ #category : 'instance creation' }
NpoCareDoc >> parseDoc: xml [

	| dict header body code note |
	dict := Dictionary new.
	header := xml firstNode.
	dict
		at: #patId
		put:
		((header findElementNamed: 'patientId') contentStringAt: 'extension').
	dict
		at: #auth
		put: ((header findElementNamed: 'author') contentStringAt: 'name').
	dict
		at: #careUnit
		put: (header findElementNamed: 'orgUnitName') contentString.
	dict
		at: #timestamp
		put:
		(DateAndTime readYMDHMSfromDigits:
		((header findElementNamed: 'author') contentStringAt: 'timestamp') readStream)asString .
	body := xml lastNode.
	code := (body findElementNamed: 'code') contentString.
	dict at: #typ put: (self anteckningstypLista at: code).
	note := self parseNote:
		        (body findElementNamed: 'clinicalDocumentNoteText')
			        contentString.
	dict at: #title put: note first.
	dict at: #text put: note last.
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

{ #category : 'writing' }
NpoCareDoc >> writeDoc: aDoc [

	| visitNote feeder notes cl |
	visitNote := self fillFlat: self flatVisitNote with: aDoc.
	notes := (aDoc at: #text) withIndexCollect: [ :each :index |
		         self
			         fillFlat: self flatNote
			         with: (each copyWith: index - 1) ].
	feeder := self fillFlat: self flatFeeder with: aDoc.
	notes do: [ :note | visitNote addAll: note ].
	visitNote addAll: feeder.
	"-----------"
	cl := News2 new ehrClient forJsonREST.
	cl addPath: { 'ehr'. 'cf92c480-249c-4929-bac0-4e87b5b853bb'.
		'composition' }.
	cl
		queryAt: 'format' put: 'FLAT';
		queryAt: 'templateId' put: 'VGR visit note'.

	cl contents: visitNote.
	cl post.
	self assert: cl isSuccess
]
