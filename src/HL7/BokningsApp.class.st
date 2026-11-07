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

{ #category : 'hooks' }
BokningsApp >> getBookingsForPatient: aPatientID [
	"/Appointment?patient.identifier=191212121212&_include=Appointment:patient&_include=Appointment:location"

	| cl |
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
bokningar:= self parseBookingsPatient: cl contents
]

{ #category : 'hooks' }
BokningsApp >> getBookingsForUnit:aUnitID [
]

{ #category : 'initialization' }
BokningsApp >> initialize [

	super initialize.
	self getBookingsForPatient: '191212121212'
]

{ #category : 'hooks' }
BokningsApp >> parseBookingsPatient: aResultSet [

	| dict entry patRes pat loc appt rawAppt rawLoc res locRes refId |
	entry := aResultSet at: #entry.

	pat := Dictionary new. 
	patRes := (entry detect: [ :r |
		           (r at: #resource at: #resourceType) = 'Patient' ]) at:
		          #resource.
	pat at: #patNr put: ((patRes at: #identifier) first at: #value).
	pat at: #name put: (((patRes at: #name) first at: #given)first asString,' ',((patRes at: #name) first at: #family)).

	rawLoc := entry select: [ :e |
		          (e at: #resource at: #resourceType) = 'Location' ].
	loc := Dictionary new.
	 rawLoc do: [ :l |
		       res := l at: #resource.
		       dict := Dictionary new.
		       dict at: #id put: (res at: #id).
		       dict at: #name put: (res at: #name).
		       loc at: (dict at: #id) put: dict].

	rawAppt := entry select: [ :e | (e at: #search at: #mode) = 'match' ].
	appt := rawAppt collect: [ :a |
		        res := a at: #resource.
		        dict := Dictionary new.
		        dict at: #start put: (res at: #start).
		        dict at: #end put: (res at: #end).
		        dict at: #pat put: pat.
		        locRes := (res at: #participant)detect:[:p|(p at:#actor at:#reference) beginsWith: 'Location'].
					refId:= ('/' split: (locRes at:#actor at:#reference))second.
		        dict at: #loc put: (loc at:refId) ].

	dict := Dictionary new.
	dict at: #patient put: pat.
	dict at: #loc put: loc.
	dict at: #appt put: appt.
	^ dict
]

{ #category : 'rendering' }
BokningsApp >> renderContentOn: html [

	html div
		class: 'omslag';
		with: [
			self renderHuvudOn: html.
			html div
				class: 'bokningar';
				with: [ " patientComps do: [ :pat | html render: pat ]" ].
			self renderFooter: html ]
]

{ #category : 'rendering' }
BokningsApp >> renderFooter: html [

	html paragraph
		class: 'notis';
		with: ''.
	^ html paragraph
		  class: 'fot-not';
		  with: ''
]

{ #category : 'rendering' }
BokningsApp >> renderHuvudOn: html [

	html div
		class: 'huvud';
		with: [
			html div class:'patient_id';with: [
					html
						text: 'Patient-ID: ';
						strong: '1912121212' ] ]
]

{ #category : 'hooks' }
BokningsApp >> style [

	^ '/* ==========================================================================
   news2.css — stilmall för NEWS2-vyerna i VGR DataHub
   --------------------------------------------------------------------------
   Två vyer delar samma mall:
     tavla.html        avdelningstavlan, för verksamheten
     verifiering.html  granskningsvyn, för tekniker och informatiker

   Statusfärgerna (god/varning/allvarlig/kritisk) är reserverade för klinisk
   risk och används aldrig som dekor eller som serieidentitet. De bärs alltid
   tillsammans med ikon och text — färgen är aldrig ensam bärare av betydelse.
   ========================================================================== */

:root {
  color-scheme: light;
  --yta:        #fcfcfb;   /* kortets yta  */
  --plan:       #f3f3f0;   /* sidans botten */
  --ink:        #0b0b0b;
  --ink-2:      #52514e;
  --ink-3:      #898781;
  --linje:      #e1e0d9;
  --kant:       rgba(11,11,11,0.10);
  --serie:      #2a78d6;   /* enda serien i trendkurvan */
  --serie-svag: #c3c2b7;

  /* Statuspalett — fast, byts inte mellan ljust och mörkt */
  --god:      #0ca30c;
  --varning:  #fab219;
  --allvar:   #ec835a;
  --kritisk:  #d03b3b;
  --okand:    #898781;

  --r: 10px;
  --sans: system-ui, -apple-system, "Segoe UI", sans-serif;
  --mono: ui-monospace, SFMono-Regular, Menlo, Consolas, monospace;
}

@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    color-scheme: dark;
    --yta: #1a1a19; --plan: #0d0d0d;
    --ink: #f0efec; --ink-2: #c3c2b7; --ink-3: #898781;
    --linje: #2c2c2a; --kant: rgba(255,255,255,0.10);
    --serie: #3987e5; --serie-svag: #52514e;
  }
}
:root[data-theme="dark"] {
  color-scheme: dark;
  --yta: #1a1a19; --plan: #0d0d0d;
  --ink: #f0efec; --ink-2: #c3c2b7; --ink-3: #898781;
  --linje: #2c2c2a; --kant: rgba(255,255,255,0.10);
  --serie: #3987e5; --serie-svag: #52514e;
}

* { box-sizing: border-box; }
body {
  margin: 0; background: var(--plan); color: var(--ink);
  font: 400 14px/1.5 var(--sans);
  -webkit-font-smoothing: antialiased;
}
.omslag { max-width: 1180px; margin: 0 auto; padding: 24px 20px 64px; }

/* --- Sidhuvud ----------------------------------------------------------- */
.huvud { display: flex; flex-wrap: wrap; gap: 16px; align-items: flex-end;
         justify-content: space-between; margin-bottom: 20px; }
.huvud h1 { margin: 0; font-size: 22px; font-weight: 650; letter-spacing: -0.01em; }
.huvud p  { margin: 4px 0 0; color: var(--ink-2); font-size: 13px; }
.stampel { font-size: 12px; color: var(--ink-3); text-align: right; }
.stampel b { display: block; color: var(--ink-2); font-weight: 600; font-size: 13px; }

/* --- Nyckeltal ---------------------------------------------------------- */
.nyckeltal { display: grid; gap: 12px; margin-bottom: 20px;
             grid-template-columns: repeat(auto-fit, minmax(170px, 1fr)); }
.ruta { background: var(--yta); border: 1px solid var(--kant); border-radius: var(--r);
        padding: 14px 16px; }
.ruta .etikett { font-size: 12px; color: var(--ink-2); margin-bottom: 6px; }
.ruta .tal { font-size: 28px; font-weight: 650; line-height: 1.1; letter-spacing: -0.02em; }
.ruta .fot { font-size: 12px; color: var(--ink-3); margin-top: 4px; }

/* --- Statusmärkning ----------------------------------------------------- */
/* Ikon + text alltid. Färgen förstärker, den bär aldrig ensam. */
.status { display: inline-flex; align-items: center; gap: 6px; white-space: nowrap;
          font-size: 12px; font-weight: 600; padding: 3px 9px 3px 7px;
          border-radius: 999px; border: 1px solid var(--kant); }
.status .prick { width: 9px; height: 9px; border-radius: 50%; flex: none; }
.status-god     { color: #0a7d0a; } .status-god .prick     { background: var(--god); }
.status-varning { color: #8a6000; } .status-varning .prick { background: var(--varning); }
.status-allvar  { color: #a8512a; } .status-allvar .prick  { background: var(--allvar); }
.status-kritisk { color: #b02a2a; } .status-kritisk .prick { background: var(--kritisk); }
.status-okand   { color: var(--ink-2); } .status-okand .prick { background: var(--okand); }
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) .status-god     { color: #4cc24c; }
  :root:not([data-theme="light"]) .status-varning { color: var(--varning); }
  :root:not([data-theme="light"]) .status-allvar  { color: var(--allvar); }
  :root:not([data-theme="light"]) .status-kritisk { color: #e46a6a; }
}
:root[data-theme="dark"] .status-god     { color: #4cc24c; }
:root[data-theme="dark"] .status-varning { color: var(--varning); }
:root[data-theme="dark"] .status-allvar  { color: var(--allvar); }
:root[data-theme="dark"] .status-kritisk { color: #e46a6a; }

/* --- Patientrader ------------------------------------------------------- */
.patienter { display: flex; flex-direction: column; gap: 10px; }
.patient { background: var(--yta); border: 1px solid var(--kant); border-radius: var(--r);
           overflow: hidden; }
.patient > summary { list-style: none; cursor: pointer; display: grid; gap: 14px;
                     align-items: center; padding: 14px 16px;
                     grid-template-columns: 148px 68px 1fr 128px 176px 18px; }
.patient > summary::-webkit-details-marker { display: none; }
.patient > summary:hover { background: color-mix(in srgb, var(--ink) 3%, var(--yta)); }

.sang { font-size: 12px; color: var(--ink-3); }
.sang b { display: block; font-size: 15px; font-weight: 600; color: var(--ink); }

.poang { text-align: center; }
.poang .varde { font-size: 32px; font-weight: 650; line-height: 1; letter-spacing: -0.02em; }
.poang .av { font-size: 11px; color: var(--ink-3); margin-top: 3px; }

.drivande { display: flex; flex-wrap: wrap; gap: 6px; }
.bidrag { font-size: 11.5px; padding: 3px 8px; border-radius: 6px;
          border: 1px solid var(--kant); color: var(--ink-2);
          background: color-mix(in srgb, var(--ink) 4%, var(--yta)); }
.bidrag b { color: var(--ink); font-weight: 600; }

.alder { font-size: 12px; color: var(--ink-2); text-align: right; }
.alder .status { margin-bottom: 3px; }
.alder .sent { color: var(--ink-3); }
.pil { color: var(--ink-3); transition: transform .15s; font-size: 12px; }
.patient[open] .pil { transform: rotate(90deg); }

/* --- Trendkurva (en serie, ingen dubbel axel) --------------------------- */
.trend { display: block; width: 128px; height: 34px; overflow: visible; }
.trend .bana { fill: none; stroke: var(--ink-3); stroke-width: 2;
               stroke-linecap: round; stroke-linejoin: round; }
.trend .nu { fill: var(--serie); stroke: var(--yta); stroke-width: 2; }
.trend .grund { stroke: var(--linje); stroke-width: 1; }

/* --- Härledning (utfällt) ----------------------------------------------- */
.harledning { border-top: 1px solid var(--linje); padding: 14px 16px 16px;
              background: color-mix(in srgb, var(--ink) 2%, var(--yta)); }
.harledning h3 { margin: 0 0 10px; font-size: 12px; font-weight: 600;
                 color: var(--ink-2); text-transform: uppercase; letter-spacing: .04em; }

/* --- Tabeller ----------------------------------------------------------- */
table.data { width: 100%; border-collapse: collapse; font-size: 13px; }
table.data th { text-align: left; font-weight: 600; font-size: 11.5px; color: var(--ink-2);
                text-transform: uppercase; letter-spacing: .04em;
                padding: 0 10px 7px; border-bottom: 1px solid var(--linje); }
table.data td { padding: 7px 10px; border-bottom: 1px solid var(--linje); vertical-align: top; }
table.data tr:last-child td { border-bottom: 0; }
table.data td.num, table.data th.num { text-align: right; font-variant-numeric: tabular-nums; }
table.data td.svag { color: var(--ink-3); }
table.data code { font: 12px/1.4 var(--mono); color: var(--ink-2); white-space: nowrap; }

.kort { background: var(--yta); border: 1px solid var(--kant); border-radius: var(--r);
        padding: 16px; margin-bottom: 16px; }
.kort > h2 { margin: 0 0 4px; font-size: 15px; font-weight: 650; }
.kort > h2 + p { margin: 0 0 14px; color: var(--ink-2); font-size: 13px; }

/* --- Flaggor (granskningsvyn) ------------------------------------------- */
.flagga { display: inline-flex; align-items: center; gap: 5px; font-size: 11.5px;
          font-weight: 600; padding: 2px 7px; border-radius: 6px;
          border: 1px solid var(--kant); white-space: nowrap; }
.flagga .prick { width: 8px; height: 8px; border-radius: 50%; flex: none; }
.flagga-fel  { color: #b02a2a; } .flagga-fel .prick  { background: var(--kritisk); }
.flagga-varn { color: #8a6000; } .flagga-varn .prick { background: var(--varning); }
.flagga-ok   { color: var(--ink-3); } .flagga-ok .prick { background: var(--okand); }
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) .flagga-fel  { color: #e46a6a; }
  :root:not([data-theme="light"]) .flagga-varn { color: var(--varning); }
}
:root[data-theme="dark"] .flagga-fel  { color: #e46a6a; }
:root[data-theme="dark"] .flagga-varn { color: var(--varning); }

.notis { border-left: 3px solid var(--linje); padding: 2px 0 2px 12px; margin: 12px 0;
         color: var(--ink-2); font-size: 13px; }

.fot-not { margin-top: 28px; padding-top: 14px; border-top: 1px solid var(--linje);
           color: var(--ink-3); font-size: 12px; }

/* --- Smal skärm --------------------------------------------------------- */
@media (max-width: 860px) {
  .patient > summary { grid-template-columns: 1fr 64px; row-gap: 10px; }
  .drivande, .trend, .alder { grid-column: 1 / -1; }
  .alder { text-align: left; }
  .pil { display: none; }
}
@media (max-width: 720px) {
  table.data { display: block; overflow-x: auto; white-space: nowrap; }
}
'
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
