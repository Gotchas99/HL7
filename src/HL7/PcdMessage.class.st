Class {
	#name : 'PcdMessage',
	#superclass : 'Object',
	#instVars : [
		'mds',
		'hl7'
	],
	#category : 'HL7-PCD',
	#package : 'HL7',
	#tag : 'PCD'
}

{ #category : 'instance creation' }
PcdMessage class >> from: aH7Msg [

	^self new from: aH7Msg

	
]

{ #category : 'as yet unclassified' }
PcdMessage class >> sample_ix_manual [

	^'MSH|^~\&|||||20200302125446.694-0500||ORU^R01^ORU_R01|HP0302125446.694KEV-DEV123|P|2.6|||AL|NE||8859/1|EN^English^ISO639||IHE_PCD_001^IHE PCD^1.3.6.1.4.1.19376.1.6.1.1.1^ISO 
PID|1|121212-1212|""^^^Philips^MR||”Tolvansson"^”Tolvan"^”Sr"^^^^L||""|"" 
PV1|2|I|My Unit^^KPBed 
OBR|3||0009fbFFFF2d1771^^^EUI-64|69965^MDC_DEV_MON_PHYSIO_MULTI_PARAM_MDS^MDC|||20200302125445.761-0500 
OBX|4||69965^MDC_DEV_MON_PHYSIO_MULTI_PARAM_MDS^MDC|1.0.0.0|||||||X|||||||92725e7d-414f-4a29-9eeb-364d83c336f2 IntelliVue MX800 - 865240 
OBX|5||127822^NOM_DEV_SPOTCHECK_VMD^MDC|1.1.0.0|||||||X|||||||DE70402405 
OBX|6||127823^NOM_DEV_SPOTCHECK_CHAN^MDC|1.1.1.0|||||||X 
OBX|7|ST|195058^NOM_SCORE_SPS^MDC|1.1.1.1|1|||W|||R|||20200305125423||||| 
OBX|8|NM|149538^MDC_PULS_OXIM_PULS_RATE^MDC|1.1.1.2|60|264864^MDC_DIM_BEAT_PER_MIN^MDC||N|||R|||20200302125411||||| 
OBX|9|NM|150021^MDC_PRESS_BLD_NONINV_SYS^MDC|1.1.1.3|120|266016^MDC_DIM_MMHG^MDC||N|||R|||20200302125423||||| 
OBX|10|NM|150022^MDC_PRESS_BLD_NONINV_DIA^MDC|1.1.1.4|60|266016^MDC_DIM_MMHG^MDC||N|||R|||20200302125423||||| 
OBX|11|NM|150023^MDC_PRESS_BLD_NONINV_MEAN^MDC|1.1.1.5|80|266016^MDC_DIM_MMHG^MDC||N|||R|||20200302125423||||| 
OBX|12|NM|151570^MDC_AWAY_RESP_RATE^MDC|1.1.1.6|60|264928^MDC_DIM_RESP_PER_MIN^MDC||W|||R|||20200302125414||||| 
OBX|13|NM|150456^MDC_PULS_OXIM_SAT_O2^MDC|1.1.1.7|95|262688^MDC_DIM_PERCENT^MDC||N|||R|||20200302125408||||| 
OBX|14|ST|194955^NOM_PATIENT_STATUS_CONCERN^MDC|1.1.1.8|0|||N|||R|||20200302125419||||| 
OBX|15|ST|195063^NOM_PATIENT_STATUS_CONSCIOUSNESS^MDC|1.1.1.9|0|||N|||R|||20200302125421||||| 
OBX|16|NM|150344^MDC_TEMP^MDC|1.1.1.10|37.0|268192^MDC_DIM_DEGC^MDC|||||R|||20200302125416|||||
'
]

{ #category : 'instance creation' }
PcdMessage >> from: aH7Msg [

	| obxs vals  |
	aH7Msg isPCD ifFalse: [ self error: 'Not a PCD message' ].
	hl7 := aH7Msg.
	obxs := hl7 segments select: [ :seg | seg segType = 'OBX' ].
	vals := obxs collect: [ :o | PcdValue from: o ].
	mds := Iso11073 from: vals first.
	vals allButFirst do: [ :val | mds add: (Iso11073 from: val) ]
]

{ #category : 'accessing' }
PcdMessage >> getIdNo: anIdNo [

	^ mds getIdNo: anIdNo
]

{ #category : 'accessing' }
PcdMessage >> getMultiIdNo: anIdNos [

	| tmp |
	tmp := anIdNos collect: [ :anIdNo | (mds getIdNo: anIdNo)value ].
	^ tmp
]

{ #category : 'accessing' }
PcdMessage >> getNode: aSubId [

	^mds getNode:aSubId
]

{ #category : 'accessing' }
PcdMessage >> hl7 [ ^hl7
]

{ #category : 'instance creation' }
PcdMessage >> mds [ ^mds
]
