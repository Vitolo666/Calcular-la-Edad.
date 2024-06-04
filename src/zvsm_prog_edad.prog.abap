*&---------------------------------------------------------------------*
*& Report ZVSM_PROG_EDAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvsm_prog_edad.

DATA: struc_edad TYPE zvsm_edad_stru.

*&---------------------------------------------------------------------*
*& SELECTION-SCREEN
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK data WITH FRAME.
  PARAMETERS:
  p_fecha TYPE sy-datum.
SELECTION-SCREEN END OF BLOCK data.

*&---------------------------------------------------------------------*
*& START-OF-SELECTION
*&---------------------------------------------------------------------*

START-OF-SELECTION.

  CALL FUNCTION 'ZVSM_FUNC_EDAD'
    EXPORTING
      fecha_nac        = p_fecha
    CHANGING
      struc_edad       = struc_edad
    EXCEPTIONS
      edad_fuera_rango = 1
      OTHERS           = 2.

  IF sy-subrc <> 0.
* Implement suitable error handling here
    WRITE: 'La edad ingresada esta fuera del rango'.
  ELSE.
    WRITE: 'Su edad actual es',
    struc_edad-zyears, 'Años',
    struc_edad-zmonths, 'Meses',
    struc_edad-zdays, 'Días'.
  ENDIF.
