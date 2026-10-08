"
A News2Test is a test class for testing the behavior of News2
"
Class {
	#name : 'News2Test',
	#superclass : 'TestCase',
	#category : 'HL7-NEWS2',
	#package : 'HL7',
	#tag : 'NEWS2'
}

{ #category : 'running' }
News2Test >> setUp [

	super setUp

	"Put here a common initialization logic for tests"
]

{ #category : 'tests' }
News2Test >> testX [

	| res |
	res := H7Segment new parseFields: #( 'DOE^JOHN^^^^' '19480203'
	          '' ).
	self assert: res isArray.
	self assert: res size equals: 3.
	self
		assert: res first
		equals: #( 'DOE' 'JOHN' '' '' '' '' ) asOrderedCollection.
	self assert: res second equals: '19480203'.
	self assertEmpty: res third
]
