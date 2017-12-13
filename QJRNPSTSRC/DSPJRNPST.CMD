             CMD        PROMPT('AFFICHAGE POSTE JOURNAL')
             PARM       KWD(JRN) TYPE(QJRN) MIN(1) PROMPT('JOURNAL')
 QJRN:       QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) DFT(*CURLIB) SPCVAL((*CURLIB *CURLIB) (*LIBL)) +
                          PROMPT('BIBLIOTHÈQUE')

             PARM       KWD(MEMBRE) TYPE(QFILE) MIN(1) PROMPT('FICHIER')
 QFILE:      QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) DFT(*FIRST) SPCVAL((*FIRST *FIRST)) +
                          PROMPT('Membre')
             QUAL       TYPE(*NAME) LEN(10) DFT(*CURLIB) SPCVAL((*CURLIB *CURLIB)) +
                          PROMPT('BIBLIOTHÈQUE')

             PARM       KWD(FROMTIME) TYPE(QFROMTIME) PROMPT('DATE ET HEURE DE DÉBUT')
 QFROMTIME:  QUAL       TYPE(*NAME) LEN(10) DFT(*CURRENT) SPCVAL((*CURRENT '*CURRENT'))
             QUAL       TYPE(*NAME) LEN(8) PROMPT('HEURE DE DÉBUT')

             PARM       KWD(TOTIME) TYPE(QTOTIME) MIN(0) PROMPT('DATE ET HEURE DE FIN')

 QTOTIME:    QUAL       TYPE(*NAME) LEN(10) DFT(*NONE) SPCVAL((*NONE '*NONE'))
             QUAL       TYPE(*NAME) LEN(8) PROMPT('HEURE DE FIN')

             PARM       KWD(PGM) TYPE(QPGM) MIN(1) PROMPT('PROGRAMME')
 QPGM:       QUAL       TYPE(*NAME) LEN(10) DFT(*ALL) SPCVAL((*ALL))
             PARM       KWD(RCVRNGD) TYPE(QRCVRNG) MIN(1) PROMPT('PLAGE DE RÉCEPTEURS DE +
                          JOURNAL')
 QRCVRNG:    QUAL       TYPE(*NAME) LEN(10) DFT(*CURRENT) SPCVAL((*CURRENT *CURRENT))
             QUAL       TYPE(*NAME) LEN(10) DFT(*CURLIB) SPCVAL((*CURLIB *CURLIB) (*LIBL)) +
                          PROMPT('BIBLIOTHÈQUE')
             PARM       KWD(RCVRNGF) TYPE(QRCVRNG2)

 QRCVRNG2:   QUAL       TYPE(*NAME) LEN(10) DFT(*NONE) SPCVAL((*NONE '*NONE'))
             QUAL       TYPE(*NAME) LEN(10) SPCVAL((*CURLIB *CURLIB) (*LIBL)) +
                          PROMPT('BIBLIOTHÈQUE')

             PARM       KWD(FROMENTLRG) TYPE(*CHAR) LEN(25) DFT(*NONE) SPCVAL((*NONE '*NONE')) +
                          PROMPT('PREMIER NUM. SÉQ. MAXI')

             PARM       KWD(TOENTLRG) TYPE(*CHAR) LEN(25) DFT(*NONE) SPCVAL((*NONE '*NONE')) +
                          PROMPT('DERN. NUM. SÉQ. MAXI')

             PARM       KWD(JOB) TYPE(QJOB) MIN(1) PROMPT('TRAVAIL')
 QJOB:       QUAL       TYPE(*NAME) LEN(10) DFT(*ALL) SPCVAL((*ALL))
             QUAL       TYPE(*NAME) LEN(10) PROMPT('UTILISATEUR')
             QUAL       TYPE(*CHAR) LEN(6) RANGE(000000 999999) PROMPT('NUMÉRO')
