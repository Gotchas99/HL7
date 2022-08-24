Class {
	#name : #H7PresenterMain,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'msgs',
		'segs',
		'flds'
	],
	#category : #'HL7-Gui'
}

{ #category : #layout }
H7PresenterMain class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #msgs;
				   add: #segs expand: true)
		  height: 150;
		  add: #flds expand: true;
				  yourself
]

{ #category : #initialization }
H7PresenterMain >> connectPresenters [

	| sel txt |
	msgs whenSelectionChangedDo: [ :selection | 
		[ :elem | 
		sel := elem first.
		txt := H7Message perform: sel.
		segs items: (H7Parser on: txt) parse ] cull: selection selectedItem ].
	segs whenSelectionChangedDo: [ :selection | 
		[ :elem | elem ifNotNil: [ flds items: elem parse] ] cull:
			selection selectedItem ]
]

{ #category : #'accessing - resources' }
H7PresenterMain >> initialExtent [

	^ 800 @ 800
]

{ #category : #initialization }
H7PresenterMain >> initializePresenters [

	msgs := self newTable.
	msgs
		beResizable;
		addColumn:
			((SpStringTableColumn title: 'Selector' evaluated: #first) width:
					 25);
		addColumn:
			(SpStringTableColumn title: 'Description' evaluated: #second);
		items: self sampleMessages.
	segs := self newList.
	flds := SpTablePresenter new
		        addColumn:
			        ((SpStringTableColumn title: 'Index' evaluated: #first) 
				         width: 15);
		        addColumn:
			        (SpStringTableColumn title: 'Field' evaluated: #second);
		        addColumn:
			        (SpStringTableColumn title: 'Value' evaluated: #last);
		        yourself
]

{ #category : #initialization }
H7PresenterMain >> sampleMessages [

	^ #( #( #sample1 'Sample message from web' )
	     #( #adtA08 'exempel från Elin' )
	     #( #adtA08_2 'sample från Göran' )
	     #( #adt40 'ADT 40 från Göran' ) #( #genack 'minimal ACK sample' )
	#(#ormO01 'ORM 1')
	#(#ormO01_2 'ORM O01 fr göran') )
]

{ #category : #accessing }
H7PresenterMain >> title [ ^'H7 - app'
]
