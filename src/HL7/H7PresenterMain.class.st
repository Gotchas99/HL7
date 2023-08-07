Class {
	#name : #H7PresenterMain,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'categories',
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
		add:#categories;
				   add: #msgs;
				   add: #segs expand: true)
		  height: 165;
		  add: #flds expand: true;
		  yourself
]

{ #category : #initialization }
H7PresenterMain >> connectPresenters [

	| sel txt tmp |
	categories whenSelectionChangedDo: [ :selection | 
		[ :elem | 
		sel := elem first.
		tmp := self sampleMessages select: [ :m | m third = sel ].
		msgs items: tmp ] cull: selection selectedItem ].
	msgs whenSelectionChangedDo: [ :selection | 
		[ :elem | 
		elem ifNil: [ segs items: #(  ) ] ifNotNil: [ 
			sel := elem first.
			txt := H7Message perform: sel.
			segs items: (H7Parser on: txt) parse ] ] cull:
			selection selectedItem ].
	segs whenSelectionChangedDo: [ :selection | 
		[ :elem | elem ifNil:[flds items:#()] ifNotNil: [ flds items: elem parse ] ] cull:
			selection selectedItem ]
]

{ #category : #'accessing - resources' }
H7PresenterMain >> initialExtent [

	^ 900 @ 900
]

{ #category : #initialization }
H7PresenterMain >> initializePresenters [

	categories := self newTable.
	categories
		beResizable;
		contextMenu: self msgMenu;
		addColumn:
			((SpStringTableColumn title: 'Selector' evaluated: #first) width:
					 25);
		addColumn:
			(SpStringTableColumn title: 'Description' evaluated: #second);
		items: self sampleCategories.
	msgs := self newTable.
	msgs
		beResizable;
		contextMenu: self msgMenu;
		addColumn:
			((SpStringTableColumn title: 'Selector' evaluated: #first) width:
					 25);
		addColumn:
			(SpStringTableColumn title: 'Description' evaluated: #second)
	.
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
H7PresenterMain >> initializeWindow: aWindowPresenter [

	"override this to set window values before opening. 
	 You may want to add a menu, a toolbar or a statusbar"

	"IMPORTANT: Please ovirride this method and set yourself the informations you want in your window.
	The content of this method is here to help the transition between Spec 1 and 2.
	In the next Spec version the content of this method will be removed and it will do nothing by default because the goal is to remove the management of all of those informations from Composable to put them in WindowPresenter."

	aWindowPresenter
		title: self title;
		initialExtent: self initialExtent
		"windowIcon: self windowIcon"
]

{ #category : #initialization }
H7PresenterMain >> msgMenu [

	^ self newMenu
		  addItem: [ :anItem | 
			  anItem
				  name: 'Inspect';
				  action: [ 
					  | txt |
					  txt := H7Message perform: msgs selectedItem first.
					  (H7Parser on: txt) parse inspect ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Öppna som PCD';
				  action: [ 
					  | txt |
					  txt := H7Message perform: msgs selectedItem first.
					  H7PcdViewer openOn: (H7Parser on: txt) parse ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Öppna som text';
				  action: [ 
					  | txt |
					  txt := H7Message perform: msgs selectedItem first.StPlayground openContents:txt ] ]
]

{ #category : #initialization }
H7PresenterMain >> sampleCategories [

	^ #( #( #covid 'COVID' ) #( #dose 'ORM från qaelum' )#( #goran 'Samples from Göran' )
	     #( #misc 'various samples' ) 
	     #( #pcd 'PCD Samples' ) )
]

{ #category : #initialization }
H7PresenterMain >> sampleMessages [

	^ #( #( #covid01 'COVID lab request' 'covid' )
	     #( #pcd01_episode 'PCD Episodic' 'pcd' )
	     #( #pcd01_physMon 'PCD 01 Physical monitor'
	        'pcd' ) #( #pcd15 'PCD 15 sample' 'pcd' )
	     #( #sample1 'Sample message from web' 'misc' )
	     #( #adtA08 'exempel från Elin' 'misc' )
	     #( #adtA08_2 'sample från Göran' 'goran' )
	     #( #adtA40 'ADT 40 från Göran' 'goran' )
	     #( #genAck 'minimal ACK sample' 'misc' )
	     #( #ormO01 'ORM 1' 'misc' ) #( #ormO01_2 'ORM O01 fr göran'
	        'goran' ) #( #ormO01_3 'ORM från qaelum' 'dose' )
	     #( #spot 'Connex Spot' 'pcd' ) )
]

{ #category : #accessing }
H7PresenterMain >> title [ ^'H7 - app'
]
