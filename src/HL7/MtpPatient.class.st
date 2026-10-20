Class {
	#name : 'MtpPatient',
	#superclass : 'WAComponent',
	#instVars : [
		'pat'
	],
	#category : 'HL7-NEWS2',
	#package : 'HL7',
	#tag : 'NEWS2'
}

{ #category : 'initialization' }
MtpPatient >> initialize [

	super initialize.
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
	bidrag := #( 'Andningsfrekvens' '25/min · 3 p' 'Syremättnad'
	             '91 % · 2 p' 'Puls' '131/min · 3 p' 'Systoliskt'
	             '92 mmHg · 2 p' ).
	bidrag pairsDo: [ :parm :val |
		self
			renderBidrag: {
					parm.
					val }
			on: html ]
]

{ #category : 'rendering' }
MtpPatient >> renderPatientDetailsOn: html [

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
								tag: 'b' with: 'Testsson, Carin';
								text: '19720305-3182' ].
					html div
						class: 'poang';
						with: [
							html div
								class: 'varde';
								with: '11'.
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
								class: 'status-kritisk';
								with: [html span class:'prick'.html text:'Hög'].html div class:'sent';with:'äldsta delvärde 12 min' ].
					html div
						class: 'pil';
						with: [ html html: '&#9654;' ] ].
			self renderPatientDetailsOn: html ]
]
