# Smart Elevator Controller Work Schedule

## Already Implemented

- GPIO
- ADC
- Timer0 & Timer1
- External Interrupts
- UART (UART interrupts not implemented yet)

## Work Distribution

### Ahmad Ibrahim Anwar

MCAL: spi <br>
HAL:  HC165.c, HC595.c, shiftReg.c, position.c <br>
APP:  LOOK<br>

### Ahmed Ayman Ramadan

MCAL: i2c.c <br>
HAL:  lcd.c, buzzer.c <br>
APP:  consol, fault_log <br>

### Youssef Saeed

MCAL: Timer2.c <br>
HAL:  load.c, door.c <br>
APP:  car_fsm, door <br>

### Youssef Nasser Farouk

HAL: hoist.c<br>
APP: safety, motion<br>
Extra: Hardwware design and general testing<br>


## Tasks brief

### HAL

| module| Does | Talks to |
|---|---|---|
| HC165 |Reads all 16 buttons in one scan, debounces them, and turns raw levels into press/release edges (BTN_Scan, BTN_Pressed(n)) |Two chained 74HC165s over SPI |
| HC595 | Renders the current floor digit and direction arrow (SEG_Show(floor, dir)) | 74HC595 over SPI|
| shiftreg | The shared low-level SPI transaction driver underneath both of the above — this is where SPI_Acquire/SPI_Release live, since the 165 (read) and 595 (write) share one bus and can't be clocked at the same instant	| Raw SPI peripheral |
| position | Converts the position pot's ADC reading into centimeters and tells the rest of the system which floor is nearest and whether the car is inside the ±3 cm level zone (POS_Cm, POS_NearestFloor, POS_InLevelZone) | ADC0 |
| loadcell |Reads the load pot and reports weight in kg, feeding the 900 kg overload check| A separate ADC channel |
| hoist |The only module allowed to write OC1A (hoist PWM) or the hoist direction pins — enforces "car can't move with the door open" at this layer, not just in the FSM (NFR-03) (HST_SetDuty, HST_SetDir, HST_Brake) | Timer1 PWM + direction GPIO | 
| door |The only module allowed to write OC1B (door PWM) or door direction — mirrors hoist's single-writer rule (DRV_SetDuty, DRV_SetDir) | Timer1 PWM + direction GPIO |
| buzzer | Drives the buzzer tone generator for arrival chimes (one tone up, two tones down) and alarm tones (overload, fire, E-stop) | Timer2 PWM on OC2 |
| lcd | Repaints the 16×2 service display every 250 ms — floor, direction, door state, and status text like OVERLOAD 940kg or FIRE SERVICE | PCF8574 I/O expander over I2C |


### APP

| Module | Does |
|---|---|
| car_fsm | The top-level state machine — sequences everything else through states like CS_IDLE, CS_MOVING, CS_ARRIVED, CS_OVERLOAD, CS_FIRE_RECALL, CS_FAULT, CS_ESTOP (§15). It asks the other APP modules for decisions rather than owning any hardware itself |
| dispatch | Owns the three call bitmaps (carCall, hallUp, hallDown) and runs the LOOK algorithm — decides which direction to head next and whether to stop at the current floor. The one subtle piece of logic here is the opposite-direction exception: a car going up will still serve a hall-down call if it's the last call ahead of it |
| motion | Runs the trapezoidal speed profile (accelerate → constant → slowdown → creep → level) and steers toward ±3 cm levelling accuracy from both directions — the asymmetric part is that gravity assists a downward stop but not an upward one, so the profile can't be symmetric |
| door_fsm | Sequences open/dwell/close, and reverses immediately on an obstruction — three consecutive reversals put the door into a DS_JAMMED state (held open, gong) instead of retrying forever |
| safety | Evaluates E-stop, overload, overtravel, and over-current every tick and returns the highest-priority active fault — fire service and E-stop outrank overload, which is why overload is only rank 6 in the state table |
| console |Parses UART commands (CALL <f> UP/DOWN, PAGE <0-1>, queries like CC/HU/HD) and transmits the telemetry frame every 2 s |
| faultlog | A fixed 16-entry ring buffer in RAM that records fault codes as car_fsm enters CS_FAULT and similar states |


## Timeline

### Monday

- SPI or I2C + consol
- load.c
- hoist.c
- door.c
- position.c
- lcd or buzzer
- HC595 & HC165 or position


### Tuesday

- LOOK
- SPI or I2C
- car_fsm
- Timer2
- safety
- motion
- fault log
- lcd or buzzer
- HC595 & HC165 or position

### Wednesday

- shiftReg
- door_fsm
- Hardware design
- main.c


## work done:

### Ahmad Ibrahim:
- Timer2
- SPI
- 74HC165
- 74HC595
- position
- dispatch

### Youssef Saeed:
- load.c: overload reading and hysteresis logic fixed
- load.c: ADC read failures now fail safe as overloaded
- door.c: PWM + direction control implemented and stabilized
- car_fsm: overload / obstruction priority handling fixed
- car_fsm: hoist braking enforced while the door is open
- door_fsm: obstruction recovery and jam-safe logic improved
- verified with FSM, dispatch, and load regression tests
- build environment and duplicate-type blockers resolved

### Youssef Saeed remaining validation:
- verify Timer2 ownership and buzzer behavior in the simulator or on hardware
- verify door OC1B PWM direction and load ADC channel/calibration on hardware
- complete end-to-end validation with hoist, motion, safety, dispatch, and console

### Youssef Nasser:
- hoist.c (not tested)
- motion (not tested)
- safety (not tested)
- simulation (not tested)
