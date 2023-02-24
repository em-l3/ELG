     Fmaeclil2  if   e           k disk
     Fmenubcod  cf   e             workstn sfile(subarch:recnum)
     F                                     indds(indicadores)

     D recnum          s              5p 0
     D recordFound     s               n

     D indicadores     ds
     D    exitKey                      n   overlay(indicadores:3)
     D    restartKey                   n   overlay(indicadores:4)
     D    sflClear                     n   overlay(indicadores:55)
     D    zipNotFound                  n   overlay(indicadores:61)
     D    rollupKey                    n   overlay(indicadores:95)

     C     cstkey        klist
     C                   kfld                    cdp

      /free
        write pie1;
        write cabecera;
        exfmt solicit;
        dow not exitKey;
            setll cstkey cmlrec2;
            recordFound = %equal(maeclil2);
            if recordFound;
               exsr ProcessSubfile;
            endif;
            if exitKey;
               leave;
            endif;
            if restartKey;
               iter;
            endif;
            if not recordFound;
               zipNotFound = *on;
            endif;
            exfmt solicit;
       enddo;
       *inlr = *on;


       begsr ProcessSubfile;
             dou not rollupKey;
                 if not %eof(maeclil2);
                    exsr ClearSubfile;
                    exsr FillSubfile;
                 endif;
                 write pie2;
                 exfmt subctl;
             enddo;
       endsr;

       begsr FillSubfile;
             recnum = 0;
             dou %eof(menubcod);
                 reade cdp cmlrec2;
                 if %eof(maeclil2);
                    leavesr;
                 endif;
                 recnum = recnum + 1;
                 write subarch;
             enddo;
       endsr;

       begsr ClearSubfile;
             sflClear = *on;
             write subctl;
             sflClear = *off;
       endsr;
      /end-free
