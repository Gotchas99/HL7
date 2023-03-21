Class {
	#name : #H7PcdViewer,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'h7',
		'pcd',
		'iso',
		'tree1'
	],
	#category : #'HL7-Gui'
}

{ #category : #layout }
H7PcdViewer class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #tree1 expand: true;
		  yourself
]

{ #category : #'instance creation' }
H7PcdViewer class >> openOn: aH7Msg [

	self new msg:aH7Msg ;open
]

{ #category : #'morphic ui' }
H7PcdViewer >> initialExtent [

	^ 800 @ 800
]

{ #category : #initialization }
H7PcdViewer >> initializePresenters [

	"self halt."

	| path ad |
	tree1 := self newTreeTable.
	tree1
		addColumn:
			(SpStringTableColumn
				 title: 'sub ID'
				 evaluated: [ :node | node subId ]);
		addColumn:
			(SpStringTableColumn
				 title: 'ID No'
				 evaluated: [ :node | node idNo ]);
		addColumn:
			(SpStringTableColumn title: 'ID' evaluated: [ :node | node name ]);
		addColumn:
			(SpStringTableColumn
				 title: 'Value'
				 evaluated: [ :node | node value ]);
		addColumn:
			(SpStringTableColumn title: 'Unit' evaluated: [ :node | node unit ]);
		roots: {  };
		children: [ :x | x nodes ];
		beResizable;
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | 
			| item |
			item := selection selectedItem.
			item isMetric
				ifTrue: [ item inspect ]
				ifFalse: [ 
					ad := tree1 adapter.
					path := ad selectedPath.
									(ad isExpanded: item)
						ifTrue: [ 
													ad collapsePath: path ]
						ifFalse: [ 
													ad expandPath: path ] ] ]
]

{ #category : #accessing }
H7PcdViewer >> msg: aH7Msg [
h7:=aH7Msg.
	pcd := PcdMessage from: h7.
	iso := pcd mds.tree1 roots:{iso}
]
