Class {
	#name : #BaselineOfHL7,
	#superclass : #BaselineOf,
	#category : #BaselineOfHL7
}

{ #category : #baselines }
BaselineOfHL7 >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'SQLite3'
			with: [ spec repository: 'github://pharo-rdbms/Pharo-SQLite3/src' ].
			spec 
			package: #HL7 with: [ spec requires: 'SQLite3' ].
		spec group: 'default' with: #( 'HL7' ) ]
]
