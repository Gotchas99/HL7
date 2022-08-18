Class {
	#name : #H7Message,
	#superclass : #H7Entity,
	#category : #'HL7-Core'
}

{ #category : #'as yet unclassified' }
H7Message class >> adtA08 [

	^ 'MSH|^~\&|SE2321000131-S000000014219|SE2321000131-E000000000001|SE2321000131-S000000014080|SE2321000131-E000000000001|20220419111149.484+0200||ADT^A08|56CBC5E2664043BBA5D606AD9AC6A91B|P|2.3.1||||||UNICODE EVN| 
PID|||199501011001||Testett^Berit^^^""||19950101|F|||Mammovägen 1^^Uddevalla^^451 61|""|""^^^""^^^^^0708787878|""|||||||||||||||""'
]

{ #category : #'as yet unclassified' }
H7Message class >> genAck [

	^ 'MSH|^~\&|LAB|767543|ADT|767543|19900314130405||ACK^A08^ACK|XX3657|P|2.5
MSA|AA|ZZ9380'
]

{ #category : #'as yet unclassified' }
H7Message class >> ormO01 [

	^ 'MSH|^~\&amp;|SE2321000131-S000000014219|SE2321000131-E000000000001|SE2321000131-S000000014080|SE2321000131-E000000000001|20220512081253.208+0200||ORM^O01|B9E506DB27454F078CFDF4A373E53232|P|2.3.1||||||UNICODE
PID|||198008088888||MILLENNIUMMB^SARA^^^""||19800808|F|||SÅGAREGATAN 3B^^TROLLHÄTTAN^^""|""|||||||||||||||||""
PV1||205002|Akutmottagning|||||""^test^
ORC|SC|326028857|TESTSEMUDD005306||Requested||^^^""||20220512081253.208+0200|||""^test|||||SE2321000131-E000000007407||||SÄS/B Onkologimottagning, Borås^^^^^^^^^SE2321000131-E000000011480
OBR||326028857|TESTSEMUDD005306|66202^Cancerkontroll i screeningprogrammet|||""|""|||""||ASV1 test anamnes\X0A\--------------------\X0A\Gravid: Nej\X0A\Forskningsstudie: Nej\X0A\Undersökningsmetod får ändras utan att remitterande enhet meddelas: Ja\X0A\Ange sida: Dx\X0A\Cancerkontroller i screeningprogrammet till och med år: ja, 2020-0909|||""^test||||TESTSEMUDD006872|""|||""|||^^^^^R|SE2321000131-E000000002911^""|||^Test - _.,"\T\%/()!ÅÄÖ ?||||||||||||||
ZDS|1.2.752.24.5.3470033719.20220512081253.6872
'
]

{ #category : #'as yet unclassified' }
H7Message class >> sample1 [
^'MSH|^~\&|EPIC|EPICADT|SMS|SMSADT|199912271408|CHARRIS|ADT^A04|1817457|D|2.5|
PID||0493575^^^2^ID 1|454721||DOE^JOHN^^^^|DOE^JOHN^^^^|19480203|M||B|254 MYSTREET AVE^^MYTOWN^OH^44123^USA||(216)123-4567|||M|NON|400003403~1129086|
NK1||ROE^MARIE^^^^|SPO||(216)123-4567||EC|||||||||||||||||||||||||||
PV1||O|168 ~219~C~PMA^^^^^^^^^||||277^ALLEN MYLASTNAME^BONNIE^^^^|||||||||| ||2688684|||||||||||||||||||||||||199912271408||||||002376853'.
]

{ #category : #'instance creation' }
H7Message >> separators [
"Segment Terminator <cr> - Terminates a segment record. This value cannot be 
changed by implementers. 
Field Separator | - Separates two adjacent data fields within a 
segment. It also separates the segment ID from the 
first data field in each segment. 
Component Separator ^ 1 Separates adjacent components of data fields where 
allowed. 
Subcomponent Separator & 4 Separates adjacent subcomponents of data fields 
where allowed. If there are no subcomponents, this 
character may be omitted. 
Repetition Separator ~ 2 Separates multiple occurrences of a field where 
allowed. 
Escape Character \ 3 Escape character for use with any field represented 
by an ST, TX or FT data type, or for use with the 
data (fourth) component of the ED data type. If no 
escape characters are used in a message, this 
character may be omitted. However, it must be 
present if subcomponents are used in the message"
]