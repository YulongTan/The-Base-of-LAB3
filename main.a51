;------------------------------------
;-  Generated Initialization File  --
;TABLE1��˳ʱ����������ѭ���ı��
;TABLE3���������ʾ����0-9�ı��
;R0�洢��ʾ������
;R1 DELAY1MS�Ĵ���
;------------------------------------

$include (C8051F310.inc)
	  LED BIT P0.0
	  BEEP	BIT P3.1
	  KINT BIT P0.1
	  ORG 0000H
	  LJMP MAIN
	  ORG 0003H
	  LJMP INTT0 ;0300H
	  ORG 0100H
MAIN: ACALL Init_Device
      MOV SP,#1FH
      CLR BEEP
	  CLR F0
	  CLR PSW.1
START: MOV R0, #00H
       SETB P0.6
       SETB P0.7
       ACALL DISPLAY
       ACALL D2s
	   SETB BEEP
	   ACALL D0_5S
	   CLR BEEP	  
LOOP: ACALL KEYPRO   ;ѭ����˳��������
WAIT1: ACALL DISPLAY
      ACALL KEYPRO
      JNB F0, WAIT1
	  CLR F0
      ACALL KEYPRO   ;����Ƶ��
WAIT2: ACALL DISPLAY
      ACALL KEYPRO
	  JNB F0, WAIT2
	  CLR F0
	  ACALL NEWLIT
	  SJMP LOOP
;--------------------------------------------------------------------�ж�����-----------------------------------------------
;-------�ж�0����--------
      ORG 0300H
INTT0:
      CPL LED
      LCALL D0_5s
      CPL F0
	  SETB TR0
      RETI
;-------end---------
;---------------------------------------------------------------------�жϽ���---------------------------------------------------
;--------------------------------------------------------------------�ӳ�������--------------------------------------------------------------
;-----------------------------����ɨ��-----------------------------------
KEYPRO:ACALL KEXAM
      JC KEYPRO
	  ACALL D10ms
	  ACALL KEXAM
	  JC KEYPRO ;�ް�������ʱC=1
	  ACALL D10ms
	  ACALL KEXAM
	  JC KEYPRO
KEY1: MOV R2, #0FEH
      MOV R3, #0FFH  ;��ֵ�Ĵ���
	  MOV R4, #00H  ;��ֵ�Ĵ���
KEY2: 
      CLR P2.0
	  SETB P2.1
	  SETB P2.2
	  SETB P2.3
	  NOP
	  NOP
	  NOP
      MOV C, P2.4
	  ANL C, P2.5
	  ANL C, P2.6
	  ANL C, P2.7
	  JNC KEY3  ;�м����£�ת����ֵ
	  MOV A, R4  ;�޼����£���ֵ�Ĵ�����һ
	  ADD A, #01H
	  MOV R4, A
	  SETB P2.0
      CLR P2.1
	  SETB P2.2
	  SETB P2.3
	  NOP
	  NOP
	  NOP
      MOV C, P2.4
	  ANL C, P2.5
	  ANL C, P2.6
	  ANL C, P2.7
	  JNC KEY3  ;�м����£�ת����ֵ
	  MOV A, R4  ;�޼����£���ֵ�Ĵ�����һ
	  ADD A, #01H
	  MOV R4, A
	  SETB P2.0
	  SETB P2.1
      CLR P2.2
	  SETB P2.3
	  NOP
	  NOP
	  NOP
      MOV C, P2.4
	  ANL C, P2.5
	  ANL C, P2.6
	  ANL C, P2.7
	  JNC KEY3  ;�м����£�ת����ֵ
	  MOV A, R4  ;�޼����£���ֵ�Ĵ�����һ
	  ADD A, #01H
	  MOV R4, A	  
      CLR P2.3
	  NOP
	  NOP
	  NOP
      MOV C, P2.4
	  ANL C, P2.5
	  ANL C, P2.6
	  ANL C, P2.7
	  JNC KEY3  ;�м����£�ת����ֵ
	  CLR A
	  AJMP KEYPRO ;��ȫ��ɨ����ϣ��ȴ���һ��ɨ��
      
KEY3: MOV A, P2
KEY4: INC R3
	  RLC A
	  JC KEY4 ;C=1ʱ��ת
KEY5: ACALL D10ms
      ACALL KEXAM
	  JNC KEY5   ;�м�����,ת��KEY4,�ȴ����ͷ�
	  SETB P2.0
	  SETB P2.1
	  SETB P2.2
	  SETB P2.3
	  MOV A, #03H
	  CLR C
	  SUBB A, R3
	  MOV B, #04H
	  MUL AB
	  ADD A, R4
	  AJMP KEYADR
;--------�������Ƿ���-------
KEXAM:CLR P2.0
      CLR P2.1
	  CLR P2.2
	  CLR P2.3
	  NOP
	  NOP
	  NOP
	  MOV C, P2.4
	  ANL C, P2.5
	  ANL C, P2.6
	  ANL C, P2.7
	  SETB P2.0
	  SETB P2.1
	  SETB P2.2
	  SETB P2.3
	  RET
;--------������--------------
;---------���ܼ���ַת��------
KEYADR:CJNE A, #09H, KYARD1
       AJMP DIGPRO          ;DIGPRO���ּ�����
KYARD1:JC DIGPRO
KEYTBL:MOV DPTR, #JMPTBL
       CLR C
	   SUBB A, #10
	   RL A
	   JMP @A+DPTR
JMPTBL:AJMP FUNC1
       AJMP FUNC2
	   AJMP FUNC3
	   AJMP FUNC4
	   AJMP FUNC5
	   AJMP FUNC6
       RET
;----------����------------
;-------���ܰ�������-------
FUNC1:   
         SETB F0
         RET
FUNC2:   
         CPL PSW.1
		 MOV R0,#1
		 JB PSW.1, NEXT
		 MOV R0, #0
NEXT:    RET
FUNC3:   CPL LED
         RET
FUNC4:   CPL LED
         RET
FUNC5:   CPL LED
         RET
FUNC6:   CPL LED
         RET		 
//      AJMP KEYPRO
;-------����-------------
;-------���ְ�������---
DIGPRO:
       MOV DPTR, #JMPNUM
	   CLR C
	   RL A
	   JMP @A+DPTR
JMPNUM:AJMP NUM0
       AJMP NUM1
	   AJMP NUM2
	   AJMP NUM3
	   AJMP NUM4
	   AJMP NUM5
	   AJMP NUM6
	   AJMP NUM7
	   AJMP NUM8
	   AJMP NUM9
	   RET
;--------���ְ�������------
NUM0:  MOV R0,#0
       RET
NUM1:  MOV R0,#1
       RET
NUM2:  MOV R0,#2
       RET
NUM3:  MOV R0,#3
       RET
NUM4:  MOV R0,#4
       RET
NUM5:  MOV R0,#5
       RET
NUM6:  MOV R0,#6
       RET
NUM7:  MOV R0,#7
       RET
NUM8:  MOV R0,#8
       RET
NUM9:  MOV R0,#9
       RET
;       CPL LED
;       AJMP KEYPRO
;-------------------------------����ɨ�����------------------------------------------
;--------����ģʽ-----------
MOOD:  
FIRST:MOV R0, #0ECH
      SETB P0.7
	  SETB P0.6
      ACALL DISPLAY
	  SETB P0.7
	  CLR  P0.6
	  MOV R0, #02H
	  ACALL DISPLAY
	  CLR P0.7
	  SETB P0.6
	  MOV R0, #02H
	  ACALL DISPLAY
	  ACALL KEXAM
	  JC FIRST
	  ACALL KEYPRO
	  
;-----------END---------------
;-----ѭ�����Ƴ���--------
LIG:  mov R3,#6
      mov dptr,#TABLE1
LP_LIG: clr a
	  movc a,@a+dptr
	  mov P1,a
	  acall D0_5S
	  inc dptr
	  DJNZ R3,LP_LIG
	  ajmp LIG
	  ret
;--------end----------
;---------�������ʾ-------
DISPLAY: PUSH DPL
         PUSH DPH
         MOV A, R0
		 MOV DPTR,#TABLE3
		 MOVC A,@A+DPTR
		 MOV P1,A
		 ACALL D1ms
		 POP DPH
		 POP DPL
//		 DJNZ R0,DISPLAY
         RET
;--------����---------------
;------Ƶ�ʿɿص�ѭ������----
NEWLIT: MOV R3, #6
        MOV DPTR, #TABLE1
		JB PSW.1 ,LIT_LOP       ;PSW.1=1ʱ˳ʱ��ѭ��
        MOV DPTR, #TABLE2		;PSW.1=0ʱ��ʱ��ѭ��
LIT_LOP:
        CLR A
        MOVC A, @A+DPTR
		MOV R5, A
;		CLR P0.6
;		CLR P0.7
;		MOV P1, A
;		ACALL D1ms
		ACALL DELAY
		INC DPTR
		DJNZ R3, LIT_LOP
		AJMP NEWLIT
		RET
;------end------------------
;-------DELAY---------
DELAY: MOV A, #56
       MOV B, R0
	   DIV AB
	   MOV R1, A
INDEL:                   ;���3MS
       SETB P0.6
	   SETB P0.7
	   ACALL DISPLAY
       ACALL D1ms
       CLR P0.6
	   CLR P0.7
	   MOV P1, R5
	   ACALL D1ms
PAUSE: JB F0, PAUSE   
       DJNZ R1,INDEL
	   RET
;-------END-----------
;-------DELAY 1MS-------
D1ms: MOV TMOD,#01H
      MOV TH0,#0FEH
	  MOV TL0,#01H
	  SETB TR0
	  JNB TF0,$
	  CLR TF0
	  CLR TR0
	  RET
;-------delay 10ms-------
D10ms:MOV TMOD,#01H
      MOV TH0,#0ECH
	  MOV TL0,#0FH
	  SETB TR0
	  JNB TF0,$
	  CLR TF0
	  CLR TR0
	  RET
;--------end------------	
;-------delay 0.5s---------
D0_5S:MOV R7, #5
L_0_5:MOV TMOD,#01H
      MOV TH0,#38H
	  MOV TL0,#9EH
	  SETB TR0
	  JNB TF0,$
	  CLR TF0
	  DJNZ R7, L_0_5
	  CLR TR0
	  RET
;------end------
;-------delay 2s---------
D2s:  MOV R7, #20
L_2:  MOV TMOD,#01H
;      MOV TH0, #36H
;	  MOV TL0, #0D3H
      MOV TH0, #38H
	  MOV TL0, #91H
	  SETB TR0
	  JNB TF0,$
	  CLR TF0
	  DJNZ R7, L_2
	  CLR TR0
	  RET
;--------end-------
;--------------------------------------------------------------�ӳ������-------------------------------------------------
;--------------���----------------
TABLE1:DB 0C0H,60H,30H,18H,0CH,84H
TABLE2:DB 84H,0CH,18H,30H,60H,0C0H
TABLE3:DB 0FCH,60H,0DAH,0F2H,66H,0B6H,0BEH,0E0H,0FEH,0F6H,  0ECH,02H
;                                                             A , B  
;------------������---------------
; Peripheral specific initialization functions,
; Called from the Init_Device label
PCA_Init:
    anl  PCA0MD,    #0BFh
    mov  PCA0MD,    #000h
    ret

Timer_Init:
    mov  TMOD,      #001h
    mov  CKCON,     #002h
    ret

Port_IO_Init:
    ; P0.0  -  Unassigned,  Open-Drain, Digital
    ; P0.1  -  Unassigned,  Open-Drain, Digital
    ; P0.2  -  Unassigned,  Open-Drain, Digital
    ; P0.3  -  Unassigned,  Open-Drain, Digital
    ; P0.4  -  Unassigned,  Open-Drain, Digital
    ; P0.5  -  Unassigned,  Open-Drain, Digital
    ; P0.6  -  Unassigned,  Open-Drain, Digital
    ; P0.7  -  Unassigned,  Open-Drain, Digital

    ; P1.0  -  Unassigned,  Open-Drain, Digital
    ; P1.1  -  Unassigned,  Open-Drain, Digital
    ; P1.2  -  Unassigned,  Open-Drain, Digital
    ; P1.3  -  Unassigned,  Open-Drain, Digital
    ; P1.4  -  Unassigned,  Open-Drain, Digital
    ; P1.5  -  Unassigned,  Open-Drain, Digital
    ; P1.6  -  Unassigned,  Open-Drain, Digital
    ; P1.7  -  Unassigned,  Open-Drain, Digital
    ; P2.0  -  Unassigned,  Open-Drain, Digital
    ; P2.1  -  Unassigned,  Open-Drain, Digital
    ; P2.2  -  Unassigned,  Open-Drain, Digital
    ; P2.3  -  Unassigned,  Open-Drain, Digital

    mov  XBR1,      #040h
    ret

Oscillator_Init:
    mov  OSCICN,    #083h
    ret
	
Interrupts_Init:
    mov  IE,        #081h
    ret
; Initialization function for device,
; Call Init_Device from your main program
Init_Device:
    lcall PCA_Init
    lcall Timer_Init
    lcall Port_IO_Init
    lcall Oscillator_Init
	lcall Interrupts_Init
    ret

end