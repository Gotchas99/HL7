Class {
	#name : 'NpoApp',
	#superclass : 'WAComponent',
	#instVars : [
		'docs',
		'allSamples',
		'currentFile'
	],
	#category : 'HL7-NPO',
	#package : 'HL7',
	#tag : 'NPO'
}

{ #category : 'class initialization' }
NpoApp class >> canBeRoot [

	^ true
]

{ #category : 'class initialization' }
NpoApp class >> contextRoot [

	^ 'npo'
]

{ #category : 'class initialization' }
NpoApp class >> initialize [

	self register
]

{ #category : 'class initialization' }
NpoApp class >> register [

	| app |
	app := WAAdmin register: self asApplicationAt: self contextRoot.
	^ app
]

{ #category : 'initialization' }
NpoApp >> children [

	^ #()
]

{ #category : 'formatting' }
NpoApp >> formatTimestamp: s [
	 ^
(s first: 4), '-', (s copyFrom: 5 to: 6), '-', (s copyFrom: 7 to: 8), ' ', (s copyFrom: 9 to: 10), ':', (s copyFrom: 11 to: 12).
]

{ #category : 'initialization' }
NpoApp >> initialize [

	super initialize.
	docs := NpoCareDoc sampleBehandling.
	allSamples:= NpoCareDoc allSamples.
]

{ #category : 'rendering' }
NpoApp >> renderContentOn: html [

	html div
		class: 'omslag';
		with: [ "patientComps do: [ :pat | html render: pat"
			self renderHuvudOn: html.
		docs do: [ :doc |	self renderDoc:doc on: html].
			self renderFooter: html ]
]

{ #category : 'rendering' }
NpoApp >> renderDoc: aDoc on: html [

	html div
		class: 'entry';
		with: [
			html div
				class: 'time';
				with: [
					html strong: (self formatTimestamp: (aDoc at: #timestamp)) ].
			html div
				class: 'category';
				with: (aDoc at: #typ).
			html div
				class: 'title';
				with: (aDoc at: #title).
			(aDoc at: #text) do: [ :txt | self renderNote: txt on: html ].
			html div
				class: 'author';
				with: (aDoc at: #auth).
			html div
				class: 'unit';
				with: (aDoc at: #careUnit) ]
]

{ #category : 'rendering' }
NpoApp >> renderFooter: html [
]

{ #category : 'rendering' }
NpoApp >> renderHuvudOn: html [

	| fileNames  |
	fileNames := allSamples collect: #basenameWithoutExtension.
	html div with: [
		html
			text: 'Patient-ID: ';
			strong: (docs first at: #patId) ].
	html form: [
		html select
			list: fileNames;
			selected:currentFile;
			callback: [ :val |
				currentFile:= val.
				self selectSample: val ];
			onChange: 'this.form.submit()' ]
]

{ #category : 'rendering' }
NpoApp >> renderNote: aNote on: html [

	^ html div
		  class: 'field';
		  with: [
			  html div
				  class: 'label';
				  with: aNote first.
			  html div
				  class: 'value';
				  with: aNote last ]
]

{ #category : 'as yet unclassified' }
NpoApp >> selectSample: aFileName [

	| file |
	currentFile := aFileName .
	file := allSamples detect: [ :f |
		        f basenameWithoutExtension = aFileName ].
	docs := NpoCareDoc new on: file
]

{ #category : 'initialization' }
NpoApp >> style [

	^ '/* NPÖ-viewer – class-based styling, independent of element order.
   Markup contract (any order inside .entry):
     .omslag                 page container
       .patient              patient header
       .entry                one journal entry
         .time               timestamp
         .category           e.g. "Samordning"
         .title              e.g. "Plan för sårbehandling"
         .field              label/value row (zero or more)
           .label
           .value
         .author
         .unit
   Visual order inside .entry is set with `order`, so the generator
   can emit children in any sequence.
*/

:root {
  --bg: #f4f6f8;
  --card: #ffffff;
  --text: #1f2933;
  --muted: #5f6b7a;
  --line: #e3e7ec;
  --accent: #0b5cad;
  --radius: 8px;
}

* { box-sizing: border-box; }

body {
  margin: 0;
  background: var(--bg);
  color: var(--text);
  font: 15px/1.5 system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
}

.omslag {
  max-width: 960px;
  margin: 0 auto;
  padding: 0 16px 48px;
}

/* Patient header */
.patient {
  position: sticky;
  top: 0;
  z-index: 1;
  margin: 0 -16px 24px;
  padding: 14px 16px;
  background: var(--card);
  border-bottom: 1px solid var(--line);
  color: var(--muted);
}
.patient strong {
  color: var(--text);
  font-size: 1.1rem;
  letter-spacing: .02em;
  font-variant-numeric: tabular-nums;
}

/* Entry card: two columns, items placed by `order` + column */
.entry {
  display: grid;
  grid-template-columns: 1fr auto;
  column-gap: 16px;
  margin-bottom: 12px;
  padding: 16px 20px;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: var(--radius);
}

.category {
  order: 1;
  grid-column: 1;
  color: var(--accent);
  font-size: .75rem;
  font-weight: 600;
  letter-spacing: .06em;
  text-transform: uppercase;
}

.time {
  order: 2;
  grid-column: 2;
  color: var(--muted);
  font-size: .875rem;
  font-variant-numeric: tabular-nums;
  white-space: nowrap;
  text-align: right;
}
.time strong { font-weight: 500; }

.title {
  order: 3;
  grid-column: 1 / -1;
  margin-bottom: 8px;
  font-size: 1.05rem;
  font-weight: 600;
}

/* Label / value rows */
.field {
  order: 4;
  grid-column: 1 / -1;
  display: grid;
  grid-template-columns: 13rem 1fr;
  gap: 16px;
  padding: 6px 0;
  border-top: 1px solid var(--line);
}
.label { color: var(--muted); }
.value { white-space: pre-line; }   /* keeps line breaks in values */

/* Footer: author left, unit right */
.author,
.unit {
  order: 5;
  margin-top: 10px;
  padding-top: 10px;
  border-top: 1px solid var(--line);
  color: var(--muted);
  font-size: .85rem;
}
.author { grid-column: 1; }
.unit   { order: 6; grid-column: 2; text-align: right; }

/* Narrow screens: stack label above value */
@media (max-width: 600px) {
  .entry { padding: 14px 16px; }
  .field { grid-template-columns: 1fr; gap: 0; }
  .label { font-size: .8rem; }
}'
]

{ #category : 'initialization' }
NpoApp >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot title: 'NPÖ-viewer'.
	anHtmlRoot meta
		name: 'viewport';
		content: 'width=device-width, initial-scale=1'
]
