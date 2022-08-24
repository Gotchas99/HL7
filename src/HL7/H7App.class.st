Class {
	#name : #H7App,
	#superclass : #SpApplication,
	#instVars : [
		'email',
		'password'
	],
	#category : #'HL7-Gui'
}

{ #category : #activation }
H7App class >> applicationName [
^'new hl7 app'
]

{ #category : #examples }
H7App class >> run [

	<example>
	self new run
]

{ #category : #running }
H7App >> start [

	(self new: H7PresenterMain) open
]
