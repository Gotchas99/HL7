Extension { #name : #DateAndTime }

{ #category : #'*HL7' }
DateAndTime class >> readYMDHMSfromDigits: stream [

	"Read a separate Date and Time from stream to instanciate the receiver.
	See also #printSeparateDateAndTimeOn:"

	"sample: 20171217123850"

	| date time |
	date := (DateParser
		         readingFrom: (stream next: 8) readStream
		         pattern: 'yyyymmdd') parse.
	time := Time
		        hour: (stream next: 2) asInteger
		        minute: (stream next: 2)asInteger
		        second: (stream next: 2)asInteger.
	^ self date: date time: time
]
