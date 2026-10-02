Class {
	#name : 'News2App',
	#superclass : 'WAComponent',
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
]

{ #category : 'initialization' }
News2App >> renderContentOn: html [

	| count |
	count:=42.
	html heading: 'Hello from Seaside!'.
	html paragraph: [
		html text: 'Current Count: '.
		html strong: count ].

	html anchor
		callback: [ count := count + 1 ];
		with: 'Increment'.
	html space.
	html anchor
		callback: [ count := count - 1 ];
		with: 'Decrement'
]
