Class {
	#name : 'CDR',
	#superclass : 'Object',
	#category : 'HL7-OpenEHR',
	#package : 'HL7',
	#tag : 'OpenEHR'
}

{ #category : 'as yet unclassified' }
CDR class >> poc [

	| cdr |
	cdr:= self new.
	
^cdr
]

{ #category : 'accessing' }
CDR >> client [

	| cl url |
	url := 'http://datahub-cdr-poc.vgregion.se/ehrbase/rest/openehr/v1/'.
	cl := ZnClient new url: url.
	"cl setBasicAuthenticationUsername: 'ehrbase-user' password: 'SuperSecretPassword'."
	cl beOneShot;forJsonREST.
		^ cl
]

{ #category : 'as yet unclassified' }
CDR >> getComp: aCompId forEhr: anEhrId [

	| cl comp |
	cl := self client.
	cl addPath: {
			'ehr'.
			anEhrId.
			'composition'.
			aCompId }.
	cl queryAt: 'format' put: 'FLAT'.
	cl get.
	self assert: cl isSuccess.
	comp := Composition new fromClient: cl.
	comp cdr:self.
	^ comp
]

{ #category : 'as yet unclassified' }
CDR >> updateComp: aComp [
	"PUT {{ehr}}/{ehr_id}/composition/cc8d…?templateId=TEMP International Patient Summary&format=FLAT
	 If-Match: cc8d…::local.ehrbase.org::3"
 
	| cl versionedUid |
	versionedUid := aComp values
		                removeKey: aComp templatePrefix , '/_uid'
		                ifAbsent: [ nil ].
	cl := self client.
	cl addPath: {
			'ehr'.
			aComp ehrId.
			'composition'.
			aComp compId }.
	cl
		queryAt: 'format' put: 'FLAT';
		queryAt: 'templateId' put: aComp template.
	cl headerAt: 'If-Match' put: versionedUid.
	cl contents: aComp values.
	cl put.
	self assert: cl isSuccess
]
