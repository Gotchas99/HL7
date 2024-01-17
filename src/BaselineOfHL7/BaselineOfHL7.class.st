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
			package: #'HL7';
			package: #'HL7-Tests' with: [ spec requires: #( #'HL7' ) ];
			package: #'HL7-Gui' with: [ spec requires: #( #'HL7' ) ].
		spec
			group: 'Core' with: #( 'HL7' );
			group: 'CoreTests' with: #( 'HL7-Tests' );
			group: 'default' with: #( 'HL7'  ) ]
		"original:
		spec
			package: #'HL7';
			package: #'HL7-Tests' with: [ spec requires: #( #'HL7' ) ];
			package: #'HL7-Gui' with: [ spec requires: #( #'HL7' ) ].
		spec
			group: 'Core' with: #( 'HL7' );
			group: 'CoreTests' with: #( 'HL7-Tests' );
			group: 'default' with: #( 'HL7' 'HL7-Gui' )"
]
