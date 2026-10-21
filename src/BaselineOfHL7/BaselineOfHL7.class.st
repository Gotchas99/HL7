Class {
	#name : 'BaselineOfHL7',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfHL7',
	#package : 'BaselineOfHL7'
}

{ #category : 'baselines' }
BaselineOfHL7 >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec spec 
			baseline: 'NeoJSON'
			with: [ spec repository: 'github://svenvc/NeoJSON/repository' ];
			baseline: 'NeoConsole'
			with: [ spec repository: 'github://svenvc/NeoConsole/src' ];
			baseline: 'SQLite3'
			with: [ spec repository: 'github://pharo-rdbms/Pharo-SQLite3/src' ];
			baseline: 'ODBC'
			with: [ spec repository: 'github://Gotchas99/Pharo-ODBC/src' ];
			baseline: 'Bootstrap5'
			with: [
				spec repository: 'github://astares/Seaside-Bootstrap5:master/src' ];
			baseline: 'Seaside3'
			with: [
				spec repository: 'github://SeasideSt/Seaside:master/repository' ].
		spec package: #HL7 with: [ spec requires: 'SQLite3' ].
		spec group: 'default' with: #( 'HL7' ) ]
]
