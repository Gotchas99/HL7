Class {
	#name : 'Lakemedel',
	#superclass : 'Object',
	#category : 'HL7-PatSummary',
	#package : 'HL7',
	#tag : 'PatSummary'
}

{ #category : 'content' }
Lakemedel >> createFlatsFor: receptLista [

	| flats |
	flats := receptLista withIndexCollect: [ :each :index |
		each at:#index put:( index - 1).
		         Composition new
			         fillFlat: self flatMedSummary
			         with: (each ) ].
	^ flats
]

{ #category : 'accessing' }
Lakemedel >> file [

	| fld file |
	fld:='C:\Users\chras8\OneDrive - Västra Götalandsregionen\C_A_H_Hub\PÖ PoC\Meliordata'asFileReference .
	file:=fld / 'recept.csv'.
	^file
]

{ #category : 'content' }
Lakemedel >> flatMedSummary [

	^ '	  
  "temp_international_patient_summary/medication_summary/medication_statement:{index}/ism_transition/current_state|terminology": "openehr",
  "temp_international_patient_summary/medication_summary/medication_statement:{index}/ism_transition/current_state|code": "245",
  "temp_international_patient_summary/medication_summary/medication_statement:{index}/ism_transition/current_state|value": "active",
  "temp_international_patient_summary/medication_summary/medication_statement:{index}/medication_item|value": "{substans}",
  "temp_international_patient_summary/medication_summary/medication_statement:{index}/medication_item|code": "{atckod_fk}",
  "temp_international_patient_summary/medication_summary/medication_statement:{index}/medication_item|terminology": "ATC",
  "temp_international_patient_summary/medication_summary/medication_statement:{index}/medication_details/description": "{läkemedelsnamn}",
  "temp_international_patient_summary/medication_summary/medication_statement:{index}/dosage/dose_description": "{anvisning}",
  "temp_international_patient_summary/medication_summary/medication_statement:{index}/time": "{receptdatum}"
'
]

{ #category : 'content' }
Lakemedel >> readFile [

	|  rd csv |
	rd := NeoCSVReader on: self file readStream.
	rd separator: $;.
	rd namedColumnsConfiguration.
	csv := rd upToEnd.
	^ csv
]

{ #category : 'public' }
Lakemedel >> updateMeds [

	| receptLista compId comp ehrId medDict |
	"read file"
	receptLista := self readFile copyFrom: 12 to: 15.
	"get comp"
	ehrId := 'cf92c480-249c-4929-bac0-4e87b5b853bb'.
	compId := '1da0f6ee-e45f-4f0e-8731-7a890c183448'.
	comp := CDR poc getComp: compId forEhr: ehrId.
	"remove med section"
	comp removeAllStarting: 'medication_summary'.
	"create new med section"
	medDict := self createFlatsFor: receptLista.
	"add new meds to comp"
	comp addAll: medDict.
	"update comp in CDR"
	comp putToCdr
]
