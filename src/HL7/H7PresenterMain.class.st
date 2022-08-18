Class {
	#name : #H7PresenterMain,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'email',
		'password'
	],
	#category : #'HL7-Gui'
}

{ #category : #specs }
H7PresenterMain class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		 
		 add: #email expand: false;
		add: #password expand: false;
		yourself

]

{ #category : #'accessing - resources' }
H7PresenterMain >> initialExtent [

	^ 800 @ 600
]

{ #category : #initialization }
H7PresenterMain >> initializePresenters [

	| passwordInput |
	passwordInput := self newTextInput
		                 bePassword;
		                 yourself.
	email := self instantiate: (SpLabeledPresenter
			          label: 'Email' 			          input: self newTextInput
			          description:
			          'Email you will use to send activations mails to your users.').
	password := self instantiate: (SpLabeledPresenter
			             label: 'Password'
			             input: passwordInput
			             description: 'Password of the email account used.')
]

{ #category : #accessing }
H7PresenterMain >> title [ ^'H7 - app'
]
