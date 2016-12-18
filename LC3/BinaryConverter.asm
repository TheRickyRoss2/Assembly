; Ric Rodriguez rirrodri
; Lab section 2
; Due 2/28/16

; registers
; r0 prints output
; r1 masks
; r4 number interator
; r3 ascii nums
; r2 digits
; r5, R4 temp nums
; r6 num converted

	.ORIG   x3000		; Start	
	LEA	R0, INTRO	; Load r0 with welcome
	LEA	R1, MASK	; Load r1 with mask
	LD 	R5, ZEROS	; Load r5 with 1's
	LD	R6, ONES	; Load r6 with 0's
	PUTS			; print out message

CHARIN	GETC		; Character input
	ADD	R4, R0, -10	; get ascii char
	BRz	LINEN		; if return then exit
	LD	R3, CHARX
	ADD	R4, R0, R3
	BRz	END		; end if input is X
	LD	R3, OFFSET
	ADD	R4, R4, R3
	BRz	END		; end if input is x
	OUT		; echo entered char
	LD	R3, NEG
	ADD	R4, R0, R3
	BRnp	NEXTCHAR	; Ignore negative flag if charater is a number
	NOT	R6, R6
	BR	CHARIN

NEXTCHAR	LD	R3, ASCIIOF	; fill number
	ADD	R2, R0, R3	; store digit in R2
	AND	R4, R4, 0
	ADD R4, R4, 9	; loop counter
	AND	R3, R3, 0	; reset r3
	ADD	R3, R3, R5	; add R6(ones) to r3

LOOP	ADD	R5, R5, R3
	ADD	R4, R4, -1
	BRp	LOOP	
	ADD	R5, R5, R2	; add digit to R2
	BR	CHARIN		; return to charin for more input

LINEN	AND	R0, R0, 0	; RESET R0	
	ADD	R0, R0, 10	; prepare LINENine in r0
	OUT			; print LINENine
	AND	R4, R4, 0	; reset R4
	ADD R4, R4, 15	; loop 16 times
	LD	R3, ASCIIOF	; set r3 to ascii 0
	NOT	R3, R3
	ADD	R3, R3, 1
	NOT	R6, R6
	BRz	PLUS		; adds to see if positive
	NOT	R5, R5
	ADD	R5, R5, 1	; convert to 2s comp

PLUS	AND	R0, R0, 0	; reset r0
	ADD	R0, R0, R3	; load r3 into r0
	LDR	R6, R1, 0	; load r6 with r1 for holding
	AND	R2, R5, R6	; and with mask
	BRnp	OUTONE
	OUT
	BR	POSLINE		; print a 0
	
OUTONE	ADD	R0, R0, 1
	OUT		; print a 1

POSLINE	ADD	R1, R1, 1	; reduce counter by 1
	ADD R4, R4, -1
	BRzp	PLUS		; loop until zero
	LEA	R0, NXTNUM	; reset prompt
	LEA	R1, MASK
	LD	R5, ZEROS
	LD	R6, ONES
	PUTS			; print out prompt
	BR	CHARIN		; char in loop back

END	AND R0, R0, 0
	LEA R0, EXIT
	PUTS
	HALT

INTRO	.STRINGZ "Welcome to the conversion program. Enter a number:\n"
EXIT	.STRINGZ "\n\nHave a good day!\n"
NXTNUM	.STRINGZ "\n\nEnter a number or X to quit:\n"
CHARX	.FILL	-88
OFFSET	.FILL	-32
NEG		.FILL	-45
ASCIIOF	.FILL	-48
ZEROS	.FILL	0
PUTS	TRAP	x22
HALT	TRAP 	x25
OUT		TRAP	x21
GETC	TRAP	x20
ONES	.FILL	xFFFF
MASK	.FILL	x8000
		.FILL	x4000
		.FILL	x2000
		.FILL	x1000
		.FILL	x0800
		.FILL	x0400
		.FILL	x0200
		.FILL	x0100
		.FILL	x0080
		.FILL	x0040
		.FILL	x0020
		.FILL	x0010
		.FILL	x0008
		.FILL	x0004
		.FILL	x0002
		.FILL	x0001

	.END