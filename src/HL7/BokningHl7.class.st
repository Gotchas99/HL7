Class {
	#name : 'BokningHl7',
	#superclass : 'Object',
	#instVars : [
		'client'
	],
	#category : 'HL7-FHIR',
	#package : 'HL7',
	#tag : 'FHIR'
}

{ #category : 'content' }
BokningHl7 >> createAppt: h7 [

	| appt f3 |
	appt := FhirAppointment new.
	appt status: 'booked'.
	appt bookingApp: h7 msh sendingApplicationUID.
	appt bookingId: ((h7 segment: #sch) at: 2) last txt.
	appt startTime: ((h7 segment: #TQ1) at: 7) last.
	appt endTime: ((h7 segment: #TQ1) at: 8) last.
	appt addPatient: h7 pid patientId displayName: nil.
	f3 := ((h7 segment: 'PV1') at: 3) last.
	appt addLocation: (f3 at: 1) displayName: ''.
	^ appt
]

{ #category : 'content' }
BokningHl7 >> enterAppointmentWorker [

	| siu apps |
	client := self fhirClient.
	client addPath: { 'Location' }.
	siu := self readFile.
	apps := siu collect: [ :e | self createAppt: e ].
	apps do: [ :a | 
		self storeApp: a ].
	client := nil
]

{ #category : 'content' }
BokningHl7 >> enterAppointments [

	| loader |
	loader := [ self enterAppointmentWorker  ]
	forkAt: Processor userBackgroundPriority
	named: 'FHIR load'.
]

{ #category : 'private' }
BokningHl7 >> fhirClient [

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
BokningHl7 >> readFile [

	| fld file tmp |
	fld := 'C:\Users\chras8\OneDrive - Västra Götalandsregionen\VGR DataHub - Dokument\General\02 PoC\Aktiva\Bokning\Arbetsmaterial\Testdata'
		       asFileReference.
	file := fld / 'HL7_SIU_Demo.txt'.
	tmp := '----------' split: file contents.
	tmp := tmp collect: [ :msg | (H7Parser on: msg) parse ].
	^ tmp
]

{ #category : 'content' }
BokningHl7 >> storeApp: appt [

	| cl |
	cl := self fhirClient.
	cl addPath: { 'Appointment' }.
	"cl headerAt: 'If-None-Exist' put: <externt_bokningsID>."
	cl contents: appt asDictionary.
	cl post.
	self assert: cl isSuccess
]
