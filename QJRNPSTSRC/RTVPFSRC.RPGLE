      * >>PRE-COMPILER<<                                              */
      *   >>CRTCMD<<  CRTBNDRPG SRCFILE(&SL/&SF) SRCMBR(&SM);         */
      *   >>IMPORTANT<<                                               */
      *     >>PARM<<  PGM(&LI/&OB);                                   */
      *     >>PARM<<  OPTION(*EVENTF);                                */
      *     >>PARM<<  DBGVIEW(*LIST);                                 */
      *     >>PARM<<  TRUNCNBR(*NO);                                  */
      *   >>END-IMPORTANT<<                                           */
      *   >>CMD<<  DSPFD FILE(QGPL/QDDSSRC) TYPE(*ACCPTH) +           */
      *            OUTPUT(*OUTFILE) OUTFILE(QTEMP/RTVPFSRC1);         */
      *   >>CMD<<  DSPFFD FILE(QGPL/QDDSSRC) OUTPUT(*OUTFILE) +       */
      *            OUTFILE(QTEMP/RTVPFSRC);                           */
      *   >>EXECUTE<<                                                 */
      * >>END-PRE-COMPILER<<                                          */
       Dcl-F QDDSSRC usage(*output) RENAME(QDDSSRC:SOURCE);
       Dcl-F RTVPFSRC  usage(*input);
       Dcl-F RTVPFSRC1 usage(*input);
       Dcl-Ds SRCDTA;
         T char(1) DIM(80);
       End-ds;

       Dcl-ds XHFLDP;
         U char(1) DIM(2);
       end-ds;

       Dcl-ds XHFLDB;
         V char(1) DIM(5);
       End-ds;

       Dcl-ds XHFLDD;
        W char(1) DIM(2);
       End-ds;

       Dcl-s ED1 char(1) DIM(10) CTDATA PERRCD(10);
       Dcl-s x packed(2:0);
       Dcl-s y packed(2:0);
       Dcl-S WKN002 packed(2:0);
       Dcl-s WKA023 char(23);
       Dcl-s WKA027 char(27);
       Dcl-s WKA036 char(36);

      // format fichier

       READ RTVPFSRC;
       Dow not %eof(RTVPFSRC);
         READ RTVPFSRC1;
         *IN41 = %EOF;
         Reset T;
         %subarr(T:19:%len( %trim(WHFLDI)))=WHFLDI;
         XHFLDP=%char(WHFLDP);
         XHFLDB=%char(WHFLDB);
         XHFLDD=%char(WHFLDD);

         // cadrage droite zero suppress
         IF U(1) = '0';
           Reset U(1);
         ENDIF;

         For X=1 to 4;
           y=+1;
           *in40=%lookup(V(X):ED1)<>0;
           If not *in40;
             Reset V(X);
           EndIf;
         Endfor;

         IF W(1) = '0';
           Reset W(1);
         ENDIF;

         SELECT;
         // zone date
         WHEN WHFLDT = 'L';
           Reset XHFLDD;
           Reset XHFLDP;
           Reset WHFLDD;
           Reset wHFLDP;
         // zone horodatage
         WHEN WHFLDT = 'T';
           Reset XHFLDD;
           Reset XHFLDP;
           Reset wHFLDD;
           Reset wHFLDP;
         // zone alpha
         WHEN WHFLDD = 0;
           %Subarr(T:30:%len(%trim(XHFLDB)))=XHFLDB;
           Reset T(36);
         WHEN WHFLDD = WHFLDB;
           %subarr(T:33:%len(%trim(XHFLDD)))=XHFLDD;
           %subarr(T:36:%len(%trim(XHFLDP)))=XHFLDP;
         // zone packee
         WHEN WHFLDD <> WHFLDB;
           %subarr(T:33:%len(%trim(XHFLDD)))=XHFLDD;
           %subarr(T:36:%len(%trim(XHFLDP)))=XHFLDP;
         ENDSL;

         %subarr(T:35:%len(%trim(WHFLDT)))=WHFLDT;

         Reset WKA036;
         IF WHFTXT <> *BLANKS;
           WHFTXT=%Xlate('''':' ':WHFTXT);
           WKN002=%Checkr(' ':WHFTXT);
           IF WKN002 > 28;
             WKA027=WHFTXT;
             *in27=*on;
             WKA023=WHFTXT;
             *in23=*on;
             WKA036='TEXT(''' + WKA027;
             WKA036=WKA036 + '+';
             %subarr(T:45:%len(%trim(WKA036)))=WKA036;

             EXSR WTR;

             Reset WKA036;
             WKA036=WKA023 + ''')';
             %subarr(T:45:%len(%trim(WKA036)))=WKA036;

             EXSR WTR;
           ELSE;
             WKA036='TEXT(''' + WHFTXT;
             WKA036=WKA036 + ''')';
             %subarr(T:45:%len(%trim(WKA036)))=WKA036;
             EXSR WTR;
           ENDIF;
         ENDIF;

         // colhdg
         IF WHCHD1 <> *BLANKS;
           WHCHD1=%XLATE('''':' ':WHCHD1);
           Reset WKA036;
           WKA036='COLHDG(''' + WHCHD1;
           IF WHCHD2 <> *BLANKS;
             WKA036=WKA036 + ''' +';
           ELSE;
             WKA036=WKA036 + ''')';
           ENDIF;
           %subarr(T:45:%len(%trim(WKA036)))=WKA036;
           EXSR WTR;
         ENDIF;

         IF WHCHD2 <> *BLANKS;
           WHCHD2=%xlate('''':' ':WHCHD2);
           Reset WKA036;
           WKA036='''' + WHCHD2;

           IF WHCHD3 <> *BLANKS;
             WKA036=WKA036 + ''' +';
           ELSE;
             WKA036=WKA036 + ''')';
           ENDIF;

           %subarr(T:45:%len(%trim(WKA036)))=WKA036;
           EXSR WTR;
         ENDIF;

         IF WHCHD3 <> *BLANKS;
           WHCHD3 = %xlate('''':' ':WHCHD3);
           Reset WKA036;
           WKA036='''' + WHCHD3;
           WKA036=WKA036 +  ''')';
           %subarr(T:45:%len(%trim(WKA036)))=WKA036;
           EXSR WTR;
         ENDIF;
         // Format de la date.

         IF WHFMT <> *BLANKS
         AND WHFLDT = 'L';
           WKA036='DATFMT('+WHFMT+')';
           %subarr(T:45:%len(%trim(WKA036)))=WKA036;
           EXSR WTR;
         ENDIF;

         // Format de l'heure
         IF WHFMT <> *BLANKS
         AND WHFLDT = 'T';
           WKA036='TIMFMT('+WHFMT+')';
           %subarr(T:45:%len(%trim(WKA036)))=WKA036;
           EXSR WTR;
         ENDIF;

         If *inlr;
           EXSR ROOT;
         EndIf;

         read rtvpfsrc;
         *inlr=%eof(rtvpfsrc);
       Enddo;


       BEGSR WTR;
         SRCSEQ+=10;
         T(6)='A';
         WRITE SOURCE;
         Reset T;
       ENDSR;

       //
       BEGSR ROOT;
         Dou *in41;
           IF APKEYF <> *BLANKS;
             T(17)='K';
             %subarr(T:9:%len(%trim(APKEYF)))=APKEYF;

             IF APKSEQ = 'D';
               %Subarr(T:45:7)='DESCEND';
             ENDIF;
             EXSR WTR;
           ENDIF;

           READ RTVPFSRC1;
           *IN41 = %EOF;
         Enddo;

       ENDSR;
**
 123456789
