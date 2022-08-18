"
A H7SegmentTest is a test class for testing the behavior of H7Segment
"
Class {
	#name : #H7SegmentTest,
	#superclass : #TestCase,
	#category : #'HL7-Tests'
}

{ #category : #running }
H7SegmentTest >> setUp [
	super setUp. 
	
	"Put here a common initialization logic for tests"
]

{ #category : #tests }
H7SegmentTest >> testParse2Flds [

	| res |
	res := H7Segment new parseFields: #( 'DOE^JOHN^^^^' '19480203'
	          '' ).
	self assert: res isArray.	self assert: res size equals:3..
	self
		assert: res first
		equals: #( 'DOE' 'JOHN' '' '' '' '' ) asOrderedCollection.
	self assert: res second equals: '19480203'.
	self assertEmpty: res third
]

{ #category : #tests }
H7SegmentTest >> testParseBlank [

	| res |
	res := H7Segment new parseField: ''. self assertEmpty: res
]

{ #category : #tests }
H7SegmentTest >> testParseMultiFld [

	| res |
	res := H7Segment new parseField: 'DOE^JOHN^^^^'.
	self assert: res equals: #('DOE' 'JOHN' '' '' '' '')asOrderedCollection 
]

{ #category : #tests }
H7SegmentTest >> testParseSingleFld [

	| res |
	res := H7Segment new parseField: '19480203'.
	self assert: res equals:'19480203'
]
