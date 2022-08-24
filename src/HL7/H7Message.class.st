Class {
	#name : #H7Message,
	#superclass : #H7Entity,
	#instVars : [
		'segments'
	],
	#category : #'HL7-Core'
}

{ #category : #'as yet unclassified' }
H7Message class >> adtA08 [

	^ 'MSH|^~\&|SE2321000131-S000000014219|SE2321000131-E000000000001|SE2321000131-S000000014080|SE2321000131-E000000000001|20220419111149.484+0200||ADT^A08|56CBC5E2664043BBA5D606AD9AC6A91B|P|2.3.1||||||UNICODE 
	EVN| 
PID|||199501011001||Testett^Berit^^^""||19950101|F|||Mammovägen 1^^Uddevalla^^451 61|""|""^^^""^^^^^0708787878|""|||||||||||||||""'
]

{ #category : #'as yet unclassified' }
H7Message class >> adtA08_2 [

	^ 'MSH|^~\&|^SE2321000131-S000000018276^L|^SE2321000131-E000000000001^L|^SE2321000131-S000000018326^L|^SE2321000131-E000000000001^L|202205120349220009+020||ADT^A08|vgas1popAYC19NK51||2.4||||||8859/1 
	EVN|A08|20220512034922.5170+0200 
	PID||196707113822^^^VGR|196707113822^^^VGR^PI||Hannooka^Dina^Fouad Hannooka^^^^L||19670711^D|F|^DINA^^^^^N||LJUNGKULLEN 40 LGH 1201^""^SÄVEDALEN^1402^43366^^P^""^1402|||||W^^HL70002^A^^SKV civilstand|||||||BAGDAD, IRAK|||SE^^HL70399||SE^^HL70399'
]

{ #category : #'as yet unclassified' }
H7Message class >> adtA40 [

	^ 'MSH|^~\&|^SE2321000131-S000000018276^L|^SE2321000131-E000000000001^L|^SE2321000131-S000000018326^L|^SE2321000131-E000000000001^L|202205191500360009+020||ADT^A40^ADT_A40|vgas1popAYDcZ97/1a||2.4||||||8859/1 
	EVN|A40|20220519150036 
	PID||200710110552^^^VGR^PI|200710110552^^^VGR^PI||Ibrahim^Adam^Walid^^^^L||20071011^D|M|^ADAM^^^^^N||BÅTSMANSDALSGATAN 31^""^ANGERED^1480^42432^^P^""^1480|||||S^^HL70002^OG^^SKV civilstand|||||||BERGSJÖN, Västra Götalands län|||SE^^HL70399||SE^^HL70399 MRG|20071011F099^^^VGR^PI'
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
H7Message class >> ormO01_2 [

	^ 'MSH|^~\&|^SE2321000131-S000000018276^L|^SE2321000131-E000000001754^L|^SE2321000131-S000000018326^L|^SE2321000131-E000000000001^L|20220608234459||ORM^O01^ORM_O01|15977128|P|2.4||||||8859/1 
	PID||202002090674|202002090674^^^Skatteverket&1.2.752.59&ISO^NNSWE||Krook^Oliwer^Carl Lukas||20200209|M|Krook^Oliwer^^^^^B||NORRA BREVIKSVÄGEN 72^^VÄSTRA FRÖLUNDA^1480^42167^SWE||||||||||||Göteborg 
	PV1||I||||||||||||||||H4|VGRSU79008193 
	ORC|SC|QPREQUEST_2299375^IPLAN^IPLAN^L|SU79008193^^SE2321000131-S000000014008^L|SU_2820770|IP||^^^20220608211200^^R||20220608211242|EI_MEDILINK||SARPE1^Persson^Sara|SE2321000131-E000000007305||||SE2321000131-E000000001754||||^^^^^^^^^SE2321000131-E000000007305||||44^UTFÖRD^QPORDER 
	OBR||QPREQUEST_2299375^IPLAN^IPLAN^L|SU79008193^^SE2321000131-S000000014008^L|460000^Buköversikt^SE2321000131-E000000001754^QPREQUESTTOPIC_2477698|R|20220608211200|20220608233945|20220608234458|||||Anamnes:\.br\Pojke som svalt mageneter. \.br\Tacksam kontroll avläge innan vi tar upp honom till op.\.br\\.br\Frågeställning:\.br\Läge av magneter\.br\\.br\Tilläggsinformation: Vi ringer när vi  vill gå till röngten.|||SARPE1^Persson^Sara||SU79008193||SU79008193||20220608234459||SE2321000131-E000000007305|O||^^^20220608211200^^R|||||||||20220608211200 
	ZDS|1.3.51.0.1.1.172.16.20.234.79008193.79731522'
]

{ #category : #'as yet unclassified' }
H7Message class >> sample1 [
^'MSH|^~\&|EPIC|EPICADT|SMS|SMSADT|199912271408|CHARRIS|ADT^A04|1817457|D|2.5|
PID||0493575^^^2^ID 1|454721||DOE^JOHN^^^^|DOE^JOHN^^^^|19480203|M||B|254 MYSTREET AVE^^MYTOWN^OH^44123^USA||(216)123-4567|||M|NON|400003403~1129086|
NK1||ROE^MARIE^^^^|SPO||(216)123-4567||EC|||||||||||||||||||||||||||
PV1||O|168 ~219~C~PMA^^^^^^^^^||||277^ALLEN MYLASTNAME^BONNIE^^^^|||||||||| ||2688684|||||||||||||||||||||||||199912271408||||||002376853'.
]

{ #category : #'instance creation' }
H7Message class >> separators [
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

{ #category : #accessing }
H7Message >> at: anIndex [ 

	^ segments at: anIndex 
]

{ #category : #accessing }
H7Message >> at: anIndex ifAbsent: aBlock [
^segments  at: anIndex ifAbsent: aBlock
]

{ #category : #'as yet unclassified' }
H7Message >> segs:arrayOfSegments [
segments :=arrayOfSegments 
]

{ #category : #accessing }
H7Message >> size [ ^segments size
]
