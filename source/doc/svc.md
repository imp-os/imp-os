# <div align="center">IMP OS</div>

## <div align="center">Programmer's Reference Manual</div>

<div style="page-break-after: always; break-after:page;"></div>

## Introduction

### Allocation of SVCs

IMP OS offers a suite of services/functionality that are made available through the SVC (formerly "SWI") call. SVC calls are broken down by area (graphics, input, etc.) and are always allocated in blocks of 64.

Currently, the functionality is broken down as follows:

| Area         | SVC Range       | Example                                 |
| ----         | ---------       | -------                                 |
| Graphics     | 0x0000 - 0x003f | ``OS_SetMode``, ``OS_ClearScreen``      |
| Input        | 0x0040 - 0x007f | ``OS_ReadC``, ``OS_ScanKey``            |
| Process      | 0x0080 - 0x00bf | ``OS_ProcessBegin``, ``OS_ProcessExit`` |

### Calling Method (APCS)

When calling an SVC, up to 4 parameters may be supplied for the SVC to use. These must be passed in the first four registers (so in 32-bit the registers r0-r3 can be used). On exit from the SVC handler, r0 will always be corrupted and is used to provide a "response" from the individual SVC service handler to the caller. A return value of 0 indicates success, any non-zero value may be used to indicate some form of failure in the individual SVC handler.

For illustration, calling OS_PrintString directly from 32-bit ARM would look like this:

```
...
             ADR    r0, text_string
             SVC    OS_PrintString
...
text_string: EQUS   "Hello, World\n"
             EQUB   0
...
```

The rest of this document will describe the individual SVC calls

<div style="page-break-after: always; break-after:page;"></div>


## <div align="right">OS_PrintString (SVC &00)</div>

Prints a string of text

### On entry

R0 = pointer to string of text to print

### On exit

R0 = exit code (0 = success, 1 = failure)

### Use

This call prints a string of text to the display. The string of text must be terminated by a NULL character ("\0").

### Example

```
ADR R0, string
SVC OS_PrintString
...
.string
EQUS "Hello, world"
EQUB 0
```

### Related SVCs

No related SVCs

<div style="page-break-after: always; break-after:page;"></div>


## <div align="right">OS_PrintChar (SVC &01)</div>

Prints a single character

### On entry

R0 = ASCII value of character to print

### On exit

R0 = exit code (0 = success, 1 = failure)

### Use

This call prints a single character of text to the display.

### Example

```
MOV R0, #ASC "A"
SVC OS_PrintChar
```

### Related SVCs

No related SVCs

<div style="page-break-after: always; break-after:page;"></div>


## <div align="right">OS_ClearScreen<br />(SVC &02)</div>  

Clears the display.

### On entry

-

### On exit

R0 = exit code (0 = success, 1 = failure)

### Use

This call clears the video display to a black background.

### Example

```
SVC OS_ClearScreen
```

### Related SVCs

-

<div style="page-break-after: always; break-after:page;"></div>


## <div align="right">OS_SetColour<br />(SVC &03)</div>  

Sets the foreground or background colour.

### On entry

r0 = 0 for foreground, 1 for background
r1 = R component (0x00 - 0xff)
r2 = G component (0x00 - 0xff)
r3 = B component (0x00 - 0xff)

### On exit

R0 = exit code (0 = success, 1 = failure)

### Use

This call sets the foreground/background colour to the 24-bit RGB value specified.

### Example

The following example sets the foreground colour to magenta (RGB = 0xff00ff)

```
MOV r0, #1
MOV r1, #0xff
MOV r2, #0x00
MOV r3, #0xff
SVC OS_SetColour
```

### Related SVCs

-

<div style="page-break-after: always; break-after:page;"></div>


## <div align="right">OS_ReadC<br />(SVC &04)</div>  

Reads a character from the keyboard.

### On entry

-

### On exit

R0 = ASCII value of character read from the keyboard.

### Use

This call allows the client to block and await the press of a key on the keyboard.

### Example

The following example waits for a key to be pressed and returns the ASCII value, and uses OS_PrintChar to echo the character read to the display.

```
SVC OS_ReadC
SVC OS_PrintChar
```

### Related SVCs

-

<div style="page-break-after: always; break-after:page;"></div>


## <div align="right">OS_ProcessBegin<br />(SVC &02)</div>  

Loads and executes a given process


### On entry

R0 = pointer to string describing process name to execute (NULL terminated)


### On exit

R0 = exit code (0 = success, 1 = failure)


### Use

This call loads the requested process into memory and executes it. Once the process has called OS_ProcessExit, control is returned to the parent and execution continues.


### Example

```
ADR R0, begin_text
SVC OS_PrintString
ADR R0, cli_executable
SVC OS_ProcessBegin
ADR R0, exit_text
SVC OS_PrintString
...
.begin_text
EQUS "Process will begin..."
EQUB 0
.exit_text
EQUS "Process has exited"
EQUB 0
.cli_executable
EQUS "CLI.BIN"
EQUB 0
```


### Related SVCs

  * OS_ProcessExit


<div style="page-break-after: always; break-after:page;"></div>


## <div align="right">OS_ProcessExit<br />(SVC &03)</div>  

Ends the current process, returning control to the parent process.

### On entry

-

### On exit

-

### Use

This call exits the current process, returning control to the parent (calling) process.

### Example

```
ADR R0, exit_text
SVC OS_PrintString
SVC OS_ProcessExit
...
.exit_text
EQUS "Process will now exit..."
EQUB 0
```

### Related SVCs

  * OS_ProcessBegin

<div style="page-break-after: always; break-after:page;"></div>
