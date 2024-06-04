FUNCTION zvsm_func_edad.
*"----------------------------------------------------------------------
*"*"Interfase local
*"  IMPORTING
*"     REFERENCE(FECHA_NAC) TYPE  SY-DATUM
*"  CHANGING
*"     REFERENCE(STRUC_EDAD) TYPE  ZVSM_EDAD_STRU
*"  EXCEPTIONS
*"      EDAD_FUERA_RANGO
*"----------------------------------------------------------------------

  DATA: zyears(4)  TYPE c,
        zmonths(2) TYPE c,
        zdays(2)   TYPE c.

* GT: Es mayor que ...
* SY-DATUM: Contiene la fecha del dia del sistema.
* RAISE: Indica que se ha producido un error o condiccion excepcional.
  IF fecha_nac GT sy-datum.
    RAISE edad_fuera_rango.
  ENDIF.

* Las fechas se almacenan en un orden inverson
* Ordenar la lectura de la fecha(19771122) = 22.11.1977.
  zyears = fecha_nac+0(4).
  zmonths = fecha_nac+4(2).
  zdays = fecha_nac+6(2).
  zyears = sy-datum+0(4) - zyears.

* LT: Es menor que ...
  IF sy-datum+4(2) LT zmonths.
    zyears = zyears - 1.
    zmonths = sy-datum+4(2) + 1.
  ENDIF.

  IF sy-datum+6(2) LT zdays.
    zdays = 30 - zdays.
    zmonths = zmonths - 1.
    zdays = + sy-datum+6(2).
  ENDIF.

  struc_edad-zyears = zyears.
  struc_edad-zmonths = zmonths.
  struc_edad-zdays = zdays.

ENDFUNCTION.
