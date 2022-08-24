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
			package: #'HL7-Core';
			package: #'HL7-Tests' with: [ spec requires: #( 'Beacon-Core' ) ];
			package: #'HL7-Gui' with: [ spec requires: #( #'Beacon-Core' ) ].
		spec
			group: 'Core' with: #( 'HL7-Core' );
			group: 'CoreTests' with: #(  'HL7-Tests' );
			group: 'default'
			with:
				#( 'HL7-Core' 'HL7-Gui' ) ]
]
