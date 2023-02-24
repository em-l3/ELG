     Fmenuprin  cf   e             workstn indds(indicadores)

     D CustMaintain    pr                  extproc('MNTCLI')
     D SearchZip       pr                  extproc('BUSCOD')
     D SearchName      pr                  extproc('NOMBUS')

     D indicadores     ds
     D   exitKey                       n    overlay(indicadores:3)
     D   maintainKey                   n    overlay(indicadores:5)
     D   srchZipKey                    n    overlay(indicadores:6)
     D   srchCustKey                   n    overlay(indicadores:7)

      /free
       dow '1';
          exfmt hdrscn;
          if exitKey;
            leave;
           elseif maintainKey;
              CustMaintain();
           elseif srchZipKey;
              SearchZip();
           elseif srchCustKey;
              SearchName();
          endif;
       enddo;
       *inlr = *on;
      /end-free
