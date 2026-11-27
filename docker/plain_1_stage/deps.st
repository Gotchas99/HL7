"deps.st"

Iceberg remoteTypeSelector: #httpsUrl.

Metacello new
        baseline: 'HL7';
        repository: 'github://Gotchas99/HL7:main/src';
        load: #( 'deps' ).

Smalltalk garbageCollect.
