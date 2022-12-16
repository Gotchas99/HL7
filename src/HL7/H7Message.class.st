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
H7Message class >> ormO01_3 [

	^ 'MSH|^~\&|TQMDOSE|QAELUM|RECEIVING_APP|RECEIVING_FAC|20180110084811||ORM^O01^ORM_O01|20180110084811000953|P|2.5
PID|1||123||Unknown^Unknown||19570609|F
OBR|1||12345|Schoulder Right^RX RIGHT SHOULDER / CLAVICULA|||20171217123850|20171217155755||||||||||||2|CR
OBX|1|TX|^DAP^DCM|0|2.925|dGy.cm²|||||F|||20171217123850|||110180^1.3.51.0.1.1.111.4.52.13.976974.123
OBX|2|TX|113839^EFFECTIVE_DOSE_103^DCM|0|0.0620099999999|mSv|||||F|||20171217123850|||110180^1.3.51.0.1.1.111.4.52.13.976974.123
OBX|3|TX|113812^EVENTS^DCM|0|1|#|||||F|||20171217123850|||110180^1.3.51.0.1.1.111.4.52.13.976974.123
OBX|4|TX|123014^BODYPART^DCM|0|CHEST|NONE|||||F|||20170211080522|||110180^1.3.51.0.1.1.111.4.52.13.976974.123
OBX|5|TX|^DAP^DCM|1|2.925|dGy.cm²|||||F|||20171217155755|||112002^1.3.46.670589.30.1.6.1.9633337701234
OBX|6|TX|113839^EFFECTIVE_DOSE_103^DCM|1|0.0620099999999|mSv|||||F|||20171217155755|||112002^1.3.46.670589.30.1.6.1.9633337701234
OBX|7|TX|121065^SERIES_DESCRIPTION^DCM|1|AP||||||F|||20171217155755|||112002^1.3.46.670589.30.1.6.1.9633337701234
OBX|8|TX|125203^ACQUISITION_PROTOCOL^DCM|1|Schouder||||||F|||20171217155755|||112002^1.3.46.670589.30.1.6.1.9633337701234
OBX|9|TX|123014^BODYPART^DCM|1|CHEST|NONE|||||F|||20171217155755|||112002^1.3.46.670589.30.1.6.1.9633337701234'
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

{ #category : #'as yet unclassified' }
H7Message class >> spot [

	^ 'MSH|^~\&|CDIS-NCE|WelchAllynTest|EMR|HIS|20200219162355+0100||ORU^R01^ORU_R01|20200219162355285-100061390819|P|2.6|||AL|NE|||||IHE_PCD_ORU_R01^IHE_PCD^1.3.6.1.4.1.19376.1.6.1.1.1^ISO
PID|1||191212121212^^^X^PI||Krank^Kalle^T^^^^L||19121212|M
PV1|1|I|WATESTUTB1|1193^^
OBR|1||20200219162355|S^S|||20200219162358+0100|||HSAID123|||||||||||||||F||||||2TS|||HSAID123||||||||||
OBX|1|NM|151562^MDC_RESP_RATE^MDC|1.1.1.25|16|264928^MDC_DIM_RESP_PER_MIN^MDC|||||F|||20200219162358+0100||HSAID123|Manual^|100061390819^Connex Spot Monitor^75ME||
OBX|2|NM|150021^MDC_PRESS_BLD_NONINV_SYS^MDC|1.0.1.1|125|266016^MDC_DIM_MMHG^MDC|||||F|||20200219162358+0100||HSAID123|Manual^|100061390819^Connex Spot Monitor^75ME||||
OBX|3|NM|150022^MDC_PRESS_BLD_NONINV_DIA^MDC|1.0.1.2|89|266016^MDC_DIM_MMHG^MDC|||||F|||20200219162358+0100||HSAID123|Manual^|100061390819^Connex Spot Monitor^75ME||||'
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
