"build.st"

Iceberg remoteTypeSelector: #httpsUrl.

(IceRepository registry select: [ :r | r name = 'TvProg3' ]) do:
        [ :r |
        r location ifNotNil: [ :dir | dir ensureDeleteAll ].
        r forget ].

Stdio stdout
        nextPutAll: '>>> before build: P3=' , (Smalltalk globals hasClassNamed: #P3Client) printString ,
                ' Teapot=' , (Smalltalk globals hasClassNamed: #Teapot) printString;
        lf; flush.

Metacello new
        baseline: 'HL7';
        repository: 'github://Gotchas99/HL7:main/src';
        onConflictUseIncoming;
        load.
!

Smalltalk garbageCollect.
!

"Metacello new
  repository: 'github://svenvc/zinc/repository';
  baseline: 'ZincHTTPComponents';
  onConflict: [ :e | e useIncoming ];
  onUpgrade: [ :e | e useIncoming ];
  onWarning: [ :e | e load ];
  load: #('default' 'WebSocket').
"
