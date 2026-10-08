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
	unscored := scored:= #(  ).
self updateUnscored ;updateScored .
]

{ #category : 'rendering' }
News2App >> renderContentOn: html [
	"html tableData: item third.
					html tableData: item fifth"

	html heading: 'Hello from Seaside!'.
	self renderUnscored: html.
	html div.
	html anchor
		callback: [ self scoreAll ];
		with: 'Run scoring engine'.
	html div.
	self renderScored: html
]

{ #category : 'rendering' }
News2App >> renderScored: html [

	html anchor
		callback: [ self updateScored ];
		with: 'Refresh scored'.
	html table with: [
		html tableHead: [
			html tableRow: [
				html tableHeading: 'Index'.
				html tableHeading: 'total score'.
				html tableHeading: 'timestamp'.
				html tableHeading: 'score' ] ].
		html tableBody: [
			scored doWithIndex: [ :item :index |
				html tableRow: [
					html tableData: index.
					html tableData: (item at:'news2-christer/national_early_warning_score_2_news2/total_score') ] ] ] ]
]

{ #category : 'rendering' }
News2App >> renderUnscored: html [

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
					html tableData: item second ] ] ] ]
]

{ #category : 'actions' }
News2App >> scoreAll [

	News2 new scoreAllPending .
]

{ #category : 'actions' }
News2App >> updateScored [

	scored := News2 new getScored 
]

{ #category : 'actions' }
News2App >> updateUnscored [

	unscored := News2 new getUnscored 
]
