             CMD        PROMPT('COMPARA ARCHIVOS DE 2 SISTEMAS')

             PARM       KWD(OBJ) TYPE(*CHAR) LEN(10) DFT(*ALL) +
                          CHOICE('Nombre - generico* - *ALL') +
                          PROMPT('Objeto')

             PARM       KWD(LIB) TYPE(*CHAR) LEN(10) RSTD(*NO) +
                          DFT(*CURLIB) CHOICE('Nombre') +
                          PROMPT('Biblioteca')
             PARM       KWD(IPDRP) TYPE(*CHAR) LEN(15) +
                          CHOICE(XXX.XXX.XXX.XXX) PROMPT('IP de +
                          sistema de contingencia')
             PARM       KWD(FILEATR) TYPE(*CHAR) LEN(2) RSTD(*YES) +
                          DFT(F) VALUES(F LF PF) CHOICE('F = L y P  +
                          LF = Lóg  PF = Phy') PROMPT('Tipo de +
                          archivos a comparar')

             PARM       KWD(PRINT) TYPE(*CHAR) LEN(6) RSTD(*YES) +
                          VALUES(*PRINT) CHOICE('* *PRINT') +
                          PROMPT('IMPRIMIR O VER SUBFILE')


  /*         PARM       KWD(MAIL) TYPE(*CHAR) LEN(40) RSTD(*NO) +
                          CHOICE('CORREO DE USUARIO') +
                          PROMPT('CORREO DE USUARIO')                   */



