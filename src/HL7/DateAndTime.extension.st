Extension { #name : 'DateAndTime' }

{ #category : '*HL7' }
DateAndTime class >> readYMDHMSfromDigits: stream [
	"Read a separate Date and Time from stream to instanciate the receiver.
	See also #printSeparateDateAndTimeOn:"

	"sample: 20171217123850"

	| date time tmp |
	date := (DateParser
		         readingFrom: (stream next: 8) readStream
		         pattern: 'yyyymmdd') parse.
			time := Time
		        hour: (stream next: 2) asInteger
		        minute: (stream next: 2) asInteger
		        second: 00.
	stream atEnd ifFalse: [
		time := time addSeconds: (stream next: 2) asInteger ].
	tmp:= self date: date time: time.
		stream atEnd ifFalse: [tmp offset: (self readTimezoneOffsetFrom: stream)].
^tmp
]
