# Author: Ahmed Ellamie
# Email:  ahmed.ellamiee@gmail.com
#
# AVR_NTI layered firmware Makefile.
# Discovers every .c / .h under the project (except build/) and links them.
# Pipeline: .c -> .i (preprocess) -> .s (assemble listing) -> .o -> .elf -> .hex/.bin

MCU      ?= atmega32
F_CPU    ?= 8000000UL
TARGET   ?= program

BUILD_DIR := build

CC      := avr-gcc
OBJCOPY := avr-objcopy
OBJDUMP := avr-objdump
SIZE    := avr-size
HOST_CC ?= gcc

CFLAGS  := -mmcu=$(MCU) -DF_CPU=$(F_CPU) -Os -Wall -std=gnu99 -ffunction-sections -fdata-sections
LDFLAGS := -mmcu=$(MCU) -Wl,--gc-sections -Wl,-Map=$(BUILD_DIR)/$(TARGET).map

# Search the whole project: root + 4 directory levels (LIB/MCAL/HAL/Logic and nested drivers).
SRCS := $(wildcard *.c)
SRCS += $(wildcard */*.c)
SRCS += $(wildcard */*/*.c)
SRCS += $(wildcard */*/*/*.c)
SRCS += $(wildcard */*/*/*/*.c)
SRCS := $(filter-out $(BUILD_DIR)/%,$(SRCS))
SRCS := $(filter-out tests/%,$(SRCS))

HDRS := $(wildcard *.h)
HDRS += $(wildcard */*.h)
HDRS += $(wildcard */*/*.h)
HDRS += $(wildcard */*/*/*.h)
HDRS += $(wildcard */*/*/*/*.h)
HDRS := $(filter-out $(BUILD_DIR)/%,$(HDRS))

ifeq ($(strip $(SRCS)),)
$(error No .c files found. Put sources in ., LIB, MCAL, HAL, or Logic.)
endif

OBJS    := $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRCS))
PREPROCS := $(patsubst %.c,$(BUILD_DIR)/%.i,$(SRCS))
ASMS    := $(patsubst %.c,$(BUILD_DIR)/%.s,$(SRCS))

INC_DIRS := $(sort . LIB MCAL HAL Logic $(dir $(SRCS)) $(dir $(HDRS)))
INCLUDES := $(addprefix -I,$(INC_DIRS))

TEST_CFLAGS := -std=c99 -Wall -Wextra -ILIB -IMCAL/ADC -IHAL/Door -IHAL/Hoist -IAPP/CarFSM -IAPP/DoorFSM -IAPP/dispatch
TEST_DIR := $(BUILD_DIR)/tests
TEST_BINS := $(TEST_DIR)/fsm_logic_test_native $(TEST_DIR)/dispatch_test_native $(TEST_DIR)/load_test_native

# WinAVR make 3.81 runs recipes in sh, so use POSIX mkdir/rm.
.PHONY: all clean size verify test

all: $(PREPROCS) $(ASMS) $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin size

$(BUILD_DIR)/%.i: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDES) -E $< -o $@

$(BUILD_DIR)/%.s: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDES) -S $< -o $@

$(BUILD_DIR)/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJS)
	mkdir -p $(BUILD_DIR)
	$(CC) $(LDFLAGS) $(OBJS) -o $@

$(BUILD_DIR)/$(TARGET).hex: $(BUILD_DIR)/$(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@
	@echo HEX ready: $@

$(BUILD_DIR)/$(TARGET).bin: $(BUILD_DIR)/$(TARGET).elf
	$(OBJCOPY) -O binary -R .eeprom $< $@
	@echo BIN ready: $@

size: $(BUILD_DIR)/$(TARGET).elf
	$(SIZE) $<

verify: all
	@echo BUILD_OK MCU=$(MCU) F_CPU=$(F_CPU) SRCS=$(SRCS)

test: $(TEST_BINS)
	$(TEST_DIR)/fsm_logic_test_native
	$(TEST_DIR)/dispatch_test_native
	$(TEST_DIR)/load_test_native

$(TEST_DIR)/fsm_logic_test_native: tests/fsm_logic_test.c
	mkdir -p $(TEST_DIR)
	$(HOST_CC) $(TEST_CFLAGS) $< -o $@

$(TEST_DIR)/dispatch_test_native: tests/dispatch_test.c APP/dispatch/dispatch.c
	mkdir -p $(TEST_DIR)
	$(HOST_CC) $(TEST_CFLAGS) $^ -o $@

$(TEST_DIR)/load_test_native: tests/load_test.c
	mkdir -p $(TEST_DIR)
	$(HOST_CC) $(TEST_CFLAGS) $< -o $@

clean:
	rm -rf $(BUILD_DIR)
	@echo Cleaned $(BUILD_DIR)
