Class {
	#name : 'BokningsApp',
	#superclass : 'WAComponent',
	#instVars : [
		'bokningar'
	],
	#category : 'HL7-FHIR',
	#package : 'HL7',
	#tag : 'FHIR'
}

{ #category : 'testing' }
BokningsApp class >> canBeRoot [

	^ true
]

{ #category : 'testing' }
BokningsApp class >> contextRoot [

	^ 'bokning'
]

{ #category : 'testing' }
BokningsApp class >> initialize [

	self register
]

{ #category : 'testing' }
BokningsApp class >> register [

	| app |
	app := WAAdmin register: self asApplicationAt: self contextRoot.
	^ app
]

{ #category : 'hooks' }
BokningsApp >> children [

	^ #()
]

{ #category : 'hooks' }
BokningsApp >> createPatients [

	| p patients |
	patients := OrderedCollection new.
	p := Dictionary new.
	p at: 'personnr' put: '201702022383'.
	p at: 'namn' put: 'Stinasson-af Klintberg'.
	patients add: p.

	p := Dictionary new.
	p at: 'personnr' put: '200009262395'.
	p at: 'namn' put: 'Maria Test Johansson'.
	patients add: p

	"p := Dictionary new.
	199504182396
	Risato^Clark Johan
	patients add: p"
]

{ #category : 'hooks' }
BokningsApp >> fhirClient [
	"/Appointment?patient.identifier=191212121212&_include=Appointment:patient&_include=Appointment:location"

	| base cl |
	base := 'http://vgas5954.vgregion.se:8082/fhir/'.
	cl := ZnClient new url: base.
	cl beOneShot;
	  forJsonREST.
	^ cl
]

{ #category : 'formatting' }
BokningsApp >> formatDate: aDateAndTime [
	^ (#('söndag' 'måndag' 'tisdag' 'onsdag' 'torsdag' 'fredag' 'lördag')
			at: aDateAndTime dayOfWeek), ' ',
	  aDateAndTime dayOfMonth printString, ' ',
	  (#('januari' 'februari' 'mars' 'april' 'maj' 'juni' 'juli'
	     'augusti' 'september' 'oktober' 'november' 'december')
			at: aDateAndTime month), ' ',
	  aDateAndTime year printString
]

{ #category : 'formatting' }
BokningsApp >> formatDuration: aDuration [
	| minutes hours rest |
	minutes := aDuration asSeconds // 60.
	hours := minutes // 60.
	rest := minutes \\ 60.
	hours = 0 ifTrue: [ ^ rest printString , ' min' ]. 
	rest = 0 ifTrue: [ ^ hours printString , ' h' ].
	^ hours printString , ' h ' , rest printString , ' min'
]

{ #category : 'formatting' }
BokningsApp >> formatTime: aDateAndTime [
	| hour minute |
	hour := aDateAndTime hour printPaddedWith: $0 to: 2.
	minute := aDateAndTime minute printPaddedWith: $0 to: 2.
	^ hour , ':' , minute
]

{ #category : 'hooks' }
BokningsApp >> getBookingsForPatient: aPatientID [
	"/Appointment?patient.identifier=191212121212&_include=Appointment:patient&_include=Appointment:location"

	| cl appts |
	cl := self fhirClient.
	cl addPath: { 'Appointment' }.
	cl
		queryAt: 'patient.identifier' put: aPatientID;
		queryAt: 'status' put: 'booked';
		queryAt: '_include' add: 'Appointment:patient';
		queryAt: '_include' add: 'Appointment:location'.
	"cl headerAt: 'If-Match' put: versionedUid."
	cl get.
	self assert: cl isSuccess.
	bokningar := self parseBookingsPatient: cl contents.
	^ bokningar
]

{ #category : 'hooks' }
BokningsApp >> getBookingsForUnit: aUnitID [
self flag:'intressant?'

	
]

{ #category : 'initialization' }
BokningsApp >> initialize [

	super initialize.
	self getBookingsForPatient: '191212121212'
]

{ #category : 'acccessing' }
BokningsApp >> monthNames [
	^ #('jan' 'feb' 'mar' 'apr' 'maj' 'jun' 'jul' 'aug' 'sep' 'okt' 'nov' 'dec')
]

{ #category : 'hooks' }
BokningsApp >> parseBookingsPatient: aResultSet [

	| dict entry patRes pat locations appts rawAppt rawLoc res locRes refId |
	entry := aResultSet at: #entry.

	pat := Dictionary new.
	patRes := (entry detect: [ :r |
		           (r at: #resource at: #resourceType) = 'Patient' ]) at:
		          #resource.
	pat at: #patNr put: ((patRes at: #identifier) first at: #value).
	pat
		at: #name
		put: ((patRes at: #name) first at: #given) first asString , ' '
			, ((patRes at: #name) first at: #family).

	rawLoc := entry select: [ :e |
		          (e at: #resource at: #resourceType) = 'Location' ].
	locations := Dictionary new.
	rawLoc do: [ :l |
		res := l at: #resource.
		dict := Dictionary new.
		dict at: #id put: (res at: #id).
		dict at: #name put: (res at: #name).
		locations at: (dict at: #id) put: dict ].

	rawAppt := entry select: [ :e | (e at: #search at: #mode) = 'match' ].
	appts := rawAppt collect: [ :a |
		        res := a at: #resource.
		        dict := Dictionary new.
		        dict at: #start put: (res at: #start).
		        dict at: #end put: (res at: #end).
		        dict at: #pat put: pat.
		        locRes := (res at: #participant) detect: [ :p |
			                  (p at: #actor at: #reference) beginsWith:
				                  'Location' ].
		        refId := ('/' split: (locRes at: #actor at: #reference))
			                 second.
		        dict at: #loc put: (locations at: refId).
		        dict ].
appts:=appts asSortedCollection: [ :a :b | (a at: #start) <= (b at: #start) ].
	dict := Dictionary new.
	dict at: #patient put: pat.
	dict at: #loc put: locations.
	dict at: #appt put: appts.
	^ dict
]

{ #category : 'rendering' }
BokningsApp >> renderAppt: appt on: html [

	| start end |
	start := DateAndTime fromString: (appt at: #start).
	end := DateAndTime fromString: (appt at: #end).
	html div
		class: 'appointment';
		with: [
			self renderDate: start on: html.
			html div
				class: 'time';
				with: (self formatTime: start).
			html div
				class: 'duration';
				with: (self formatDuration: end - start).
			html div
				class: 'location';
				with: (appt at: #loc) ]
]

{ #category : 'rendering' }
BokningsApp >> renderContentOn: html [

	html div
		class: 'omslag';
		with: [
			self renderHuvudOn: html.
			html div
				class: 'bokningar';
				with: [ " patientComps do: [ :pat | html render: pat ]"
					(bokningar at: #appt) do: [ :a | self renderAppt: a on: html ] ].
			self renderFooter: html ]
]

{ #category : 'rendering' }
BokningsApp >> renderDate: aDateAndTime on: html [
	| weekday day month year |
	weekday := self weekdayNames at: aDateAndTime dayOfWeek.
	day := aDateAndTime dayOfMonth printString.
	month := self monthNames at: aDateAndTime month.
	year := aDateAndTime year printString.
	html div class: 'date'; with: [
		html span class: 'weekday'; with: weekday.
		html span class: 'day'; with: day.
		html span class: 'month'; with: month , ' ' , year ]
]

{ #category : 'rendering' }
BokningsApp >> renderFooter: html [

	html paragraph
		class: 'notis';
		with: 'Bokningsöversikt'.
	^ html paragraph 
		  class: 'fot-not';
		  with: ''
]

{ #category : 'rendering' }
BokningsApp >> renderHuvudOn: html [

	html div
		class: 'huvud';
		with: [
			html div
				class: 'patient_id';
				with: [
					html
						text: 'Patient-ID: ';
						strong: '1912121212' ] .
					html span: (bokningar  at:#patient at:#name)]
]

{ #category : 'hooks' }
BokningsApp >> style [

	^ '* { box-sizing: border-box; } 

body {
  margin: 0;
  background: #f4f6f8;
  color: #1f2933;
  font: 15px/1.5 system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
}

.omslag {
  max-width: 760px;
  margin: 0 auto;
  padding: 0 16px 48px;
}

/* Patient header */
.huvud {
  position: sticky;
  top: 0;
  z-index: 1;
  display: flex;
  flex-wrap: wrap;
  align-items: baseline;
  gap: 4px 24px;
  margin: 0 -16px 24px;
  padding: 14px 16px;
  background: #ffffff;
  border-bottom: 1px solid #d5dbe2;
  box-shadow: 0 1px 3px rgba(16, 24, 40, .06);
}
.huvud > span { font-size: 1.1rem; font-weight: 600; }
.patient_id { color: #5f6b7a; }
.patient_id strong {
  color: #1f2933;
  font-variant-numeric: tabular-nums;
  letter-spacing: .02em;
}

/* Appointment card */
.appointment {
  display: grid;
  grid-template-columns: auto 1fr auto;
  grid-template-areas:
    "date time     duration"
    "date location location";
  align-items: center;
  column-gap: 20px;
  row-gap: 6px;
  margin-bottom: 12px;
  padding: 14px 20px 14px 14px;
  background: #ffffff;
  border: 1px solid #e3e7ec;
  border-radius: 8px;
  box-shadow: 0 1px 2px rgba(16, 24, 40, .04);
}

/* Calendar tile */
.date {
  grid-area: date;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-width: 80px;
  padding: 8px 10px;
  background: #eef4fb;
  border: 1px solid #c9dcf1;
  border-radius: 8px;
  color: #0b5cad;
  line-height: 1.15;
  text-align: center;
}
.weekday {
  font-size: .75rem;
  font-weight: 600;
  letter-spacing: .06em;
  text-transform: uppercase;
}
.day {
  font-size: 1.9rem;
  font-weight: 700;
  color: #1f2933;
  font-variant-numeric: tabular-nums;
}
.month {
  font-size: .8rem;
  font-weight: 500;
}

.time {
  grid-area: time;
  font-size: 1.1rem;
  font-weight: 600;
  font-variant-numeric: tabular-nums;
}

.duration {
  grid-area: duration;
  justify-self: end;
  padding: 2px 10px;
  border: 1px solid #d5dbe2;
  border-radius: 999px;
  background: #f4f6f8;
  color: #5f6b7a;
  font-size: .85rem;
  font-variant-numeric: tabular-nums;
  white-space: nowrap;
}

.location {
  grid-area: location;
  padding-top: 6px;
  border-top: 1px solid #e3e7ec;
  color: #5f6b7a;
}
.location::before {
  content: "Plats";
  display: inline-block;
  min-width: 4.5rem;
  color: #0b5cad;
  font-size: .75rem;
  font-weight: 600;
  letter-spacing: .06em;
  text-transform: uppercase;
}

/* Notices - hidden while empty */
.notis:empty, .fot-not:empty { display: none; }
.notis {
  margin: 16px 0 0;
  padding: 10px 14px;
  background: #fff8e6;
  border: 1px solid #f0d9a0;
  border-radius: 8px;
}
.fot-not { margin: 16px 0 0; color: #5f6b7a; font-size: .85rem; }'
]

{ #category : 'hooks' }
BokningsApp >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot title: 'Bokningsöversikt'.
	anHtmlRoot meta
		name: 'viewport';
		content: 'width=device-width, initial-scale=1'
]

{ #category : 'acccessing' }
BokningsApp >> weekdayNames [
	"Index 1 is Sunday, matching DateAndTime>>dayOfWeek"
	^ #('sön' 'mån' 'tis' 'ons' 'tor' 'fre' 'lör')
]
