     Fmaeclil1  uf a e           k disk
     Fmenumnt   cf   e             workstn indds(indicadores)

     D indicadores     ds
     D   exitKey                       n   overlay(indicadores:3)
     D   disableInput                  n   overlay(indicadores:4)
     D   addKey                        n   overlay(indicadores:5)
     D   updateKey                     n   overlay(indicadores:6)
     D   deleteKey                     n   overlay(indicadores:7)
     D   displayKey                    n   overlay(indicadores:8)
     D   prevKey                       n   overlay(indicadores:12)
     D   custExists                    n   overlay(indicadores:51)
     D   custNotFound                  n   overlay(indicadores:52)
     D   custBlank                     n   overlay(indicadores:53)
     D   nameBlank                     n   overlay(indicadores:54)

     C     CSTKEY        klist
     C                   kfld                    clie

      /free
        modalidad = 'DISPLAY';
        exfmt hdrscn;
        dow not exitKey;
           exsr SetMaintenanceMode;
           if clie <> 0;
             if modalidad = 'ADD';
                 exsr AddSub;
             elseif modalidad = 'UPDATE';
                 exsr UpdateSub;
             elseif modalidad = 'DELETE';
                 exsr DeleteSub;
             elseif modalidad = 'DISPLAY';
                 exsr InquirySub;
             endif;
          else;
             CustBlank=*on;
          endif;
        modalidad = 'DISPLAY';
        exfmt hdrscn;
        custExists = *off;
        CustNotFound = *off;
        CustBlank=*off;
        nameBlank = *off;
        enddo;
        *inlr = *on;

        begsr AddSub;
              chain CstKey cmlrec1;
              if %found(maeclil1);
                 custExists = *on;
                 leavesr;
              endif;
              custExists = *off; // desactivar mensajes de error
              CustNotFound = *off;
              CustBlank=*off;
              nameBlank = *off;
              nomb = *blank;
              dire1= *blank;
              dire2= *blank;
              cdad = *blank;
              prov = *blank;
              cdp = 0;
              exfmt cstbld;
              if not *in12;
                  if nomb = *blanks;
                      nameBlank = *on;
                      exfmt cstbld;
                  else;
                      write cmlrec1;
                  endif;
              endif;
        endsr;

        begsr UpdateSub;
              chain clie cmlrec1;
              if not %found(maeclil1);
                 custNotFound = *on;
                 leavesr;
              endif;
              disableInput = *off;
              exfmt cstinq;
              if not prevKey;
                 update cmlrec1;
              else;
                 unlock maeclil1;
              endif;
        endsr;

        begsr DeleteSub;
              chain clie cmlrec1;
              if not %found(maeclil1);
                 custNotFound = *on;
                 leavesr;
              endif;
              disableInput = *on;
              exfmt cstinq;
              if not prevKey;
                 delete cmlrec1;
              else;
                 unlock maeclil1;
              endif;
        endsr;

        begsr InquirySub;
              chain(n) clie cmlrec1; // no bloquee el registro
              if not %found(maeclil1);
                 custNotFound = *on;
                 leavesr;
              endif;
              disableInput = *on;
              exfmt cstinq;
        endsr;

        begsr SetMaintenanceMode;
              if addKey;
                 modalidad = 'ADD';
              elseif updateKey;
                 modalidad = 'UPDATE';
              elseif deleteKey;
                 modalidad = 'DELETE';
              elseif displayKey;
                 modalidad = 'DISPLAY';
              endif;
        endsr;
      /end-free
