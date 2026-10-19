Class {
	#name : 'MtpApp',
	#superclass : 'WAComponent',
	#category : 'HL7-NEWS2',
	#package : 'HL7',
	#tag : 'NEWS2'
}

{ #category : 'class initialization' }
MtpApp class >> canBeRoot [

	^ true
]

{ #category : 'class initialization' }
MtpApp class >> contextRoot [

	^ 'mtp'
]

{ #category : 'class initialization' }
MtpApp class >> initialize [

	self register
]

{ #category : 'class initialization' }
MtpApp class >> register [

	| app |
	app := WAAdmin register: self asApplicationAt: self contextRoot.
	^ app
]

{ #category : 'rendering' }
MtpApp >> renderContentOn: html [
	
		html heading: 'Hello from MTP-app!'.
	
]

{ #category : 'hooks' }
MtpApp >> style [ 
^'/* ==========================================================================
   news2.css — stilmall för NEWS2-vyerna i VGR DataHub
   --------------------------------------------------------------------------
   Två vyer delar samma mall:
     tavla.html        avdelningstavlan, för verksamheten
     verifiering.html  granskningsvyn, för tekniker och informatiker

   Statusfärgerna (god/varning/allvarlig/kritisk) är reserverade för klinisk
   risk och används aldrig som dekor eller som serieidentitet. De bärs alltid
   tillsammans med ikon och text — färgen är aldrig ensam bärare av betydelse.
   ========================================================================== */

:root {
  color-scheme: light;
  --yta:        #fcfcfb;   /* kortets yta  */
  --plan:       #f3f3f0;   /* sidans botten */
  --ink:        #0b0b0b;
  --ink-2:      #52514e;
  --ink-3:      #898781;
  --linje:      #e1e0d9;
  --kant:       rgba(11,11,11,0.10);
  --serie:      #2a78d6;   /* enda serien i trendkurvan */
  --serie-svag: #c3c2b7;

  /* Statuspalett — fast, byts inte mellan ljust och mörkt */
  --god:      #0ca30c;
  --varning:  #fab219;
  --allvar:   #ec835a;
  --kritisk:  #d03b3b;
  --okand:    #898781;

  --r: 10px;
  --sans: system-ui, -apple-system, "Segoe UI", sans-serif;
  --mono: ui-monospace, SFMono-Regular, Menlo, Consolas, monospace;
}

@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    color-scheme: dark;
    --yta: #1a1a19; --plan: #0d0d0d;
    --ink: #f0efec; --ink-2: #c3c2b7; --ink-3: #898781;
    --linje: #2c2c2a; --kant: rgba(255,255,255,0.10);
    --serie: #3987e5; --serie-svag: #52514e;
  }
}
:root[data-theme="dark"] {
  color-scheme: dark;
  --yta: #1a1a19; --plan: #0d0d0d;
  --ink: #f0efec; --ink-2: #c3c2b7; --ink-3: #898781;
  --linje: #2c2c2a; --kant: rgba(255,255,255,0.10);
  --serie: #3987e5; --serie-svag: #52514e;
}

* { box-sizing: border-box; }
body {
  margin: 0; background: var(--plan); color: var(--ink);
  font: 400 14px/1.5 var(--sans);
  -webkit-font-smoothing: antialiased;
}
.omslag { max-width: 1180px; margin: 0 auto; padding: 24px 20px 64px; }

/* --- Sidhuvud ----------------------------------------------------------- */
.huvud { display: flex; flex-wrap: wrap; gap: 16px; align-items: flex-end;
         justify-content: space-between; margin-bottom: 20px; }
.huvud h1 { margin: 0; font-size: 22px; font-weight: 650; letter-spacing: -0.01em; }
.huvud p  { margin: 4px 0 0; color: var(--ink-2); font-size: 13px; }
.stampel { font-size: 12px; color: var(--ink-3); text-align: right; }
.stampel b { display: block; color: var(--ink-2); font-weight: 600; font-size: 13px; }

/* --- Nyckeltal ---------------------------------------------------------- */
.nyckeltal { display: grid; gap: 12px; margin-bottom: 20px;
             grid-template-columns: repeat(auto-fit, minmax(170px, 1fr)); }
.ruta { background: var(--yta); border: 1px solid var(--kant); border-radius: var(--r);
        padding: 14px 16px; }
.ruta .etikett { font-size: 12px; color: var(--ink-2); margin-bottom: 6px; }
.ruta .tal { font-size: 28px; font-weight: 650; line-height: 1.1; letter-spacing: -0.02em; }
.ruta .fot { font-size: 12px; color: var(--ink-3); margin-top: 4px; }

/* --- Statusmärkning ----------------------------------------------------- */
/* Ikon + text alltid. Färgen förstärker, den bär aldrig ensam. */
.status { display: inline-flex; align-items: center; gap: 6px; white-space: nowrap;
          font-size: 12px; font-weight: 600; padding: 3px 9px 3px 7px;
          border-radius: 999px; border: 1px solid var(--kant); }
.status .prick { width: 9px; height: 9px; border-radius: 50%; flex: none; }
.status-god     { color: #0a7d0a; } .status-god .prick     { background: var(--god); }
.status-varning { color: #8a6000; } .status-varning .prick { background: var(--varning); }
.status-allvar  { color: #a8512a; } .status-allvar .prick  { background: var(--allvar); }
.status-kritisk { color: #b02a2a; } .status-kritisk .prick { background: var(--kritisk); }
.status-okand   { color: var(--ink-2); } .status-okand .prick { background: var(--okand); }
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) .status-god     { color: #4cc24c; }
  :root:not([data-theme="light"]) .status-varning { color: var(--varning); }
  :root:not([data-theme="light"]) .status-allvar  { color: var(--allvar); }
  :root:not([data-theme="light"]) .status-kritisk { color: #e46a6a; }
}
:root[data-theme="dark"] .status-god     { color: #4cc24c; }
:root[data-theme="dark"] .status-varning { color: var(--varning); }
:root[data-theme="dark"] .status-allvar  { color: var(--allvar); }
:root[data-theme="dark"] .status-kritisk { color: #e46a6a; }

/* --- Patientrader ------------------------------------------------------- */
.patienter { display: flex; flex-direction: column; gap: 10px; }
.patient { background: var(--yta); border: 1px solid var(--kant); border-radius: var(--r);
           overflow: hidden; }
.patient > summary { list-style: none; cursor: pointer; display: grid; gap: 14px;
                     align-items: center; padding: 14px 16px;
                     grid-template-columns: 148px 68px 1fr 128px 176px 18px; }
.patient > summary::-webkit-details-marker { display: none; }
.patient > summary:hover { background: color-mix(in srgb, var(--ink) 3%, var(--yta)); }

.sang { font-size: 12px; color: var(--ink-3); }
.sang b { display: block; font-size: 15px; font-weight: 600; color: var(--ink); }

.poang { text-align: center; }
.poang .varde { font-size: 32px; font-weight: 650; line-height: 1; letter-spacing: -0.02em; }
.poang .av { font-size: 11px; color: var(--ink-3); margin-top: 3px; }

.drivande { display: flex; flex-wrap: wrap; gap: 6px; }
.bidrag { font-size: 11.5px; padding: 3px 8px; border-radius: 6px;
          border: 1px solid var(--kant); color: var(--ink-2);
          background: color-mix(in srgb, var(--ink) 4%, var(--yta)); }
.bidrag b { color: var(--ink); font-weight: 600; }

.alder { font-size: 12px; color: var(--ink-2); text-align: right; }
.alder .status { margin-bottom: 3px; }
.alder .sent { color: var(--ink-3); }
.pil { color: var(--ink-3); transition: transform .15s; font-size: 12px; }
.patient[open] .pil { transform: rotate(90deg); }

/* --- Trendkurva (en serie, ingen dubbel axel) --------------------------- */
.trend { display: block; width: 128px; height: 34px; overflow: visible; }
.trend .bana { fill: none; stroke: var(--ink-3); stroke-width: 2;
               stroke-linecap: round; stroke-linejoin: round; }
.trend .nu { fill: var(--serie); stroke: var(--yta); stroke-width: 2; }
.trend .grund { stroke: var(--linje); stroke-width: 1; }

/* --- Härledning (utfällt) ----------------------------------------------- */
.harledning { border-top: 1px solid var(--linje); padding: 14px 16px 16px;
              background: color-mix(in srgb, var(--ink) 2%, var(--yta)); }
.harledning h3 { margin: 0 0 10px; font-size: 12px; font-weight: 600;
                 color: var(--ink-2); text-transform: uppercase; letter-spacing: .04em; }

/* --- Tabeller ----------------------------------------------------------- */
table.data { width: 100%; border-collapse: collapse; font-size: 13px; }
table.data th { text-align: left; font-weight: 600; font-size: 11.5px; color: var(--ink-2);
                text-transform: uppercase; letter-spacing: .04em;
                padding: 0 10px 7px; border-bottom: 1px solid var(--linje); }
table.data td { padding: 7px 10px; border-bottom: 1px solid var(--linje); vertical-align: top; }
table.data tr:last-child td { border-bottom: 0; }
table.data td.num, table.data th.num { text-align: right; font-variant-numeric: tabular-nums; }
table.data td.svag { color: var(--ink-3); }
table.data code { font: 12px/1.4 var(--mono); color: var(--ink-2); white-space: nowrap; }

.kort { background: var(--yta); border: 1px solid var(--kant); border-radius: var(--r);
        padding: 16px; margin-bottom: 16px; }
.kort > h2 { margin: 0 0 4px; font-size: 15px; font-weight: 650; }
.kort > h2 + p { margin: 0 0 14px; color: var(--ink-2); font-size: 13px; }

/* --- Flaggor (granskningsvyn) ------------------------------------------- */
.flagga { display: inline-flex; align-items: center; gap: 5px; font-size: 11.5px;
          font-weight: 600; padding: 2px 7px; border-radius: 6px;
          border: 1px solid var(--kant); white-space: nowrap; }
.flagga .prick { width: 8px; height: 8px; border-radius: 50%; flex: none; }
.flagga-fel  { color: #b02a2a; } .flagga-fel .prick  { background: var(--kritisk); }
.flagga-varn { color: #8a6000; } .flagga-varn .prick { background: var(--varning); }
.flagga-ok   { color: var(--ink-3); } .flagga-ok .prick { background: var(--okand); }
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) .flagga-fel  { color: #e46a6a; }
  :root:not([data-theme="light"]) .flagga-varn { color: var(--varning); }
}
:root[data-theme="dark"] .flagga-fel  { color: #e46a6a; }
:root[data-theme="dark"] .flagga-varn { color: var(--varning); }

.notis { border-left: 3px solid var(--linje); padding: 2px 0 2px 12px; margin: 12px 0;
         color: var(--ink-2); font-size: 13px; }

.fot-not { margin-top: 28px; padding-top: 14px; border-top: 1px solid var(--linje);
           color: var(--ink-3); font-size: 12px; }

/* --- Smal skärm --------------------------------------------------------- */
@media (max-width: 860px) {
  .patient > summary { grid-template-columns: 1fr 64px; row-gap: 10px; }
  .drivande, .trend, .alder { grid-column: 1 / -1; }
  .alder { text-align: left; }
  .pil { display: none; }
}
@media (max-width: 720px) {
  table.data { display: block; overflow-x: auto; white-space: nowrap; }
}
'
]
