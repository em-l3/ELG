             CMD        PROMPT('COMPARA ARCHIVO FÍSICO')

             PARM       KWD(FILEATR) TYPE(*CHAR) LEN(2) RSTD(*YES) +
                          DFT(F) VALUES(F LF PF) CHOICE('F = L Y P  +
                          LF = LÓG  PF = PHY') PROMPT('TIPO DE +
                          ARCHIVOS A COMPARAR')

             PARM       KWD(PRINT) TYPE(*CHAR) LEN(6) RSTD(*YES) +
                          VALUES(*PRINT) CHOICE('* *PRINT') +
                          PROMPT('IMPRIMIR O VER SUBFILE')
/*           PARM       KWD(MAIL) TYPE(*CHAR) LEN(40) RSTD(*NO) +
                          CHOICE('Correo de usuario') +
                          PROMPT('Correo de usuario')                  */

