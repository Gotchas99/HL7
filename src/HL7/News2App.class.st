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

	super initialize
.	unscored:=#(#abc #def).scored:=#().
]

{ #category : 'initialization' }
News2App >> renderContentOn: html [

	| count |
	"count := 42."
	html heading: 'Hello from Seaside!'.
	"html paragraph: [
		html text: 'Current Count: '.
		html strong: count ]."

	html anchor
		callback: [ self updateUnscored ];
		with: 'Refresh unScored'.
	html table with: [
		html tableHead: [
			html tableRow: [
				html tableHeading: 'Index'.
				html tableHeading: 'Item Value' ] ] .
		html tableBody: [ 
		unscored doWithIndex: [ :item :index |
			html tableRow: [ 
				html tableData: index.
				html tableData: ( item)second ] ] ]].
	html div.
	html space.
	html anchor
		callback: [ self updateScored ];
		with: 'Refresh scored'.
		html table with: [
		html tableHead: [
			html tableRow: [
				html tableHeading: 'Index'.
				html tableHeading: 'Item Value' ] ] .
		html tableBody: [ 
		scored doWithIndex: [ :item :index |
			html tableRow: [ 
				html tableData: index.
				html tableData: ( item)second ] ] ]].
]

{ #category : 'initialization' }
News2App >> updateScored [
]

{ #category : 'initialization' }
News2App >> updateUnscored [
	unscored := News2 new  findPending
]
