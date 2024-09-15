@ Literally just 2 and 2 
.global _start
_start:
    MOV R0, #2
    MOV R1, #2
    ADD R2, R1, R0

stop: b stop
