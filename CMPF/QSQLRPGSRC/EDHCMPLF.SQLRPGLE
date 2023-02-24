     **FREE
        Dcl-F EDHCMPFW WORKSTN SFILE(SFL:RECNO);
        Dcl-F EDHCMPFP printer USROPN OFLIND(OverFlow);

        Dcl-S recno int(10);
        Dcl-S RPrd zoned(10);
        Dcl-S RDRP zoned(10);
        Dcl-S OverFlow ind;

        Dcl-PI *N;
          Obj  Char(10);
          Lib  Char(10);
          Print Char(6);
          Mail Char(40);
          tyme Time(*HMS);
        End-PI;

        Dcl-DS Data1;
          MBFCDT char(6);
          MBFCTM char(6);
          MBNRCD zoned(10);
        End-DS;

        Dcl-DS Data2;
           D2MBLIB  char(10);
           D2MBFILE char(10);
           D2MBNAME char(10);
           D2MBFATR char(6);
           D2MBNDTR zoned(10);
           D2MBNRCD zoned(10);
           D2MBSYSN char(8);
        End-DS;

        Dcl-DS Data3;
           D3MBNDTR zoned(10);
           D3MBNRCD zoned(10);
           D3MBSYSN char(8);
        End-DS;

         exec sql
         SET OPTION
              commit=*none,
              datfmt=*iso;

         if print = '*PRINT';
           EXSR SRPRINT;
         Else;
           EXSR SRSHOW;
         EndIf;

        *Inlr = *On;

        begsr SRSHOW;
           *IN30 = *OFF;
           *IN31 = *OFF;
         WRITE CTL;
         WRITE FOOT;

          exec sql
             select MBFCDT, MBFCTM, MBNRCD into :Data1 FROM
               cmpfco WHERE MBFILE = 'CMPLFPRD';
            FECHAREC  = MBFCDT;
            HORAREC   = MBFCTM;
            MBNRCDPRD = MBNRCD;

          exec sql
             select MBFCDT, MBFCTM, MBNRCD, MBSYSN into :Data1 FROM
               cmpfco WHERE MBFILE = 'CMPLFDRP';
            MBNRCDDRP = MBNRCD;

          recno = 1;
          exec sql
             declare C1 cursor for
             select MBLIB, MBFILE, MBNAME, MBFATR, MBNDTR, MBNRCD, MBSYSN
               from CMPLFPRD;

           exec sql
             Open C1;

          Dou sqlcod <> 0;
          exec sql
            Fetch C1 INTO :Data2;



           recnumber = recno;


            If (sqlcod <> 0);
              Leave;
            Endif;

               PMBLIB  =  D2MBLIB;
               PMBFILE =  D2MBFILE;
               PMBNAME =  D2MBNAME;
               PMBFATR =  D2MBFATR;
               PMBNDTR =  %char(D2MBNDTR);
               PMBNRCD =  %char(D2MBNRCD);

          exec sql
             select MBNDTR, MBNRCD, MBSYSN into :Data3 FROM
               CMPLFDRP WHERE
                     MBLIB = :D2MBLIB AND MBFILE = :D2MBFILE AND
                      MBNAME = :D2MBNAME AND MBFATR = :D2MBFATR;

             if sqlcod = 100;
               *in70 = *on;
               CMBNDTR = '----------';
               CMBNRCD = '----------';
               ok = '--';
               SQLCOD = 0;
             else;
               CMBNDTR =  %char(D3MBNDTR);
               CMBNRCD =  %char(D3MBNRCD);
               If PMBNDTR = CMBNDTR AND PMBNRCD = CMBNRCD;
               *in70 = *off;
                 ok = 'Ok';
               Else;
               *in70 = *on;
                 ok = '--';
               EndIf;
             EndIf;
           WRITE SFL;

           recno += 1;

           Enddo;

           //Close the cursor
           exec sql
             Close C1;

            PMBSYSN = D2MBSYSN;

          exec sql
             declare C2 cursor for
             select MBLIB, MBFILE, MBNAME, MBFATR, MBNDTR, MBNRCD, MBSYSN
               from CMPLFDRP;

           exec sql
             Open C2;

          Dou sqlcod <> 0;
          exec sql
            Fetch C2 INTO :Data2;



           recnumber = recno;


            If (sqlcod <> 0);
              Leave;
            Endif;

               PMBLIB  =  D2MBLIB;
               PMBFILE =  D2MBFILE;
               PMBNAME =  D2MBNAME;
               PMBFATR =  D2MBFATR;
               CMBNDTR =  %char(D2MBNDTR);
               CMBNRCD =  %char(D2MBNRCD);

          exec sql
             select MBNDTR, MBNRCD, MBSYSN into :Data3 FROM
               CMPLFPRD WHERE
                     MBLIB = :D2MBLIB AND MBFILE = :D2MBFILE AND
                      MBNAME = :D2MBNAME AND MBFATR = :D2MBFATR;

             if sqlcod = 100;
               *in70 = *on;
               PMBNDTR = '----------';
               PMBNRCD = '----------';
               ok = '--';
               SQLCOD = 0;
               WRITE SFL;
               recno += 1;
             EndIf;


           Enddo;

           //Close the cursor
           exec sql
             Close C2;

            CMBSYSN = D2MBSYSN;

           *IN30 = *ON;
           *IN31 = *ON;
           dow *in12 = *off;
             if *in22 = *on;
                *in22 = *off;
                SYSNAME1 = PMBSYSN;
                exsr SRPRINT;
             EndIf;
             exfmt     ctl;
           enddo;
        endsr;

        begsr SRPRINT;
         OPEN EDHCMPFP;
         WRITE HEADER;

         Recnumber = 1;

          exec sql
             declare P1 cursor for
             select MBLIB, MBFILE, MBNAME, MBFATR, MBNDTR, MBNRCD, MBSYSN
               from CMPLFPRD;

           exec sql
             Open P1;

          Dou sqlcod <> 0;
          exec sql
            Fetch P1 INTO :Data2;

            If (sqlcod <> 0);
              Leave;
            Endif;

               PMBLIB  =  D2MBLIB;
               PMBFILE =  D2MBFILE;
               PMBNAME =  D2MBNAME;
               PMBFATR =  D2MBFATR;
               PMBNDTR =  %char(D2MBNDTR);
               PMBNRCD =  %char(D2MBNRCD);

          exec sql
             select MBNDTR, MBNRCD, MBSYSN into :Data3 FROM
               CMPLFDRP WHERE
                     MBLIB = :D2MBLIB AND MBFILE = :D2MBFILE AND
                      MBNAME = :D2MBNAME AND MBFATR = :D2MBFATR;

             if sqlcod = 100;
               *in70 = *on;
               CMBNDTR = '----------';
               CMBNRCD = '----------';
               ok = '--';
               SQLCOD = 0;
             else;
               CMBNDTR =  %char(D3MBNDTR);
               CMBNRCD =  %char(D3MBNRCD);
               If PMBNDTR = CMBNDTR AND PMBNRCD = CMBNRCD;
               *in70 = *off;
                 ok = 'Ok';
               Else;
               *in70 = *on;
                 ok = '--';
               EndIf;
             EndIf;

            if OverFlow = *ON;
              write footer;
              write header;
              OverFlow = *OFF;
            endif;
           WRITE DETAIL;

           recNumber += 1;

           Enddo;

           //Close the cursor
           exec sql
             Close P1;

          exec sql
             declare P2 cursor for
             select MBLIB, MBFILE, MBNAME, MBFATR, MBNDTR, MBNRCD, MBSYSN
               from CMPLFDRP;

           exec sql
             Open P2;

          Dou sqlcod <> 0;
          exec sql
            Fetch P2 INTO :Data2;


            If (sqlcod <> 0);
              Leave;
            Endif;

               PMBLIB  =  D2MBLIB;
               PMBFILE =  D2MBFILE;
               PMBNAME =  D2MBNAME;
               PMBFATR =  D2MBFATR;
               CMBNDTR =  %char(D2MBNDTR);
               CMBNRCD =  %char(D2MBNRCD);

          exec sql
             select MBNDTR, MBNRCD, MBSYSN into :Data3 FROM
               CMPLFPRD WHERE
                     MBLIB = :D2MBLIB AND MBFILE = :D2MBFILE AND
                      MBNAME = :D2MBNAME AND MBFATR = :D2MBFATR;

             if sqlcod = 100;
               *in70 = *on;
               PMBNDTR = '----------';
               PMBNRCD = '----------';
               ok = '--';
               SQLCOD = 0;
                 if OverFlow = *ON;
                    write footer;
                    write header;
                    OverFlow = *OFF;
                 EndIf;
                 WRITE DETAIL;
                 recNumber += 1;
             EndIf;


           Enddo;

           //Close the cursor
           exec sql
             Close P2;

                 WRITE FOOTER;
         close edhcmpfp;
        endsr;

