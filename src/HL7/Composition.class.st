Class {
	#name : 'Composition',
	#superclass : 'Object',
	#instVars : [
		'template',
		'values',
		'cdr',
		'compId',
		'ehrId',
		'templatePrefix',
		'versionedCompId'
	],
	#category : 'HL7-OpenEHR',
	#package : 'HL7',
	#tag : 'OpenEHR'
}

{ #category : 'helper' }
Composition >> addAll: moreValues [

	moreValues isDictionary
		ifTrue: [ values addAll: moreValues ]
		ifFalse: [ moreValues do: [ :v | self addAll: v ] ] 
]

{ #category : 'accessing' }
Composition >> cdr:aCdr [ 
cdr:=aCdr 
]

{ #category : 'accessing' }
Composition >> compId [ ^compId
]

{ #category : 'accessing' }
Composition >> ehrId [ ^ehrId 
]

{ #category : 'helper' }
Composition >> fillFlat: aFlatTemplate with: aDict [

	| json result |
	json := aFlatTemplate format: aDict.
	result := STONJSON fromString: '{' , json , '}'.
	^ result
]

{ #category : 'instance creation' }
Composition >> fromClient: aZnClient [

	| location |
	template := aZnClient response headers at: 'Ehrbase-Template-Id'.
	versionedCompId := aZnClient response headers at: 'etag'.
	location := (aZnClient response headers at: 'location') asUrl.
	compId := location lastPathSegment.
	ehrId := location removeLastPathSegment removeLastPathSegment
		         lastPathSegment.
	values := aZnClient contents.
	templatePrefix := values keys first copyUpToSubstring: '/'
]

{ #category : 'helper' }
Composition >> putToCdr [

	self assert: compId notNil.
	cdr updateComp: self.
]

{ #category : 'removing' }
Composition >> removeAllStarting: aSectionString [
	"prefix := 'temp_international_patient_summary/medication_summary/'."

	| kept aPrefixString |
	aPrefixString:= templatePrefix ,'/',aSectionString ,'/'.
	kept := Dictionary new.
	values keysAndValuesDo: [ :key :value |
		(key beginsWith: aPrefixString) ifFalse: [ kept at: key put: value ] ].
	values := kept
	"kept addAll: newMedicationKeys."
]

{ #category : 'accessing' }
Composition >> template [ ^template
]

{ #category : 'accessing' }
Composition >> templatePrefix^templatePrefix [
]

{ #category : 'accessing' }
Composition >> values [ ^values
]

{ #category : 'accessing' }
Composition >> versionedCompId [ ^versionedCompId
]
