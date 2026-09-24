Class {
	#name : 'DoseParts',
	#superclass : 'Object',
	#instVars : [
		'flds',
		'bodyPart'
	],
	#category : 'HL7-Dose',
	#package : 'HL7',
	#tag : 'Dose'
}

{ #category : 'instance creation' }
DoseParts >> from: coll [

	| obsTime  |

	obsTime := coll first obsTime.
	bodyPart := (coll  detect: [ :f | f id = 'BODYPART' ])value.
		flds := coll reject: [ :f | f id = 'BODYPART' ] .
]
