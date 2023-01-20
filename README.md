# Purpose
- To understand Microarchitecture optimization when the document refer to instruction format.
  - Using empty REX ( 0x40 ) for code alignment.
- To understand how instruction variable length work.
  - How ton of instructions fit inside instruction encoding.
- To understand how to calculate instruction length.
  - push ebx // 1 byte
  - push r8 // 2 bytes
- To understand why some instructions form does not exist based on instruction encoding.
  - add eax, DWORD PTR [rbp] // Does not exist
  - add eax, DWORD PTR [rbp + 0x0] // Exist
- To understand which instructions are important and how it intend to be used;
  - 1 byte instruction // important
  - add // Important : use 4 1-byte opcode ( 00 - 05 )
  - sldt r/m16 // Not important : use 2-byte opcode ( 0F 00 )
  - shl eax, 1 // Special instruction ( D1 E0 )
  - shl eax, 1 // Normal instruction ( C1 E0 01 ) // Not intend to be used
  - shl eax, 2 // Normal instruction ( C1 E0 02 )
  - shl eax, 3 // Normal instruction ( C1 E0 03 )
  - test eax, eax  // Shorter than : cmp eax, 0

# CPU Features
- x86-64
- MMX
- SSE
- SSE2
- SSE3
- SSSE3
- SSE4.1
- SSE4.2
- AVX
- AVX2

# Link
[Disassembler](https://defuse.ca/online-x86-assembler.htm)<br>
[Intel Manual](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)<br>

# Instruction Format
## Order
[Prefix]\*&ensp;[REX]&emsp;[Prefix-like]&ensp;`Opcode`&ensp;[ModR/M [SIB [DISP]]]&ensp;[imm]\*<br>
[Prefix]\*&ensp;[VEX]&emsp;[Prefix-like]&ensp;`Opcode`&ensp;[ModR/M [SIB [DISP]]]&ensp;[imm]\*<br>
[Prefix]\*&ensp;[EVEX]&ensp;[Prefix-like]&ensp;`Opcode`&ensp;[ModR/M [SIB [DISP]]]&ensp;[imm]\*<br>

## Operand size
`ib` : imm8<br>
`iw` : imm16<br>
`id` : imm32<br>
`iq` : imm64<br>

## Operand /digit
`/0` : 00 - 07<br>
`/1` : 08 - 0F<br>
`/2` : 10 - 17<br>
`/3` : 18 - 1F<br>
`/4` : 20 - 27<br>
`/5` : 28 - 2F<br>
`/6` : 30 - 37<br>
`/7` : 28 - 3F<br>

## Operand ModR/M ( /r )
| Register    | r/m8 | r/m16 | r/m32 | r/m64 | mm/m? | xmm/m? | ymm/m? | zmm/m? |
|-------------|------|-------|-------|-------|-------|--------|--------|--------|
| `reg0`      | al   | ax    | eax   | rax   | mm0   | xmm0   | ymm0   | zmm0   |
| `reg1`      | cl   | cx    | ecx   | rcx   | mm1   | xmm1   | ymm1   | zmm1   |
| `reg2`      | dl   | dx    | edx   | rdx   | mm2   | xmm2   | ymm2   | zmm2   |
| `reg3`      | bl   | bx    | ebx   | rbx   | mm3   | xmm3   | ymm3   | zmm3   |
| `reg4`      | ah   | sp    | esp   | rsp   | mm4   | xmm4   | ymm4   | zmm4   |
| `reg5`      | bh   | bp    | ebp   | rbp   | mm5   | xmm5   | ymm5   | zmm5   |
| `reg6`      | ch   | si    | esi   | rsi   | mm6   | xmm6   | ymm6   | zmm6   |
| `reg7`      | dh   | di    | edi   | rdi   | mm7   | xmm7   | ymm7   | zmm7   |

| Memory \ Register         | `reg0` | `reg1` | `reg2` | `reg3` | `reg4` | `reg5` | `reg6` | `reg7` |
|---------------------------|--------|--------|--------|--------|--------|--------|--------|--------|
| [rax]                     | 00     | 08     | 10     | 18     | 20     | 28     | 30     | 38     |
| [rcx]                     | 01     | 09     | 11     | 19     | 21     | 29     | 31     | 39     |
| [rdx]                     | 02     | 0A     | 12     | 1A     | 22     | 2A     | 32     | 3A     |
| [rbx]                     | 03     | 0B     | 13     | 1B     | 23     | 2B     | 33     | 3B     |
| sib                       | 04     | 0C     | 14     | 1C     | 24     | 2C     | 34     | 3C     |
| rip + disp32              | 05     | 0D     | 15     | 1D     | 25     | 2D     | 35     | 3D     |
| [rsi]                     | 06     | 0E     | 16     | 1E     | 26     | 2E     | 36     | 3E     |
| [rdi]                     | 07     | 0F     | 17     | 1F     | 27     | 2F     | 37     | 3F     |

| Memory \ Register         | `reg0` | `reg1` | `reg2` | `reg3` | `reg4` | `reg5` | `reg6` | `reg7` |
|---------------------------|--------|--------|--------|--------|--------|--------|--------|--------|
| [rax]&ensp;+ disp8        | 40     | 48     | 50     | 58     | 60     | 68     | 70     | 78     |
| [rcx]&ensp;+ disp8        | 41     | 49     | 51     | 59     | 61     | 69     | 71     | 79     |
| [rdx]&ensp;+ disp8        | 42     | 4A     | 52     | 5A     | 62     | 6A     | 72     | 7A     |
| [rbx]&ensp;+ disp8        | 43     | 4B     | 53     | 5B     | 63     | 6B     | 73     | 7B     |
| sib&emsp;&nbsp;+ disp8    | 44     | 4C     | 54     | 5C     | 64     | 6C     | 74     | 7C     |
| [rbp] + disp8             | 45     | 4D     | 55     | 5D     | 65     | 6D     | 75     | 7D     |
| [rsi]&ensp;&nbsp;+ disp8  | 46     | 4E     | 56     | 5E     | 66     | 6E     | 76     | 7E     |
| [rdi]&ensp;+ disp8        | 47     | 4F     | 57     | 5F     | 67     | 6F     | 77     | 7F     |

| Memory \ Register         | `reg0` | `reg1` | `reg2` | `reg3` | `reg4` | `reg5` | `reg6` | `reg7` |
|---------------------------|--------|--------|--------|--------|--------|--------|--------|--------|
| [rax]&ensp;+ disp32       | 80     | 88     | 90     | 98     | A0     | A8     | B0     | B8     |
| [rcx]&ensp;+ disp32       | 81     | 89     | 91     | 99     | A1     | A9     | B1     | B9     |
| [rdx]&ensp;+ disp32       | 82     | 8A     | 92     | 9A     | A2     | AA     | B2     | BA     |
| [rbx]&ensp;+ disp32       | 83     | 8B     | 93     | 9B     | A3     | AB     | B3     | BB     |
| sib&emsp;&nbsp;+ disp32   | 84     | 8C     | 94     | 9C     | A4     | AC     | B4     | BC     |
| [rbp] + disp32            | 85     | 8D     | 95     | 9D     | A5     | AD     | B5     | BD     |
| [rsi]&ensp;&nbsp;+ disp32 | 86     | 8E     | 96     | 9E     | A6     | AE     | B6     | BE     |
| [rdi]&ensp;+ disp32       | 87     | 8F     | 97     | 9F     | A7     | AF     | B7     | BF     |

| Register \ Register&nbsp; | `reg0` | `reg1` | `reg2` | `reg3` | `reg4` | `reg5` | `reg6` | `reg7` |
|---------------------------|--------|--------|--------|--------|--------|--------|--------|--------|
| `reg0`                    | C0     | C8     | D0     | D8     | E0     | E8     | F0     | F8     |
| `reg1`                    | C1     | C9     | D1     | D9     | E1     | E9     | F1     | F9     |
| `reg2`                    | C2     | CA     | D2     | DA     | E2     | EA     | F2     | FA     |
| `reg3`                    | C3     | CB     | D3     | DB     | E3     | EB     | F3     | FB     |
| `reg4`                    | C4     | CC     | D4     | DC     | E4     | EC     | F4     | FC     |
| `reg5`                    | C5     | CD     | D5     | DD     | E5     | ED     | F5     | FD     |
| `reg6`                    | C6     | CE     | D6     | DE     | E6     | EE     | F6     | FE     |
| `reg7`                    | C7     | CF     | D7     | DF     | E7     | EF     | F7     | FF     |

## SIB ( Scale * Index + Base )
| ModR/M  | `*`                             |
|---------|---------------------------------|
| 00 - 3F | [scaled index] + disp32         |
| 40 - 7F | [scaled index] + disp8 + [ebp]  |
| 80 - BF | [scaled index] + disp32 + [ebp] |

| Scaled Index \ Base  | rax | rcx | rdx | rbx | rsp | `*` | rsi | rdi |
|----------------------|-----|-----|-----|-----|-----|-----|-----|-----|
| [rax * 1]            | 00  | 01  | 02  | 03  | 04  | 05  | 06  | 07  |
| [rcx * 1]            | 08  | 09  | 0A  | 0B  | 0C  | 0D  | 0E  | 0F  |
| [rdx * 1]            | 10  | 11  | 12  | 13  | 14  | 15  | 16  | 17  |
| [rbx * 1]            | 18  | 19  | 1A  | 1B  | 1C  | 1D  | 1E  | 1F  |
| none                 | 20  | 21  | 22  | 23  | 24  | 25  | 26  | 27  |
| [rbp * 1]            | 28  | 29  | 2A  | 2B  | 2C  | 2D  | 2E  | 2F  |
| [rsi&ensp;&nbsp;* 1] | 30  | 31  | 32  | 33  | 34  | 35  | 36  | 37  |
| [rdi&ensp;* 1]       | 38  | 39  | 3A  | 3B  | 3C  | 3D  | 3E  | 3F  |

| Scaled Index \ Base  | rax | rcx | rdx | rbx | rsp | `*` | rsi | rdi |
|----------------------|-----|-----|-----|-----|-----|-----|-----|-----|
| [rax * 2]            | 40  | 41  | 42  | 43  | 44  | 45  | 46  | 47  |
| [rcx * 2]            | 48  | 49  | 4A  | 4B  | 4C  | 4D  | 4E  | 4F  |
| [rdx * 2]            | 50  | 51  | 52  | 53  | 54  | 55  | 56  | 57  |
| [rbx * 2]            | 58  | 59  | 5A  | 5B  | 5C  | 5D  | 5E  | 5F  |
| none                 | 60  | 61  | 62  | 63  | 64  | 65  | 66  | 67  |
| [rbp * 2]            | 68  | 69  | 6A  | 6B  | 6C  | 6D  | 6E  | 6F  |
| [rsi&ensp;&nbsp;* 2] | 70  | 71  | 72  | 73  | 74  | 75  | 76  | 77  |
| [rdi&ensp;* 2]       | 78  | 79  | 7A  | 7B  | 7C  | 7D  | 7E  | 7F  |

| Scaled Index \ Base  | rax | rcx | rdx | rbx | rsp | `*` | rsi | rdi |
|----------------------|-----|-----|-----|-----|-----|-----|-----|-----|
| [rax * 4]            | 80  | 81  | 82  | 83  | 84  | 85  | 86  | 87  |
| [rcx * 4]            | 88  | 89  | 8A  | 8B  | 8C  | 8D  | 8E  | 8F  |
| [rdx * 4]            | 90  | 91  | 92  | 93  | 94  | 95  | 96  | 97  |
| [rbx * 4]            | 98  | 99  | 9A  | 9B  | 9C  | 9D  | 9E  | 9F  |
| none                 | A0  | A1  | A2  | A3  | A4  | A5  | A6  | A7  |
| [rbp * 4]            | A8  | A9  | AA  | AB  | AC  | AD  | AE  | AF  |
| [rsi&ensp;&nbsp;* 4] | B0  | B1  | B2  | B3  | B4  | B5  | B6  | B7  |
| [rdi&ensp;* 4]       | B8  | B9  | BA  | BB  | BC  | BD  | BE  | BF  |

| Scaled Index \ Base  | rax | rcx | rdx | rbx | rsp | `*` | rsi | rdi |
|----------------------|-----|-----|-----|-----|-----|-----|-----|-----|
| [rax * 8]            | C0  | C1  | C2  | C3  | C4  | C5  | C6  | C7  |
| [rcx * 8]            | C8  | C9  | CA  | CB  | CC  | CD  | CE  | CF  |
| [rdx * 8]            | D0  | D1  | D2  | D3  | D4  | D5  | D6  | D7  |
| [rbx * 8]            | D8  | D9  | DA  | DB  | DC  | DD  | DE  | DF  |
| none                 | E0  | E1  | E2  | E3  | E4  | E5  | E6  | E7  |
| [rbp * 8]            | E8  | E9  | EA  | EB  | EC  | ED  | EE  | EF  |
| [rsi&ensp;&nbsp;* 8] | F0  | F1  | F2  | F3  | F4  | F5  | F6  | F7  |
| [rdi&ensp;* 8]       | F8  | F9  | FA  | FB  | FC  | FD  | FE  | FF  |

## VEX
0x`C4`&ensp;0b`RXBm`-`mmmm`&ensp;0b`Wvvv`-`vLpp`<br>
0x`C5`&ensp;0b`Rvvv`-`vLpp`<br>

| Prefix-like \ Example | 2-byte VEX | 3-byte VEX |
|-----------------------|------------|------------|
| &emsp;&ensp;0F        | C5 F8      | C4 E1 78   |
| 66 0F                 | C5 F9      | C4 E1 79   |
| 66 0F 38              |            | C4 E2 79   |
| 66 0F 3A              |            | C4 E3 79   |
| F2 0F                 | C5 FA      | C4 E1 7A   |
| F2 0F 38              |            | C4 E2 7A   |
| F2 0F 3A              |            | C4 E3 7A   |
| F3 0F                 | C5 FB      | C4 E1 7B   |
| F3 0F 38              |            | C4 E2 7B   |
| F3 0F 3A              |            | C4 E3 7B   |

R : REX.R in 1’s complement
- 0b`0` : REX.R = 1
- 0b`1` : REX.R = 0

X : REX.X in 1’s complement
- 0b`0` : REX.X = 1
- 0b`1` : REX.X = 0

B : REX.B in 1’s complement
- 0b`0` : REX.B = 1
- 0b`1` : REX.B = 0

W : REX.W

m-mmmm
- 0b`0`-`0000` : Reserved for future use
- 0b`0`-`0001` : implied `0F` leading opcode byte
- 0b`0`-`0010` : implied `0F 38` leading opcode byte
- 0b`0`-`0011` : implied `0F 3A` leading opcode byte
- 0b`0`-`0100` - 0b`11111` : Reserved for future use
> 2-byte VEX ( 0xC5 ) : implied `0F` leading opcode byte

| vvv-v   | Dest Register   | General-Purpose Register |
|---------|-----------------|--------------------------|
| 0b111-1 | xmm0 / ymm0     | rax / eax                |
| 0b111-0 | xmm1 / ymm1     | rcx / ecx                |
| 0b110-1 | xmm2 / ymm2     | rdx / edx                |
| 0b110-0 | xmm3 / ymm3     | rbx / ebx                |
| 0b101-1 | xmm4 / ymm4     | rsp / esp                |
| 0b101-0 | xmm5 / ymm5     | rbp / ebp                |
| 0b100-1 | xmm6 / ymm6     | rsi / esi                |
| 0b100-0 | xmm7 / ymm7     | rdi / edi                |
| 0b011-1 | xmm8 / ymm8     | r8 / r8d                 |
| 0b011-0 | xmm9 / ymm9     | r9 / r9d                 |
| 0b010-1 | xmm10 / ymm10   | r10 / r10d               |
| 0b010-0 | xmm11 / ymm11   | r11 / r11d               |
| 0b001-1 | xmm12 / ymm12   | r12 / r12d               |
| 0b001-0 | xmm13 / ymm13   | r13 / r13d               |
| 0b000-0 | xmm14 / ymm14   | r14 / r14d               |
| 0b000-0 | xmm15 / ymm15   | r15 / r15d               |

L : Vector Length
- 0b`0` : 128-bit vector | scalar
- 0b`1` : 256-bit vector

pp : Prefix
- 0b`00` : None
- 0b`01` : 0x`66`
- 0b`10` : 0x`F3`
- 0b`11` : 0x`F2`

# Machine code
## Prefix
`26` : es:[addr]&emsp;&nbsp;// use with any branch instruction is reserved<br>
`2E` : cs:[addr]&emsp;&nbsp;// use with any branch instruction is reserved<br>
`36` : ss:[addr]&emsp;&nbsp;// use with any branch instruction is reserved<br>
`3E` : ds:[addr]&emsp;// use with any branch instruction is reserved<br>

`64` : fs:[addr]&emsp;&nbsp;// use with any branch instruction is reserved<br>
`65` : gs:[addr]&emsp;// use with any branch instruction is reserved<br>

`66` : data16&emsp;// mandatory prefix<br>
`67` : addr32<br>

`F0` : lock<br>
`F2` : repnz&emsp;// mandatory prefix<br>
`F3` : repz&emsp;&ensp;// mandatory prefix<br>

## REX ( Flag )
`41` : rex.b&emsp;&ensp;// ModR/M r/m | SIB base | Opcode reg<br>
`42` : rex.x&emsp;&ensp;// &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;&nbsp;SIB index<br>
`44` : rex.r&emsp;&ensp;// ModR/M reg<br>
`48` : rex.w&emsp;// 32bit :arrow_right: 64bit<br>

| Flag      |             |               |              |
|-----------|-------------|---------------|--------------|
| b & x & r | eax - edi   | :arrow_right: | r8d - r15d   |
| b & x & r | xmm0 - xmm7 | :arrow_right: | xmm8 - xmm15 |
| w         | eax - edi   | :arrow_right: | rax - rdi    |
| w         | r8d - r15d  | :arrow_right: | r8 - r15     |

## VEX
`C4`&emsp;??&emsp;??&emsp;&emsp;&ensp;&nbsp;: 3-byte prefix<br>
`C5`&emsp;??&emsp;&emsp;&emsp;&emsp;&ensp;&nbsp;: 2-byte prefix<br>

## EVEX
`62`&emsp;??&emsp;??&emsp;??&emsp;: 4-byte prefix<br>

## Prefix-like
&emsp;&emsp;&emsp;&emsp;`0F`<br>
&emsp;&emsp;&emsp;&emsp;`0F 38`<br>
&emsp;&emsp;&emsp;&emsp;`0F 3A`<br>
66 [VEX] `0F`<br>
66 [VEX] `0F 38`<br>
66 [VEX] `0F 3A`<br>
F2 [VEX] `0F`<br>
F2 [VEX] `0F 38`<br>
F2 [VEX] `0F 3A`<br>
F3 [VEX] `0F`<br>
F3 [VEX] `0F 38`<br>
F3 [VEX] `0F 3A`<br>

## Opcode
:green_heart: `00` /r : add r/m8, r8<br>
:green_heart: `01` /r : add r/m32, r32<br>
:green_heart: `02` /r : add r8, r/m8<br>
:green_heart: `03` /r : add r32, r/m32<br>
:green_heart: `04` ib : add al, imm8<br>
:green_heart: `05` id : add eax, imm32<br>

:skull: `06` : push es&emsp;// Invalid<br>
:skull: `07` : pop es&emsp;&nbsp;// Invalid<br>

:green_heart: `08` /r : or r/m8, r8<br>
:green_heart: `09` /r : or r/m32, r32<br>
:green_heart: `0A` /r : or r8, r/m8<br>
:green_heart: `0B` /r : or r32, r/m32<br>
:green_heart: `0C` ib : or al, imm8<br>
:green_heart: `0D` id : or eax, imm32

:skull: `0E` : push cs&emsp;// Invalid<br>

:blue_heart: `10` /r : adc r/m8, r8<br>
:blue_heart: `11` /r : adc r/m32, r32<br>
:blue_heart: `12` /r : adc r8, r/m8<br>
:blue_heart: `13` /r : adc r32, r/m32<br>
:blue_heart: `14` ib : adc al, imm8<br>
:blue_heart: `15` id : adc eax, imm32<br>

:skull: `16` : push ss&emsp;// Invalid<br>
:skull: `17` : pop ss&emsp;&nbsp;// Invalid<br>

:blue_heart: `18` /r : sbb r/m8, r8<br>
:blue_heart: `19` /r : sbb r/m32, r32<br>
:blue_heart: `1A` /r : sbb r8, r/m8<br>
:blue_heart: `1B` /r : sbb r32, r/m32<br>
:blue_heart: `1C` ib : sbb al, imm8<br>
:blue_heart: `1D` id : sbb eax, imm32<br>

:skull: `1E` : push ds&emsp;// Invalid<br>
:skull: `1F` : pop ds&emsp;&nbsp;// Invalid<br>

:green_heart: `20` /r : and r/m8, r8<br>
:green_heart: `21` /r : and r/m32, r32<br>
:green_heart: `22` /r : and r8, r/m8<br>
:green_heart: `23` /r : and r32, r/m32<br>
:green_heart: `24` ib : and al, imm8<br>
:green_heart: `25` id : and eax, imm32<br>

:skull: `27` : daa&emsp;// Invalid<br>

:green_heart: `28` /r : sub r/m8, r8<br>
:green_heart: `29` /r : sub r/m32, r32<br>
:green_heart: `2A` /r : sub r8, r/m8<br>
:green_heart: `2B` /r : sub r32, r/m32<br>
:green_heart: `2C` ib : sub al, imm8<br>
:green_heart: `2D` id : sub eax, imm32<br>

:skull: `2F` : das&emsp;// Invalid<br>

:green_heart: `30` /r : xor r/m8, r8<br>
:green_heart: `31` /r : xor r/m32, r32<br>
:green_heart: `32` /r : xor r8, r/m8<br>
:green_heart: `33` /r : xor r32, r/m32<br>
:green_heart: `34` ib : xor al, imm8<br>
:green_heart: `35` id : xor eax, imm32<br>

:skull: `37` : aaa&emsp;// Invalid<br>

:green_heart: `38` /r : cmp r/m8, r8<br>
:green_heart: `39` /r : cmp r/m32, r32<br>
:green_heart: `3A` /r : cmp r8, r/m8<br>
:green_heart: `3B` /r : cmp r32, r/m32<br>
:green_heart: `3C` ib : cmp al, imm8<br>
:green_heart: `3D` id : cmp eax, imm32<br>

:skull: `3F` : aas&emsp;// Invalid<br>

:green_heart: `50` : push rax<br>
:green_heart: `51` : push rcx<br>
:green_heart: `52` : push rdx<br>
:green_heart: `53` : push rbx<br>
:green_heart: `54` : push rsp<br>
:green_heart: `55` : push rbp<br>
:green_heart: `56` : push rsi<br>
:green_heart: `57` : push rdi<br>

:green_heart: `58` : pop rax<br>
:green_heart: `59` : pop rcx<br>
:green_heart: `5A` : pop rdx<br>
:green_heart: `5B` : pop rbx<br>
:green_heart: `5C` : pop rsp<br>
:green_heart: `5D` : pop rbp<br>
:green_heart: `5E` : pop rsi<br>
:green_heart: `5F` : pop rdi<br>

:skull: `60` : push a&emsp;// Invalid<br>
:skull: `61` : pop a&emsp;&nbsp;// Invalid<br>

:confused: `63` /r : movsxd r32, r/m32<br>

:broken_heart: `68`&emsp;&emsp;&ensp;: push imm32<br>
:confused: `69` /r id : imul r32, r/m32, imm32<br>
:broken_heart: `6A`&emsp;&emsp;&ensp;: push imm8<br>
:confused: `6B` /r ib : imul r32, r/m32, imm8<br>

:broken_heart: `6C` : insb<br>
:broken_heart: `6D` : insd<br>
:broken_heart: `6E` : outsb<br>
:broken_heart: `6F` : outsd<br>

:green_heart: `70` ib : jo rel8<br>
:green_heart: `71` ib : jno rel8<br>
:green_heart: `72` ib : jb rel8<br>
:green_heart: `73` ib : jae rel8<br>
:green_heart: `74` ib : je rel8<br>
:green_heart: `75` ib : jne rel8<br>
:green_heart: `76` ib : jbe rel8<br>
:green_heart: `77` ib : ja rel8<br>
:green_heart: `78` ib : js rel8<br>
:green_heart: `79` ib : jns rel8<br>
:green_heart: `7A` ib : jp rel8<br>
:green_heart: `7B` ib : jnp rel8<br>
:green_heart: `7C` ib : jl rel8<br>
:green_heart: `7D` ib : jge rel8<br>
:green_heart: `7E` ib : jle rel8<br>
:green_heart: `7F` ib : jg rel8<br>

:green_heart: `80` /0 ib : add r/m8, imm8<br>
:green_heart: `80` /1 ib : or r/m8, imm8<br>
:green_heart: `80` /2 ib : adc r/m8, imm8<br>
:green_heart: `80` /3 ib : sbb r/m8, imm8<br>
:green_heart: `80` /4 ib : and r/m8, imm8<br>
:green_heart: `80` /5 ib : sub r/m8, imm8<br>
:green_heart: `80` /6 ib : xor r/m8, imm8<br>
:green_heart: `80` /7 ib : cmp r/m8, imm8<br>

:green_heart: `81` /0 id : add r/m32, imm32<br>
:green_heart: `81` /1 id : or r/m32, imm32<br>
:green_heart: `81` /2 id : adc r/m32, imm32<br>
:green_heart: `81` /3 id : sbb r/m32, imm32<br>
:green_heart: `81` /4 id : and r/m32, imm32<br>
:green_heart: `81` /5 id : sub r/m32, imm32<br>
:green_heart: `81` /6 id : xor r/m32, imm32<br>
:green_heart: `81` /7 id : cmp r/m32, imm32<br>

:thought_balloon: `82` : // Unknown<br>

:green_heart: `83` /0 ib : add r/m32, imm8<br>
:green_heart: `83` /1 ib : or r/m32, imm8<br>
:green_heart: `83` /2 ib : adc r/m32, imm8<br>
:green_heart: `83` /3 ib : sbb r/m32, imm8<br>
:green_heart: `83` /4 ib : and r/m32, imm8<br>
:green_heart: `83` /5 ib : sub r/m32, imm8<br>
:green_heart: `83` /6 ib : xor r/m32, imm8<br>
:green_heart: `83` /7 ib : cmp r/m32, imm8<br>

:confused: `84` /r : test r/m8, r8<br>
:confused: `85` /r : test r/m32, r32<br>

:confused: `86` /r : xchg r8, r/m8<br>
:confused: `87` /r : xchg r/m32, r32<br>

:confused: `88` /r : mov r/m8, r8<br>
:confused: `89` /r : mov r/m32, r32<br>
:confused: `8A` /r : mov r8, r/m8<br>
:confused: `8B` /r : mov r32, r/m32<br>
:confused: `8C` /r : mov r16/r32/m16, sreg<br>

:confused: `8D` /r : lea r32, m<br>

:confused: `8E` /r : mov sreg, r/m16<br>

:confused: `8F` /r : pop r/m64<br>

:green_heart: `90` : xchg eax, eax // nop<br>
:confused: `91` : xchg ecx, eax<br>
:confused: `92` : xchg edx, eax<br>
:confused: `93` : xchg ebx, eax<br>
:confused: `94` : xchg esp, eax<br>
:confused: `95` : xchg ebp, eax<br>
:confused: `96` : xchg esi, eax<br>
:confused: `97` : xchg edi, eax<br>

:confused: `98` : cwde<br>
:confused: `99` : cdq<br>

:skull: `9A` iw id : call ptr16:32&emsp;// Invalid<br>

:confused: `9B` : fwait<br>
:confused: `9C` : pushf<br>
:confused: `9D` : popf<br>
:confused: `9E` : sahf<br>
:confused: `9F` : lahf<br>

:confused: `A0` iq : mov al, moffs8<br>
:confused: `A1` iq : mov eax, moffs32<br>
:confused: `A2` iq : mov moffs8, AL<br>
:confused: `A3` iq : mov moffs32, eax<br>

:confused: `A4` : movsb<br>
:confused: `A5` : movsd<br>
:confused: `A6` : cmpsb<br>
:confused: `A7` : cmpsd<br>

:confused: `A8` ib : test al, imm8<br>
:confused: `A9` id : test eax, imm32<br>

:confused: `AA` : stosb<br>
:confused: `AB` : stosd<br>
:confused: `AC` : lodsb<br>
:confused: `AD` : lodsd<br>
:confused: `AE` : scasb<br>
:confused: `AF` : scasd<br>

:confused: `B0` ib : mov al, imm8<br>
:confused: `B1` ib : mov cl, imm8<br>
:confused: `B2` ib : mov dl, imm8<br>
:confused: `B3` ib : mov bl, imm8<br>
:confused: `B4` ib : mov ah, imm8<br>
:confused: `B5` ib : mov ch, imm8<br>
:confused: `B6` ib : mov dh, imm8<br>
:confused: `B7` ib : mov bh, imm8<br>
:confused: `B8` id : mov eax, imm32<br>
:confused: `B9` id : mov ecx, imm32<br>
:confused: `BA` id : mov edx, imm32<br>
:confused: `BB` id : mov ebx, imm32<br>
:confused: `BC` id : mov esp, imm32<br>
:confused: `BD` id : mov ebp, imm32<br>
:confused: `BE` id : mov esi, imm32<br>
:confused: `BF` id : mov edi, imm32<br>

:confused: `C0` /0 ib : rol r/m8, imm8<br>
:confused: `C0` /1 ib : ror r/m8, imm8<br>
:confused: `C0` /2 ib : rcl r/m8, imm8<br>
:confused: `C0` /3 ib : rcr r/m8, imm8<br>
:confused: `C0` /4 ib : shl r/m8, imm8<br>
:confused: `C0` /4 ib : sal r/m8, imm8<br>
:confused: `C0` /5 ib : shr r/m8, imm8<br>
:confused: `C0` /7 ib : sar r/m8, imm8<br>

:confused: `C1` /0 ib : rol r/m32, imm8<br>
:confused: `C1` /1 ib : ror r/m32, imm8<br>
:confused: `C1` /2 ib : rcl r/m32, imm8<br>
:confused: `C1` /3 ib : rcr r/m32, imm8<br>
:confused: `C1` /4 ib : shl r/m32, imm8<br>
:confused: `C1` /4 ib : sal r/m32, imm8<br>
:confused: `C1` /5 ib : shr r/m32, imm8<br>
:confused: `C1` /7 ib : sar r/m32, imm8<br>

:confused: `C2` iw : ret imm16<br>
:confused: `C3`&emsp;&ensp;: ret <br>

:confused: `C6` /0 ib : mov r/m8, imm8<br>
:confused: `C7` /0 id : mov r/m32, imm32<br>

:confused: `C8` iw ib : enter imm16, imm8<br>
:confused: `C9`&emsp;&emsp;&ensp;&nbsp;: leave<br>

:confused: `CA` iw : retf imm16<br>
:confused: `CB`&emsp;&ensp;: retf<br>

:confused: `CC`&emsp;&ensp;: int3<br>
:confused: `CD` id : int imm8<br>

:skull: `CE` : into&emsp;// Invalid<br>

:confused: `CF` : iret<br>

:confused: `D0` /0 : rol r/m8, 1<br>
:confused: `D0` /1 : ror r/m8, 1<br>
:confused: `D0` /2 : rcl r/m8, 1<br>
:confused: `D0` /3 : rcr r/m8, 1<br>
:confused: `D0` /4 : shl r/m8, 1<br>
:confused: `D0` /4 : sal r/m8, 1<br>
:confused: `D0` /5 : shr r/m8, 1<br>
:confused: `D0` /7 : sar r/m8, 1<br>

:confused: `D1` /0 : rol r/m16, 1<br>
:confused: `D1` /1 : ror r/m16, 1<br>
:confused: `D1` /2 : rcl r/m16, 1<br>
:confused: `D1` /3 : rcr r/m16, 1<br>
:confused: `D1` /4 : shl r/m16, 1<br>
:confused: `D1` /4 : sal r/m16, 1<br>
:confused: `D1` /5 : shr r/m16, 1<br>
:confused: `D1` /7 : sar r/m16, 1<br>

:confused: `D2` /0 : rol r/m8, cl<br>
:confused: `D2` /1 : ror r/m8, cl<br>
:confused: `D2` /2 : rcl r/m8, cl<br>
:confused: `D2` /3 : rcr r/m8, cl<br>
:confused: `D2` /4 : shl r/m8, cl<br>
:confused: `D2` /4 : sal r/m8, cl<br>
:confused: `D2` /5 : shr r/m8, cl<br>
:confused: `D2` /7 : sar r/m8, cl<br>

:confused: `D3` /0 : rol r/m16, cl<br>
:confused: `D3` /1 : ror r/m16, cl<br>
:confused: `D3` /2 : rcl r/m16, cl<br>
:confused: `D3` /3 : rcr r/m16, cl<br>
:confused: `D3` /4 : shl r/m16, cl<br>
:confused: `D3` /4 : sal r/m16, cl<br>
:confused: `D3` /5 : shr r/m16, cl<br>
:confused: `D3` /7 : sar r/m16, cl<br>

:skull: `D4` ib : aam imm8&emsp;// Invalid<br>
:skull: `D5` ib : aad imm8&emsp;// Invalid<br>

:thought_balloon: `D6` : // Unknown<br>

:confused: `D7` : xlat<br>

:broken_heart: `D8` /0 : fadd m32fp<br>
:broken_heart: `D8` /1 : fmul m32fp<br>
:broken_heart: `D8` /2 : fcom m32fp<br>
:broken_heart: `D8` /3 : fcomp m32fp<br>
:broken_heart: `D8` /4 : fsub m32fp<br>
:broken_heart: `D8` /5 : fsubr m32fp<br>
:broken_heart: `D8` /6 : fdiv m32fp<br>
:broken_heart: `D8` /7 : fdivr m32fp<br>

:broken_heart: `D9` /0 : fld m32fp<br>
:broken_heart: `D9` /2 : fst m32fp<br>
:broken_heart: `D9` /3 : fstp m32fp<br>
:broken_heart: `D9` /4 : fldenv m14/28byte<br>
:broken_heart: `D9` /5 : fldcw m2byte<br>
:broken_heart: `D9` /6 : fnstenv m14/28byte<br>
:broken_heart: `D9` /7 : fnstcw m2byte<br>

:broken_heart: `DA` /0 : fiadd m32int<br>
:broken_heart: `DA` /1 : fimul m32int<br>
:broken_heart: `DA` /2 : ficom m32int<br>
:broken_heart: `DA` /3 : ficomp m32int<br>
:broken_heart: `DA` /4 : fisub m32int<br>
:broken_heart: `DA` /5 : fisubr m32int<br>
:broken_heart: `DA` /6 : fidiv m32int<br>
:broken_heart: `DA` /7 : fidivr m32int<br>

:broken_heart: `DB` /0 : fild m32int<br>
:broken_heart: `DB` /1 : fisttp m32int<br>
:broken_heart: `DB` /2 : fist m32int<br>
:broken_heart: `DB` /3 : fistp m32int<br>
:broken_heart: `DB` /5 : fld m80fp<br>
:broken_heart: `DB` /7 : fltp m80fp<br>

:broken_heart: `DC` /0 : fadd m64fp<br>
:broken_heart: `DC` /1 : fmul m64fp<br>
:broken_heart: `DC` /2 : fcom m64fp<br>
:broken_heart: `DC` /3 : fcomp m64fp<br>
:broken_heart: `DC` /4 : fsub m64fp<br>
:broken_heart: `DC` /5 : fsubr m64fp<br>
:broken_heart: `DC` /6 : fdev m64fp<br>
:broken_heart: `DC` /7 : fdivr m64fp<br>

:broken_heart: `DD` /0 : fld m64fp<br>
:broken_heart: `DD` /1 : fisttp m64int<br>
:broken_heart: `DD` /2 : fst m64fp<br>
:broken_heart: `DD` /3 : fstp m64fp<br>
:broken_heart: `DD` /4 : frstor m94/108byte<br>
:broken_heart: `DD` /6 : fnsave m94/108byte<br>
:broken_heart: `DD` /7 : fnstsw m2byte<br>

:broken_heart: `DE` /0 : fiadd m16int<br>
:broken_heart: `DE` /1 : fimul m16int<br>
:broken_heart: `DE` /2 : ficom m16int<br>
:broken_heart: `DE` /3 : ficomip m16int<br>
:broken_heart: `DE` /4 : fisub m16int<br>
:broken_heart: `DE` /5 : fisubr m16int<br>
:broken_heart: `DE` /6 : fidiv m16int<br>
:broken_heart: `DE` /7 : fidivr m16int<br>

:broken_heart: `DF` /0 : fild m16int<br>
:broken_heart: `DF` /1 : fisttp m16int<br>
:broken_heart: `DF` /2 : fist m16int<br>
:broken_heart: `DF` /3 : fistp m16int<br>
:broken_heart: `DF` /4 : fbld m80bcd<br>
:broken_heart: `DF` /5 : fild m64int<br>
:broken_heart: `DF` /6 : fbstp m80bcd<br>
:broken_heart: `DF` /7 : fistp m64int<br>

:confused: `E0` ib : loopne rel8<br>
:confused: `E1` ib : loope rel8<br>
:confused: `E2` ib : loop rel8<br>

:confused: `E3` ib : jrcxz rel8<br>

:broken_heart: `E4` ib : in al, imm8<br>
:broken_heart: `E5` ib : in eax, imm8<br>

:broken_heart: `E6` ib : out imm8, al<br>
:broken_heart: `E7` ib : out imm8, eax<br>

:confused: `E8` id : call rel32<br>
:confused: `E9` id : jmp rel32<br>

:confused: `EA` iw id : jmp ptr16:32<br>

:confused: `EB` iw : jmp rel16<br>

:broken_heart: `EC` ib : in al, dx<br>
:broken_heart: `ED` ib : in eax, dx<br>

:broken_heart: `EE` : out dx, al<br>
:broken_heart: `EF` : out dx, eax<br>

:confused: `F1` : int1 // icebp<br>
:confused: `F4` : hlt<br>
:confused: `F5` : cmc<br>

:confused: `F6` /0 ib : test r/m8, imm8<br>

:confused: `F6` /2    : not r/m8<br>
:confused: `F6` /3    : neg r/m8<br>
:confused: `F6` /4    : mul r/m8<br>
:confused: `F6` /5    : imul r/m8<br>
:confused: `F6` /6    : div r/m8<br>
:confused: `F6` /7    : idiv r/m8<br>

:confused: `F7` /0 id : test r/m32, imm32<br>

:confused: `F7` /2    : not r/m32<br>
:confused: `F7` /3    : neg r/m32<br>
:confused: `F7` /4    : mul r/m32<br>
:confused: `F7` /5    : imul r/m32<br>
:confused: `F7` /6    : div r/m32<br>
:confused: `F7` /7    : idiv r/m32<br>

:confused: `F8` : clc<br>
:confused: `F9` : stc<br>
:confused: `FA` : cli<br>
:confused: `FB` : sti<br>
:confused: `FC` : cld<br>
:confused: `FD` : std<br>

:confused: `FE` /0 : dec r/m8<br>
:confused: `FE` /1 : inc r/m8<br>
:confused: `FF` /0 : dec r/m16<br>
:confused: `FF` /1 : inc r/m16<br>

:confused: `FF` /2 : call r/m64<br>
:confused: `FF` /3 : call m16:32<br>

:confused: `FF` /4 : jmp r/m64<br>
:confused: `FF` /5 : jmp m16:32<br>

:confused: `FF` /6 : push r/m64<br>

## More Opcodes
:confused: 0F `00` /0 : sldt r/m16<br>
:confused: 0F `00` /1 : str r/m16<br>
:confused: 0F `00` /2 : lldt r/m16<br>
:confused: 0F `00` /3 : ltr r/m16<br>
:confused: 0F `00` /4 : verr r/m16<br>
:confused: 0F `00` /5 : verw r/m16<br>

:green_heart: 0F `0B` : ud2

:green_heart: 0F `01` F9 : rdtscp

:confused: 0F `18` /0 : prefetchnta m8<br>
:confused: 0F `18` /1 : prefetch0 m8<br>
:confused: 0F `18` /2 : prefetch1 m8<br>
:confused: 0F `18` /3 : prefetch2 m8<br>

:confused: 0F `1F` /0 : nop<br>

:green_heart: 0F `31` : rdtsc<br>

:confused: 0F `05` : syscall<br>

:confused: 0F `07` : sysret<br>

:green_heart: 0F `80` ib : jo rel32<br>
:green_heart: 0F `81` ib : jno rel32<br>
:green_heart: 0F `82` ib : jb rel32<br>
:green_heart: 0F `83` ib : jae rel32<br>
:green_heart: 0F `84` ib : je rel32<br>
:green_heart: 0F `85` ib : jne rel32<br>
:green_heart: 0F `86` ib : jbe rel32<br>
:green_heart: 0F `87` ib : ja rel32<br>
:green_heart: 0F `88` ib : js rel32<br>
:green_heart: 0F `89` ib : jns rel32<br>
:green_heart: 0F `8A` ib : jp rel32<br>
:green_heart: 0F `8B` ib : jnp rel32<br>
:green_heart: 0F `8C` ib : jl rel32<br>
:green_heart: 0F `8D` ib : jge rel32<br>
:green_heart: 0F `8E` ib : jle rel32<br>
:green_heart: 0F `8F` ib : jg rel32<br>

:green_heart: 0F `A2` : cpuid<br>

:green_heart: 0F `AE` /7 : clflush m8<br>
:green_heart: 0F `AE` E8 : lfence<br>
:green_heart: 0F `AE` F0 : mfence<br>
:green_heart: 0F `AE` F8 : sfence<br>

:confused: 0F `AF` /r : imul r32, r/m32<br>

:green_heart: 0F `B0` /r : cmpxchg r/m8, r8<br>
:green_heart: 0F `B1` /r : cmpxchg r/m32, r32<br>

:green_heart: 0F `B6` /r : movzx r32, r/m8<br>
:green_heart: 0F `B7` /r : movzx r32, r/m16<br>

:confused: 0F `B9` /r : ud1 r32, r/m32

:green_heart: 0F `BE` /r : movsx r32, r/m8<br>
:green_heart: 0F `BF` /r : movsx r32, r/m16<br>

:confused: F2 0F 38 `F0` /r : crc32 r32, r/m8<br>
:confused: F2 0F 38 `F1` /r : crc32 r32, r/m16<br>

:confused: 0F `FF` /r : ud0 r32, r/m32

## More Opcodes ( SIMD )
:confused:&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;0F `10` /r : movups xmm, xmm/m128<br>
:confused: vex.128.0F&emsp;&emsp;&ensp;&nbsp;`10` /r : vmovups xmm, xmm/m128<br>

:confused:&emsp;&emsp;&emsp;&emsp;&emsp;66 0F `10` /r : movupd xmm, xmm/m128<br>
:confused: vex.128.66.0F&emsp;&ensp;`10` /r : vmovupd xmm, xmm/m128<br>

:confused:&emsp;&emsp;&emsp;&emsp;&emsp;F2 0F `10` /r : movsd xmm, xmm<br>
:confused:&emsp;&emsp;&emsp;&emsp;&emsp;F3 0F `10` /r : movss xmm, xmm<br>

:confused:&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;0F `58` /r : addps xmm, xmm/m128<br>
:confused: vex.128.0F&emsp;&ensp;0F `58` /r : vaddps xmm, xmm, xmm/m128<br>
:confused: vex.256.0F&emsp;&ensp;0F `58` /r : vaddps ymm, ymm, ymm/m256<br>

:confused:&emsp;&emsp;&emsp;&emsp;&emsp;66 0F `58` /r : addpd xmm, xmm/m128<br>
:confused: vex.128.66.0F&emsp;&ensp;`58` /r : vaddpd xmm, xmm, xmm/m128<br>
:confused: vex.256.66.0F&emsp;&ensp;`58` /r : vaddpd ymm, ymm, ymm/m256<br>

:confused:&emsp;&emsp;&emsp;&emsp;&emsp;F2 0F `58` /r : addsd xmm, xmm/m64<br>
:confused: vex.F2.0F&emsp;&emsp;&emsp;&ensp;`58` /r : vaddsd xmm, xmm, xmm/m64<br>

:confused:&emsp;&emsp;&emsp;&emsp;&emsp;F3 0F `58` /r : addss xmm, xmm/m32<br>
:confused: vex.F3.0F&emsp;&emsp;&emsp;&ensp;`58` /r : vaddss xmm, xmm, xmm3/m32<br>

:confused:&emsp;&emsp;&emsp;&emsp;&emsp;66 0F `D0` /r : addsubpd xmm, xmm/m128<br>
:confused:vex.128.66.0F&emsp;&ensp;&nbsp;`D0` /r : vaddsubpd xmm, xmm, xmm/m128<br>
:confused:vex.256.66.0F&emsp;&ensp; `D0` /r : vaddsubpd ymm, ymm, ymm/m256<br>

:confused:&emsp;&emsp;&emsp;&emsp;&emsp;F2 0F `D0` /r : addsubps xmm, xmm/m128<br>
:confused:vex.128.F2.0F&emsp;&ensp;&nbsp;`D0` /r : vaddsubps xmm, xmm, xmm/m128<br>
:confused:vex.256.F2.0F&emsp;&ensp; `D0` /r : vaddsubps ymm, ymm, ymm/m256<br>
