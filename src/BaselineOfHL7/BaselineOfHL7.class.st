Class {
	#name : #BaselineOfHL7,
	#superclass : #BaselineOf,
	#category : #BaselineOfHL7
}

{ #category : #baselines }
BaselineOfHL7 >> baseline: spec [

	<baseline>
	spec for: #common do: [ 		spec package: #HL7.
		spec group: 'default' with: #( 'HL7' ) ]
]
