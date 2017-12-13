     FQDDSSRC   O  A E             DISK
     F                                     RENAME(QDDSSRC:SOURCE)
     FRTVPFSRC  IP   E             DISK
     FRTVPFSRC1 IF   E             DISK
     DSRCDTA           DS
     DT                               1    DIM(80)
     DXHFLDP           DS
     DU                               1    DIM(2)
     DXHFLDB           DS
     DV                               1    DIM(5)
     DXHFLDD           DS
     DW                               1    DIM(2)
     DED1              S              1    DIM(10) CTDATA PERRCD(10)
      * format fichier
     C                   READ      RTVPFSRC1                              41
      *
     C                   MOVEA     *BLANKS       T
     C                   MOVEA     WHFLDI        T(19)
     C                   MOVEL     WHFLDP        XHFLDP
     C                   MOVEL     WHFLDB        XHFLDB
     C                   MOVEL     WHFLDD        XHFLDD
      * cadrage droite zero suppress
     C     U(1)          IFEQ      '0'
     C                   MOVE      ' '           U(1)
     C                   ENDIF
     C                   DO        4             X                 2 0
     C                   Z-ADD     1             Y                 2 0
     C     V(X)          LOOKUP    ED1(Y)                                 40
     C  N40              MOVE      ' '           V(X)
     C                   ENDDO
     C     W(1)          IFEQ      '0'
     C                   MOVE      ' '           W(1)
     C                   ENDIF
     C                   SELECT
      * zone date
     C     WHFLDT        WHENeq    'L'
     C                   MOVE      *blank        XHFLDD
     C                   MOVE      *blank        XHFLDP
     C                   MOVE      *blank        wHFLDD
     C                   MOVE      *blank        wHFLDP
      * zone horodatage
     C     WHFLDT        WHENeq    'T'
     C                   MOVE      *blank        XHFLDD
     C                   MOVE      *blank        XHFLDP
     C                   MOVE      *blank        wHFLDD
     C                   MOVE      *blank        wHFLDP
      * zone alpha
     C     WHFLDD        WHENEQ    0
     C                   MOVEA     XHFLDB        T(30)
     C                   MOVEA     '  '          T(36)
      * zone signée
     C     WHFLDD        WHENEQ    WHFLDB
     C                   MOVEA     XHFLDD        T(33)
     C                   MOVEA     XHFLDP        T(36)
      * zone packee
     C     WHFLDD        WHENNE    WHFLDB
     C                   MOVEA     XHFLDD        T(33)
     C                   MOVEA     XHFLDP        T(36)
     C                   ENDSL
     C                   MOVEA     WHFLDT        T(35)
     C                   MOVE      *BLANKS       WKA036           36
      * texte zone
     C     WHFTXT        IFNE      *BLANKS
     C     '''':' '      XLATE     WHFTXT        WHFTXT
     C     ' '           CHECKR    WHFTXT        WKN002            2 0
     C     WKN002        IFGT      28
     C                   MOVEL     WHFTXT        WKA027           27
     C                   MOVE      WHFTXT        WKA023           23
     C     'TEXT('''     CAT       WKA027:0      WKA036
     C     WKA036        CAT       '+':0         WKA036
     C                   MOVEA     WKA036        T(45)
     C                   EXSR      WTR
     C                   MOVE      *BLANKS       WKA036
     C     WKA023        CAT       ''')':0       WKA036
     C                   MOVEA     WKA036        T(45)
     C                   EXSR      WTR
     C                   ELSE
     C     'TEXT('''     CAT       WHFTXT:0      WKA036
     C     WKA036        CAT       ''')':0       WKA036
     C                   MOVEA     WKA036        T(45)
     C                   EXSR      WTR
     C                   ENDIF
     C                   ENDIF
      * colhdg
     C     WHCHD1        IFNE      *BLANKS
     C     '''':' '      XLATE     WHCHD1        WHCHD1
     C                   MOVE      *BLANKS       WKA036
     C     'COLHDG('''   CAT       WHCHD1:0      WKA036
     C     WHCHD2        IFNE      *BLANKS
     C     WKA036        CAT       ''' +':0      WKA036
     C                   ELSE
     C     WKA036        CAT       ''')':0       WKA036
     C                   ENDIF
     C                   MOVEA     WKA036        T(45)
     C                   EXSR      WTR
     C                   ENDIF
     C     WHCHD2        IFNE      *BLANKS
     C     '''':' '      XLATE     WHCHD2        WHCHD2
     C                   MOVE      *BLANKS       WKA036
     C     ''''          CAT       WHCHD2:0      WKA036
     C     WHCHD3        IFNE      *BLANKS
     C     WKA036        CAT       ''' +':0      WKA036
     C                   ELSE
     C     WKA036        CAT       ''')':0       WKA036
     C                   ENDIF
     C                   MOVEA     WKA036        T(45)
     C                   EXSR      WTR
     C                   ENDIF
     C     WHCHD3        IFNE      *BLANKS
     C     '''':' '      XLATE     WHCHD3        WHCHD3
     C                   MOVE      *BLANKS       WKA036
     C     ''''          CAT       WHCHD3:0      WKA036
     C     WKA036        CAT       ''')':0       WKA036
     C                   MOVEA     WKA036        T(45)
     C                   EXSR      WTR
     C                   ENDIF
      * Format de la date.
     C     WHFMT         IFNE      *BLANKS
     c     WHFLDT        andeq     'L'
     C                   eval      WKA036='DATFMT('+WHFMT+')'
     C                   MOVEA     WKA036        T(45)
     C                   EXSR      WTR
     C                   ENDIF
      * Format de l'heure
     C     WHFMT         IFNE      *BLANKS
     c     WHFLDT        andeq     'T'
     C                   eval      WKA036='TIMFMT('+WHFMT+')'
     C                   MOVEA     WKA036        T(45)
     C                   EXSR      WTR
     C                   ENDIF
      *
     CLR                 EXSR      ROOT
      *
     CSR   WTR           BEGSR
     C                   ADD       10            SRCSEQ
     C                   MOVEA     'A'           T(6)
     C                   WRITE     SOURCE
     C                   MOVEA     *BLANKS       T
     CSR                 ENDSR
      *
     CSR   ROOT          BEGSR
     C     REDO          TAG
     C     APKEYF        IFNE      *BLANKS
     C                   MOVEA     'K'           T(17)
     C                   MOVEA     APKEYF        T(19)
     C     APKSEQ        IFEQ      'D'
     C                   MOVEA     'DESCEND'     T(45)
     C                   ENDIF
     C                   EXSR      WTR
     C                   ENDIF
     C     *IN41         IFNE      '1'
     C                   READ      RTVPFSRC1                              41
     C  N41              GOTO      REDO
     C                   ENDIF
     CSR                 ENDSR
**
 123456789
