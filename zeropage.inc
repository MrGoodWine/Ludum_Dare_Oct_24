
; Direct page
.enum $00
	; Updated each time VBlank runs
	framecount: dw
	tmpw1: dw


	tmpspriteptr: dw

	dp_indirect_tmp1: dw

	; Holds a temp. value for the solver
	dp_slv_tmpval: dw

	;dp_slv_emptyCells: dsw 82
	dp_slv_sorttmp: dw
;	dp_slv_nextEmpty: dw

;	dp_rescan: dw
	griddata: dsw 81

	dp_text_ptr: dsb 3
	dp_text_tmp: dw
.ende


