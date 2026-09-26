Class {
	#name : 'News2',
	#superclass : 'Object',
	#instVars : [
		'mds',
		'hl7'
	],
	#category : 'HL7-Other',
	#package : 'HL7',
	#tag : 'Other'
}

{ #category : 'as yet unclassified' }
News2 class >> sample_composition [
^'{
    "news2-christer/category|terminology": "openehr",
    "news2-christer/category|value": "event",
    "news2-christer/category|code": "433",
    "news2-christer/context/start_time": "2026-09-23T14:00:00",
    "news2-christer/context/setting|value": "secondary medical care",
    "news2-christer/context/setting|terminology": "openehr",
    "news2-christer/context/setting|code": "232",
    "news2-christer/respiration/any_event:0/rate|unit": "/min",
    "news2-christer/respiration/any_event:0/rate|magnitude": 18.0,
    "news2-christer/respiration/any_event:0/time": "2026-09-23T15:27:35.528873387Z",
    "news2-christer/respiration/language|code": "en",
    "news2-christer/respiration/language|terminology": "ISO_639-1",
    "news2-christer/respiration/encoding|code": "UTF-8",
    "news2-christer/respiration/encoding|terminology": "IANA_character-sets",
    "news2-christer/pulse_oximetry/any_event:0/spo": 0.98,
    "news2-christer/pulse_oximetry/any_event:0/spo|type": 3,
    "news2-christer/pulse_oximetry/any_event:0/spo|numerator": 98.0,
    "news2-christer/pulse_oximetry/any_event:0/spo|denominator": 100.0,
    "news2-christer/pulse_oximetry/any_event:0/time": "2026-09-23T15:27:35.528873387Z",
    "news2-christer/pulse_oximetry/language|code": "en",
    "news2-christer/pulse_oximetry/language|terminology": "ISO_639-1",
    "news2-christer/pulse_oximetry/encoding|terminology": "IANA_character-sets",
    "news2-christer/pulse_oximetry/encoding|code": "UTF-8",
    "news2-christer/blood_pressure/any_event:0/systolic|unit": "mm[Hg]",
    "news2-christer/blood_pressure/any_event:0/systolic|magnitude": 120.0,
    "news2-christer/blood_pressure/any_event:0/diastolic|unit": "mm[Hg]",
    "news2-christer/blood_pressure/any_event:0/diastolic|magnitude": 80.0,
    "news2-christer/blood_pressure/any_event:0/time": "2026-09-23T15:27:35.528873387Z",
    "news2-christer/blood_pressure/language|code": "en",
    "news2-christer/blood_pressure/language|terminology": "ISO_639-1",
    "news2-christer/blood_pressure/encoding|terminology": "IANA_character-sets",
    "news2-christer/blood_pressure/encoding|code": "UTF-8",
    "news2-christer/pulse_heart_beat/any_event:0/rate|magnitude": 72.0,
    "news2-christer/pulse_heart_beat/any_event:0/rate|unit": "/min",
    "news2-christer/pulse_heart_beat/any_event:0/time": "2026-09-23T15:27:35.528873387Z",
    "news2-christer/pulse_heart_beat/language|terminology": "ISO_639-1",
    "news2-christer/pulse_heart_beat/language|code": "en",
    "news2-christer/pulse_heart_beat/encoding|code": "UTF-8",
    "news2-christer/pulse_heart_beat/encoding|terminology": "IANA_character-sets",
    "news2-christer/body_temperature/any_event:0/temperature|unit": "Cel",
    "news2-christer/body_temperature/any_event:0/temperature|magnitude": 36.8,
    "news2-christer/body_temperature/any_event:0/time": "2026-09-23T15:27:35.528873387Z",
    "news2-christer/body_temperature/language|code": "en",
    "news2-christer/body_temperature/language|terminology": "ISO_639-1",
    "news2-christer/body_temperature/encoding|terminology": "IANA_character-sets",
    "news2-christer/body_temperature/encoding|code": "UTF-8",
    "news2-christer/language|terminology": "ISO_639-1",
    "news2-christer/language|code": "en",
    "news2-christer/territory|code": "DE",
    "news2-christer/territory|terminology": "ISO_3166-1",
    "news2-christer/composer|name": "Alve Don",
    "news2-christer/_uid": "bf1f29c3-b652-460a-bb53-c0470202c5b8::local.ehrbase.org::1"
}'.
]

{ #category : 'score' }
News2 >> calcTotalScore: scores [

	| fields total |
	fields := #( #respiration #spo ).
	total := fields
		         inject: 0
		         into: [ :sum :fld | sum + (scores at: fld) ].
	scores at: #total put: total.
	^scores
]

{ #category : 'score engine' }
News2 >> compositionNews2: scores [

	| template result |
	template := self compositionTemplateNews2 .
	result := template format: scores.
	^ result
]

{ #category : 'score engine' }
News2 >> compositionTemplateNews2 [

	^ '"news2-christer/national_early_warning_score_2_news2/respiration_rate|ordinal": {respiration},
"news2-christer/national_early_warning_score_2_news2/respiration_rate|code": "at0021",
"news2-christer/national_early_warning_score_2_news2/spo_scale_1|ordinal": {spo},
"news2-christer/national_early_warning_score_2_news2/spo_scale_1|code": "at0033",
"news2-christer/national_early_warning_score_2_news2/spo_scale_2|ordinal": {spo},
"news2-christer/national_early_warning_score_2_news2/spo_scale_2|code": "at0061",
"news2-christer/national_early_warning_score_2_news2/air_or_oxygen|value": "Air",
"news2-christer/national_early_warning_score_2_news2/air_or_oxygen|code": "at0036",
"news2-christer/national_early_warning_score_2_news2/air_or_oxygen|ordinal": 0,
"news2-christer/national_early_warning_score_2_news2/systolic_blood_pressure|code": "at0017",
"news2-christer/national_early_warning_score_2_news2/systolic_blood_pressure|ordinal": {systolic},
"news2-christer/national_early_warning_score_2_news2/pulse|code": "at0010",
"news2-christer/national_early_warning_score_2_news2/pulse|ordinal": {pulse},
"news2-christer/national_early_warning_score_2_news2/consciousness|value": "Alert",
"news2-christer/national_early_warning_score_2_news2/consciousness|ordinal": 0,
"news2-christer/national_early_warning_score_2_news2/consciousness|code": "at0024",
"news2-christer/national_early_warning_score_2_news2/temperature|code": "at0039",
"news2-christer/national_early_warning_score_2_news2/temperature|ordinal": 3,
"news2-christer/national_early_warning_score_2_news2/total_score": {total},
"news2-christer/national_early_warning_score_2_news2/clinical_risk_category|value": "Low",
"news2-christer/national_early_warning_score_2_news2/clinical_risk_category|code": "at0057",
"news2-christer/national_early_warning_score_2_news2/clinical_risk_category|terminology": "local",
"news2-christer/national_early_warning_score_2_news2/time": "2022-02-03T04:05:06.0",
'
]

{ #category : 'incoming' }
News2 >> compositionTemplateValues [

	^ '
  "news2-christer/context/start_time": "{timestamp}",
  "news2-christer/context/setting|code": "232",
  "news2-christer/context/setting|value": "secondary medical care",
  "news2-christer/context/setting|terminology": "openehr",
  "news2-christer/category|code": "433",
  "news2-christer/category|value": "event",
  "news2-christer/category|terminology": "openehr",
  "news2-christer/composer|name": "Alve Don",
  "news2-christer/respiration/any_event:0/rate|magnitude": {respiration},
  "news2-christer/respiration/any_event:0/rate|unit": "/min",
  "news2-christer/pulse_oximetry/any_event:0/spo|numerator": {spo},
  "news2-christer/pulse_oximetry/any_event:0/spo|denominator": 100.0,
  "news2-christer/pulse_oximetry/any_event:0/spo|type": 3,
  "news2-christer/blood_pressure/any_event:0/systolic|magnitude": {systolic},
  "news2-christer/blood_pressure/any_event:0/systolic|unit": "mm[Hg]",
  "news2-christer/blood_pressure/any_event:0/diastolic|magnitude": 80.0,
  "news2-christer/blood_pressure/any_event:0/diastolic|unit": "mm[Hg]",
  "news2-christer/pulse_heart_beat/any_event:0/rate|magnitude": {pulse},
  "news2-christer/pulse_heart_beat/any_event:0/rate|unit": "/min",
  "news2-christer/body_temperature/any_event:0/temperature|magnitude": {temperature},
  "news2-christer/body_temperature/any_event:0/temperature|unit": "Cel",
  "news2-christer/language|terminology": "ISO_639-1",
  "news2-christer/language|code": "en",
  "news2-christer/territory|code": "DE",
  "news2-christer/territory|terminology": "ISO_3166-1"
'
]

{ #category : 'score engine' }
News2 >> compositionUpdate [
	^ ''
]

{ #category : 'incoming' }
News2 >> createValueCompFrom: dict [

	|  template result |
	
	template := self compositionTemplateValues.
	result := template format: dict.
	^ result
]

{ #category : 'private' }
News2 >> ehrClient [

	| cl |
	cl := ZnClient new url:
		      'https://sandbox.ehrbase.org/ehrbase/rest/openehr/v1/'.
		cl accept:'application/json'.
	^ cl
]

{ #category : 'incoming' }
News2 >> extractFromHl7: aHl7 [

	| h7 pcd dict patient_id timestamp obr7 |
	h7 := (H7Parser on: aHl7) parse.
	pcd := PcdMessage from: h7.
	obr7 := ((h7 segment: #OBR) at: 7) last value.
	timestamp := DateAndTime readYMDHMSfromDigits: obr7 readStream.
	dict := Dictionary new.
	dict at: #timestamp put: timestamp asString.
	dict at: #respiration put: (pcd getIdNo: 151562) value.
	dict at: #spo put: (pcd getIdNo: 150456) value.
	dict at: #systolic put: (pcd getIdNo: 150037) value.
	dict at: #pulse put: (pcd getIdNo: 149514) value.
	dict at: #temperature put: (pcd getIdNo: 188420) value.
	patient_id := ((pcd hl7 segment: #pid) at: 2) third.
	"namn: ((pcd hl7 segment: #pid) at:5) third."
	dict at: #ehrid put: (self getEhrId: patient_id).

	^ dict
]

{ #category : 'score engine' }
News2 >> extractValsFromComp: aDict [

	| dict |
	dict := Dictionary new.
	dict at: #respiration put: (aDict at:
			 'news2-christer/respiration/any_event:0/rate|magnitude').
	dict at: #spo put: (aDict at:
			 'news2-christer/pulse_oximetry/any_event:0/spo').
	dict at: #systolic put: (aDict at:
			 'news2-christer/blood_pressure/any_event:0/systolic|magnitude').
	dict at: #pulse put: (aDict at:
			 'news2-christer/pulse_heart_beat/any_event:0/rate|magnitude').
	dict at: #temperature put: (aDict at:
			 'news2-christer/body_temperature/any_event:0/temperature|magnitude').
	^ dict
]

{ #category : 'private' }
News2 >> getEhrId: patient_id [

	^'0d3d3cdf-3a64-40f4-8f3b-5fcd51ec6c7d'
]

{ #category : 'incoming' }
News2 >> processHl7: aHl7Msg [

	| inner comp cl dict |
	dict := self extractFromHl7: aHl7Msg.
	inner := self createValueCompFrom: dict.
	comp := ZnEntity json: '{' , inner , '}'.
	cl := self ehrClient.
	"ehr/{{tolvan}}/composition?format=FLAT&templateId=news2-christer"
	cl addPath: { 'ehr'. dict at:#ehrid. 'composition' };
	queryAt:'format' put: 'FLAT';queryAt: 'templateId' put:'news2-christer' .
	cl entity: comp.
	cl post.
	^ cl
]

{ #category : 'score engine' }
News2 >> scoreComposition: aDict [

	| vals scores |
	vals := self extractValsFromComp: aDict. 
	scores := self scoreValues: vals.
self calcTotalScore: scores.
	^ scores
]

{ #category : 'score' }
News2 >> scorePulse: aVal [

	aVal <= 40 ifTrue: [ ^ 3 ].
	aVal <= 50 ifTrue: [ ^ 1 ].
	aVal <= 90 ifTrue: [ ^ 0 ].
	aVal <= 110 ifTrue: [ ^ 1 ].
	aVal <= 130 ifTrue: [ ^ 2 ].
	^ 3
]

{ #category : 'score' }
News2 >> scoreResp: aVal [

	aVal <= 8 ifTrue: [ ^ 3 ].
	aVal <= 11 ifTrue: [ ^ 1 ].
	aVal <= 20 ifTrue: [ ^ 0 ].
	aVal <= 24 ifTrue: [ ^ 2 ].
	^ 3
]

{ #category : 'score' }
News2 >> scoreSpo: aVal [

	aVal <= 0.91 ifTrue: [ ^ 3 ].
	aVal <= 0.93 ifTrue: [ ^ 2 ].
	aVal <= 0.95 ifTrue: [ ^ 1 ].
	^ 0
]

{ #category : 'score' }
News2 >> scoreSystolic: aVal [

	aVal <= 90 ifTrue: [ ^ 3 ].
	aVal <= 100 ifTrue: [ ^ 2 ].
	aVal <= 110 ifTrue: [ ^ 1 ].
	aVal <= 219 ifTrue: [ ^ 0 ].
		^ 3
]

{ #category : 'score' }
News2 >> scoreTemp:aVal [
(	aVal <= 35.0)ifTrue:[^3].
	(	aVal <= 36.0)ifTrue:[^1].
		(	aVal <= 38.0)ifTrue:[^0]..
			(	aVal <= 39.0)ifTrue:[^1].
				^2
	
]

{ #category : 'score' }
News2 >> scoreValues: vals [

	| dict |
	dict := Dictionary new.
	dict at: #respiration put: (self scoreResp: (vals at: #respiration)).
	dict at: #spo put: (self scoreSpo: (vals at: #spo)).
	dict at: #systolic put: (self scoreSystolic: (vals at: #systolic)).
	dict at: #pulse put: (self scorePulse: (vals at: #pulse)).
	dict at: #temperature put: (self scoreTemp: (vals at: #temperature)).

	^ dict
]
