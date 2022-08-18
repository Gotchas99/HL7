"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestHL7,
	#superclass : #PackageManifest,
	#category : #'HL7-Manifest'
}

{ #category : #'code-critics' }
ManifestHL7 class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#H7PresenterMain #connectPresenters #false)) #'2022-08-18T15:32:23.172+02:00') )
]

{ #category : #'code-critics' }
ManifestHL7 class >> ruleExtraBlockRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#H7PresenterMain #connectPresenters #false)) #'2022-08-18T15:32:51.223+02:00') )
]
