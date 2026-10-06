Class {
	#name : 'News2App',
	#superclass : 'WAComponent',
	#instVars : [
		'unscored',
		'scored'
	],
	#category : 'HL7-NEWS2',
	#package : 'HL7',
	#tag : 'NEWS2'
}

{ #category : 'class initialization' }
News2App class >> initialize [
	WAAdmin register: self asApplicationAt: 'news2'
]

{ #category : 'initialization' }
News2App >> initialize [

	super initialize.
	unscored := #(  ).
	scored := #(  )
]

{ #category : 'initialization' }
News2App >> renderContentOn: html [

	html heading: 'Hello from Seaside!'.

	html anchor
		callback: [ self updateUnscored ];
		with: 'Refresh unScored'.
	html table with: [
		html tableHead: [
			html tableRow: [
				html tableHeading: 'Index'.
				html tableHeading: 'comp_id' ] ].
		html tableBody: [
			unscored doWithIndex: [ :item :index |
				html tableRow: [
					html tableData: index.
					html tableData: item second ] ] ] ].
	html div.

	html anchor
		callback: [ self scoreAll ];
		with: 'Run scoring engine'.
	html div.

	html anchor
		callback: [ self updateScored ];
		with: 'Refresh scored'.
	html table with: [
		html tableHead: [
			html tableRow: [
				html tableHeading: 'Index'.
				html tableHeading: 'comp id'.
				html tableHeading: 'timestamp'.
				html tableHeading: 'score' ] ].
		html tableBody: [
			scored doWithIndex: [ :item :index |
				html tableRow: [
					html tableData: index.
					html tableData: item second.
					"html tableData: item third.
					html tableData: item fifth" ] ] ] ]
]

{ #category : 'initialization' }
News2App >> scoreAll [

	News2 new scoreAllPending .
]

{ #category : 'initialization' }
News2App >> updateScored [

	scored := News2 new getScored 
]

{ #category : 'initialization' }
News2App >> updateUnscored [

	unscored := News2 new getUnscored 
]
