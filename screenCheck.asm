	org 33000  
;begin code at 33000. Code over 32768 runs fast, and 33000 is easy to remember
    di;
    ld hl,&5B00; stick a value in to mark the point where we want to stop iterating through the memory.
    ld (hl), 2;; we will check for this value in each frame and leave the program if we find it

    ld hl,&4000; point to the start of the screen memory
LOOP ;label for the main program loop
	
	ld (hl),1;6  write a value to memory, updating the screen pixels at this current memory 
    ;location. try changing this to see what happens
	inc hl; increase the memory location we are writing to.

    ;check if we have reached the stop point
    ld a,(hl); inspect the latest memory location
    sbc a,2; compare to the value we set earlier as marker
    JR Z,FINISH; jump to the end if hl has reached the point we want to bail out;
    ;if we omit the above 3 lines
    ;this program won't stop writing at the end of the screen memory, and will continue 
    ;sequentially, potentially causing all sorts of interesting effects and most likely at some
    ;point, a crash. 

    ;wait routine
    ld bc,$400; //set the time to wait between frames, adjust this to change speed
WAIT
    dec bc
    ld a,b
    or c
    jr nz, WAIT
    jp LOOP

FINISH

    ei
    ret