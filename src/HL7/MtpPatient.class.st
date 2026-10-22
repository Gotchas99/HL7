Class {
	#name : 'MtpPatient',
	#superclass : 'WAComponent',
	#instVars : [
		'pat',
		'riskTexts',
		'riskStyles'
	],
	#category : 'HL7-NEWS2',
	#package : 'HL7',
	#tag : 'NEWS2'
}

{ #category : 'initialization' }
MtpPatient >> initRiskMappings [

	riskTexts := {
		             ('Low' -> 'Låg').
		             ('Low/Medium' -> 'Låg/medium').
		             ('Medium' -> 'Medium').
		             ('High' -> 'Hög') } asDictionary.
	riskStyles := { ('Low' -> 'status-god').
	 ('Low/Medium' -> 'status-varning').
		             ('Medium' -> 'status-allvar').
		             ('High' -> 'status-kritisk')  } asDictionary
]

{ #category : 'initialization' }
MtpPatient >> initialize [

	super initialize.
	self initRiskMappings
]

{ #category : 'accessing' }
MtpPatient >> patient:p [
pat:= p
]

{ #category : 'rendering' }
MtpPatient >> renderBidrag: bidrag on: html [

	html span
		class: 'bidrag';
		with: [
			html tag: 'b' with: bidrag first.
			html text: ' ',bidrag second ]
]

{ #category : 'rendering' }
MtpPatient >> renderContentOn: html [

	self renderPatientOn: html
]

{ #category : 'rendering' }
MtpPatient >> renderDrivandeOn: html [

	| bidrag |
	bidrag := OrderedCollection new.
	bidrag add: 'Andningsfrekvens'.
	bidrag add: ('{1}/min · {2} p' format: {
				 (pat at: 'resp_rate').
				 (pat at: 'resp_score') }).
	bidrag add: 'Syremättnad'.
	bidrag add: ('{1}% · {2} p' format: {
				 (pat at: 'spo2').
				 (pat at: 'spo2_scale1_score') }).
	bidrag add: 'Puls'.
	bidrag add: ('{1}/min · {2} p' format: {
				 (pat at: 'pulse').
				 (pat at: 'pulse_score') }). 
	bidrag add: 'Systoliskt'.
	bidrag add: ('{1}mmHg · {2} p' format: {
				 (pat at: 'systolic').
				 (pat at: 'systolic_score') }).
	bidrag add: 'Temperatur'.
	bidrag add: ('{1} °C · {2} p' format: {
				 (pat at: 'temperature').
				 (pat at: 'temp_score') }).
	bidrag pairsDo: [ :parm :val |
		self
			renderBidrag: {
					parm.
					val }
			on: html ]
]

{ #category : 'rendering' }
MtpPatient >> renderHarledningOn: html [

	html div
		style: 'display:none'; 
		class: 'harledning';
		with: [
			html heading
				level3;
				with: 'Härledning — alla sju komponenter'.
			html table
				class: 'data';
				with: [
					html tableHead: [
							html tableRow: [
									html tableHeading: 'Komponent'.
									html tableHeading
										class: 'num';
										with: 'Värde'.
									html tableHeading: 'Enhet'.
									html tableHeading
										class: 'num';
										with: 'Poäng'.
									html tableHeading
										class: 'num';
										with: 'Kategori'.
									html tableHeading
										class: 'num';
										with: 'Ursprung'.
									html tableHeading
										class: 'num';
										with: 'Bearbetning'.
									html tableHeading
										class: 'num';
										with: 'Ålder' ] ] ] ]
]

{ #category : 'rendering' }
MtpPatient >> renderPatientOn: html [

	html details
		class: 'patient';
		with: [
			html summary: [
					html div
						class: 'sang';
						with: [
							html
								text: 'IVA-03';
								tag: 'b' with: (pat at: 'namn');
								text: (pat at: 'personnr') ].
					html div
						class: 'poang';
						with: [
							html div
								class: 'varde';
								with: (pat at: 'total_score').
							html div
								class: 'av';
								with: 'NEWS2' ].
					html div
						class: 'drivande';
						with: [ self renderDrivandeOn: html ].
					html div
						class: 'trend';
						with: [ html tag: 'b' with: '<trendgraf>' ].
					html div
						class: 'alder';
						with: [
							html span
								class: 'status';
								class: (riskStyles at:(pat at: 'risk_category')ifAbsent: ['status-okand']);
								with: [
									html span class: 'prick'.
									html text: (riskTexts
												 at: (pat at: 'risk_category')
												 ifAbsent: [ pat at: 'risk_category' ]) ].
							html div
								class: 'sent';
								with: '' ]
					"html div
						class: 'pil';
						with: [ html html: '&#9654;' ] " ].
			self renderHarledningOn: html ]
]
