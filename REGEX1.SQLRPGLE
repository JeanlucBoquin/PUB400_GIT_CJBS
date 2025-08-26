**FREE
CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER) OPTION(*SRCSTMT: *NODEBUGIO);

// /* Declaración de variables */
dcl-s nombreCliente varchar(50);
dcl-s idCliente     int(10);
// DCL-DS CLIENTE qualified;
//     NOMBRE      CHAR(128);
// END-DS;
DCL-S TABLE_NAME CHAR(128);
DCL-S coincidencias ZONED(4:0);
DCL-S tiempoInicial TIME;
DCL-S tiempoFinal   TIME;
DCL-S DIFERENCIA_TIEMPOS   ZONED(10:0);

tiempoInicial = %TIME();

EXEC SQL DECLARE QRY_TABLES CURSOR FOR
    SELECT TABLE_NAME
        FROM QSYS2.SYSTABLES
        WHERE REGEXP_LIKE(TABLE_SCHEMA,'CJB4033.*');

EXEC SQL OPEN QRY_TABLES;
EXEC SQL FETCH QRY_TABLES INTO :TABLE_NAME;

DOW SQLSTATE = '00000';
    // $array_detalleOBJ = %SPLIT($detalleOBJ:' ');
    coincidencias += 1;
    EXEC SQL FETCH QRY_TABLES INTO :TABLE_NAME;
ENDDO;

EXEC SQL CLOSE QRY_TABLES;

tiempoFinal = %TIME();
DIFERENCIA_TIEMPOS = %DIFF(tiempoFinal : tiempoInicial : *SECONDS);


DSPLY ('Tiempo: ' + %CHAR(DIFERENCIA_TIEMPOS) + ' - Coincidencias: ' + %CHAR(coincidencias));

*INLR = *ON;
