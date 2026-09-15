#ifndef SPI_PRIVATE_H
#define SPI_PRIVATE_H

/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — SPI private layer (ATmega32)
 * Include this file ONLY from SPI.c.
 *
 * What you must add here:
 * 1. Registers:
 *      SPCR  0x4D    SPIE SPE DORD MSTR CPOL CPHA SPR1 SPR0
 *      SPSR  0x4E    SPIF WCOL – – – – – SPI2X
 *      SPDR  0x4F    data — writing it starts the 8 clocks in master mode
 *
 * 2. Bit names:
 *      SPE=6, MSTR=5, SPR1=1, SPR0=0 in SPCR
 *      SPIF=7 in SPSR  (cleared by reading SPSR then accessing SPDR)
 *
 * 3. Pin roles on Port B (you may call GPIO from SPI.c, or set DDRB here):
 *      PB4 SS    master: output HIGH when idle
 *      PB5 MOSI  master: output
 *      PB6 MISO  master: input
 *      PB7 SCK   master: output
 *
 * 4. Keep SS as an output in master mode. If it is an input and goes LOW,
 *    the hardware forces slave mode.
 *
 * 5. Mode 0: CPOL=0, CPHA=0. Leave SPI2X = 0 unless you add a 2x API.
 */

/* TODO: map SPCR, SPSR, SPDR and the bit names. */

#define SPCR (*(volatile uint8 *)0x2D)
#define SPSR (*(volatile uint8 *)0x2E)
#define SPDR (*(volatile uint8 *)0x2F)

// SPCR bit names
#define SPE 6
#define MSTR 4
#define SPR1 1
#define SPR0 0

// SPSR bit names
#define SPIF 7
#define SPI2X 0

#endif /* SPI_PRIVATE_H */
