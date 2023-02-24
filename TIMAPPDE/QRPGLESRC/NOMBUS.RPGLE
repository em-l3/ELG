     Fmaeclil3  if   e           k disk
     Fmenubnom  cf   e             workstn sfile(subarch:numreg)
     F                                     indds(indicadores)

     D numreg          s              5p 0

     D indicadores     ds
     D    exitKey                      n   overlay(indicadores:3)
     D    restartKey                   n   overlay(indicadores:4)
     D    sflClear                     n   overlay(indicadores:55)
     D    rollupKey                    n   overlay(indicadores:95)
     D    nomfound                     n   overlay(indicadores:52)

     C     cstkey        klist
     C                   kfld                    srcnam

     C     zipkey        klist
     C                   kfld                    nomb

      /free
        write pie1;
        write head;
        exfmt solicit;
        dow not exitKey;
            setll cstkey regclie;
            if %equal(maeclil3);
                exsr ProcessSubfile;
                exsr DisplayCustomerDetail;
            endif;
            if exitKey;
               leave;
            endif;
            if restartKey;
               iter;
            endif;
            if not %equal(maeclil3);
               nomfound=*on;
            endif;
            exfmt solicit;
        enddo;
        *inlr = *on;

        begsr ProcessSubfile;
              dou not rollupKey;
                  if not %eof(maeclil3);
                     exsr ClearSubfile;
                     exsr FillSubfile;
                  endif;
                  write pie2;
                  exfmt subctl;
              enddo;
        endsr;

        begsr FillSubfile;
              numreg = 0;
              dou %eof(menubnom);
                  read regclie;
                  if %eof(maeclil3);
                     leavesr;
                  endif;
                  numreg = numreg + 1;
                  sel = *blank;
                  write subarch;
              enddo;
        endsr;

        begsr ClearSubfile;
              sflClear = *on;
              write subctl;
              sflClear = *off;
        endsr;

        begsr DisplayCustomerDetail;
              readc subarch;
              dow not %eof(menubnom);
                  restartKey = *on;
                  chain zipkey regclie;
                  exfmt cusdsp;
                  if exitKey;
                     leave;
                  endif;
                  readc subarch;
              enddo;
        endsr;
      /end-free
