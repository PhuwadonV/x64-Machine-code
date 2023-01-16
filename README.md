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
| Register    | 8  | 16 | 32  | mmx | xmm  |
|-------------|----|----|-----|-----|------|
| `reg0`      | al | ax | eax | mm0 | xmm0 |
| `reg1`      | cl | cx | ecx | mm1 | xmm1 |
| `reg2`      | dl | dx | edx | mm2 | xmm2 |
| `reg3`      | bl | bx | ebx | mm3 | xmm3 |
| `reg4`      | ah | sp | esp | mm4 | xmm4 |
| `reg5`      | bh | bp | ebp | mm5 | xmm5 |
| `reg6`      | ch | si | esi | mm6 | xmm6 |
| `reg7`      | dh | di | edi | mm7 | xmm7 |

| Memory (M)                | `reg0` | `reg1` | `reg2` | `reg3` | `reg4` | `reg5` | `reg6` | `reg7` |
|---------------------------|--------|--------|--------|--------|--------|--------|--------|--------|
| [eax]                     | 00     | 08     | 10     | 18     | 20     | 28     | 30     | 38     |
| [ecx]                     | 01     | 09     | 11     | 19     | 21     | 29     | 31     | 39     |
| [edx]                     | 02     | 0A     | 12     | 1A     | 22     | 2A     | 32     | 3A     |
| [ebx]                     | 03     | 0B     | 13     | 1B     | 23     | 2B     | 33     | 3B     |
| sib                       | 04     | 0C     | 14     | 1C     | 24     | 2C     | 34     | 3C     |
| disp32                    | 05     | 0D     | 15     | 1D     | 25     | 2D     | 35     | 3D     |
| [esi]                     | 06     | 0E     | 16     | 1E     | 26     | 2E     | 36     | 3E     |
| [edi]                     | 07     | 0F     | 17     | 1F     | 27     | 2F     | 37     | 3F     |

| Memory (M)                | `reg0` | `reg1` | `reg2` | `reg3` | `reg4` | `reg5` | `reg6` | `reg7` |
|---------------------------|--------|--------|--------|--------|--------|--------|--------|--------|
| [eax] + disp8             | 40     | 48     | 50     | 58     | 60     | 68     | 70     | 78     |
| [ecx] + disp8             | 41     | 49     | 51     | 59     | 61     | 69     | 71     | 79     |
| [edx] + disp8             | 42     | 4A     | 52     | 5A     | 62     | 6A     | 72     | 7A     |
| [ebx] + disp8             | 43     | 4B     | 53     | 5B     | 63     | 6B     | 73     | 7B     |
| sib&emsp;&nbsp;+ disp8    | 44     | 4C     | 54     | 5C     | 64     | 6C     | 74     | 7C     |
| [ebp] + disp8             | 45     | 4D     | 55     | 5D     | 65     | 6D     | 75     | 7D     |
| [esi]&ensp;&nbsp;+ disp8  | 46     | 4E     | 56     | 5E     | 66     | 6E     | 76     | 7E     |
| [edi]&ensp;+ disp8        | 47     | 4F     | 57     | 5F     | 67     | 6F     | 77     | 7F     |

| Memorys (M)               | `reg0` | `reg1` | `reg2` | `reg3` | `reg4` | `reg5` | `reg6` | `reg7` |
|---------------------------|--------|--------|--------|--------|--------|--------|--------|--------|
| [eax] + disp32            | 80     | 88     | 90     | 98     | A0     | A8     | B0     | B8     |
| [ecx] + disp32            | 81     | 89     | 91     | 99     | A1     | A9     | B1     | B9     |
| [edx] + disp32            | 82     | 8A     | 92     | 9A     | A2     | AA     | B2     | BA     |
| [ebx] + disp32            | 83     | 8B     | 93     | 9B     | A3     | AB     | B3     | BB     |
| sib&emsp;&nbsp;+ disp32   | 84     | 8C     | 94     | 9C     | A4     | AC     | B4     | BC     |
| [ebp] + disp32            | 85     | 8D     | 95     | 9D     | A5     | AD     | B5     | BD     |
| [esi]&ensp;&nbsp;+ disp32 | 86     | 8E     | 96     | 9E     | A6     | AE     | B6     | BE     |
| [edi]&ensp;+ disp32       | 87     | 8F     | 97     | 9F     | A7     | AF     | B7     | BF     |

| Register (R)&emsp;        | `reg0` | `reg1` | `reg2` | `reg3` | `reg4` | `reg5` | `reg6` | `reg7` |
|---------------------------|--------|--------|--------|--------|--------|--------|--------|--------|
| `reg0`                    | 80     | 88     | 90     | 98     | A0     | A8     | B0     | B8     |
| `reg1`                    | 81     | 89     | 91     | 99     | A1     | A9     | B1     | B9     |
| `reg2`                    | 82     | 8A     | 92     | 9A     | A2     | AA     | B2     | BA     |
| `reg3`                    | 83     | 8B     | 93     | 9B     | A3     | AB     | B3     | BB     |
| `reg4`                    | 84     | 8C     | 94     | 9C     | A4     | AC     | B4     | BC     |
| `reg5`                    | 85     | 8D     | 95     | 9D     | A5     | AD     | B5     | BD     |
| `reg6`                    | 86     | 8E     | 96     | 9E     | A6     | AE     | B6     | BE     |
| `reg7`                    | 87     | 8F     | 97     | 9F     | A7     | AF     | B7     | BF     |

## SIB
| ModR/M  | `*`                             |
|---------|---------------------------------|
| 00 - 3F | [scaled index] + disp32         |
| 40 - 7F | [scaled index] + disp8 + [ebp]  |
| 80 - BF | [scaled index] + disp32 + [ebp] |

| Scaled Index         | eax | ecx | edx | ebx | esp | `*` | esi | edi |
|----------------------|-----|-----|-----|-----|-----|-----|-----|-----|
| [eax * 1]            | 00  | 01  | 02  | 03  | 04  | 05  | 06  | 07  |
| [ecx * 1]            | 08  | 09  | 0A  | 0B  | 0C  | 0D  | 0E  | 0F  |
| [edx * 1]            | 10  | 11  | 12  | 13  | 14  | 15  | 16  | 17  |
| [ebx * 1]            | 18  | 19  | 1A  | 1B  | 1C  | 1D  | 1E  | 1F  |
| none                 | 20  | 21  | 22  | 23  | 24  | 25  | 26  | 27  |
| [ebp * 1]            | 28  | 29  | 2A  | 2B  | 2C  | 2D  | 2E  | 2F  |
| [esi&ensp;&nbsp;* 1] | 30  | 31  | 32  | 33  | 34  | 35  | 36  | 37  |
| [edi&ensp;* 1]       | 38  | 39  | 3A  | 3B  | 3C  | 3D  | 3E  | 3F  |

| Scaled Index         | eax | ecx | edx | ebx | esp | `*` | esi | edi |
|----------------------|-----|-----|-----|-----|-----|-----|-----|-----|
| [eax * 2]            | 40  | 41  | 42  | 43  | 44  | 45  | 46  | 47  |
| [ecx * 2]            | 48  | 49  | 4A  | 4B  | 4C  | 4D  | 4E  | 4F  |
| [edx * 2]            | 50  | 51  | 52  | 53  | 54  | 55  | 56  | 57  |
| [ebx * 2]            | 58  | 59  | 5A  | 5B  | 5C  | 5D  | 5E  | 5F  |
| none                 | 60  | 61  | 62  | 63  | 64  | 65  | 66  | 67  |
| [ebp * 2]            | 68  | 69  | 6A  | 6B  | 6C  | 6D  | 6E  | 6F  |
| [esi&ensp;&nbsp;* 2] | 70  | 71  | 72  | 73  | 74  | 75  | 76  | 77  |
| [edi&ensp;* 2]       | 78  | 79  | 7A  | 7B  | 7C  | 7D  | 7E  | 7F  |

| Scaled Index         | eax | ecx | edx | ebx | esp | `*` | esi | edi |
|----------------------|-----|-----|-----|-----|-----|-----|-----|-----|
| [eax * 4]            | 80  | 81  | 82  | 83  | 84  | 85  | 86  | 87  |
| [ecx * 4]            | 88  | 89  | 8A  | 8B  | 8C  | 8D  | 8E  | 8F  |
| [edx * 4]            | 90  | 91  | 92  | 93  | 94  | 95  | 96  | 97  |
| [ebx * 4]            | 98  | 99  | 9A  | 9B  | 9C  | 9D  | 9E  | 9F  |
| none                 | A0  | A1  | A2  | A3  | A4  | A5  | A6  | A7  |
| [ebp * 4]            | A8  | A9  | AA  | AB  | AC  | AD  | AE  | AF  |
| [esi&ensp;&nbsp;* 4] | B0  | B1  | B2  | B3  | B4  | B5  | B6  | B7  |
| [edi&ensp;* 4]       | B8  | B9  | BA  | BB  | BC  | BD  | BE  | BF  |

| Scaled Index         | eax | ecx | edx | ebx | esp | `*` | esi | edi |
|----------------------|-----|-----|-----|-----|-----|-----|-----|-----|
| [eax * 8]            | C0  | C1  | C2  | C3  | C4  | C5  | C6  | C7  |
| [ecx * 8]            | C8  | C9  | CA  | CB  | CC  | CD  | CE  | CF  |
| [edx * 8]            | D0  | D1  | D2  | D3  | D4  | D5  | D6  | D7  |
| [ebx * 8]            | D8  | D9  | DA  | DB  | DC  | DD  | DE  | DF  |
| none                 | E0  | E1  | E2  | E3  | E4  | E5  | E6  | E7  |
| [ebp * 8]            | E8  | E9  | EA  | EB  | EC  | ED  | EE  | EF  |
| [esi&ensp;&nbsp;* 8] | F0  | F1  | F2  | F3  | F4  | F5  | F6  | F7  |
| [edi&ensp;* 8]       | F8  | F9  | FA  | FB  | FC  | FD  | FE  | FF  |

# Machine code
## Unknown
:grey_question: `82`<br>
:grey_question: `D6`<br>
## Invalid
:x: `06`&emsp;&emsp;&ensp;: push es<br>
:x: `07`&emsp;&emsp;&ensp;: pop  es<br>
:x: `0E`&emsp;&emsp;&ensp;: push cs<br>
:x: `16`&emsp;&emsp;&ensp;: push ss<br>
:x: `17`&emsp;&emsp;&ensp;: pop  ss<br>
:x: `1E`&emsp;&emsp;&ensp;: push ds<br>
:x: `1F`&emsp;&emsp;&ensp;: pop  ds<br>
:x: `27`&emsp;&emsp;&ensp;: daa<br>
:x: `2F`&emsp;&emsp;&ensp;: das<br>
:x: `37`&emsp;&emsp;&ensp;: aaa<br>
:x: `3F`&emsp;&emsp;&ensp;: aas<br>
:x: `60`&emsp;&emsp;&ensp;: push a<br>
:x: `61`&emsp;&emsp;&ensp;: pop a<br>
:x: `9A` iw id : call ptr16:32<br>
:x: `CE`&emsp;&emsp;&ensp;: into<br>
:x: `D4` ib&emsp;&ensp;: aam imm8<br>
:x: `D5` ib&emsp;&ensp;: aad imm8<br>

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

## REX flag
`41` : rex.b&emsp;&ensp;// ModR/M r/m | SIB base | Opcode reg<br>
`42` : rex.x&emsp;&ensp;// &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;&nbsp;SIB index<br>
`44` : rex.r&emsp;&ensp;// ModR/M reg<br>
`48` : rex.w&emsp;// 32bit :arrow_right: 64bit<br>

| Flag      |            |               |            |
|-----------|------------|---------------|------------|
| b & x & r | eax - edi  | :arrow_right: | r8d - r15d |
| w         | eax - edi  | :arrow_right: | rax - rdi  |
| w         | r8d - r15d | :arrow_right: | r8 - r15   |

## VEX
`C4` : <br>
`C5` : <br>

## EVEX
`62` : <br>

## Prefix-like
`0F` : more opcode<br>

`80` : opcode r/m8, imm8<br>
`81` : opcode r/m32, imm32<br>
`83` : opcode r/m32, imm8<br>

## Opcode
`00` /r : add r/m8, r8<br>
`01` /r : add r/m32, r32<br>
`02` /r : add r8, r/m8<br>
`03` /r : add r32, r/m32<br>
`04` ib : add al, imm8<br>
`05` id : add eax, imm32<br>

`08` /r : or r/m8, r8<br>
`09` /r : or r/m32, r32<br>
`0A` /r : or r8, r/m8<br>
`0B` /r : or r32, r/m32<br>
`0C` ib : or al, imm8<br>
`0D` id : or eax, imm32

`10` /r : adc r/m8, r8<br>
`11` /r : adc r/m32, r32<br>
`12` /r : adc r8, r/m8<br>
`13` /r : adc r32, r/m32<br>
`14` ib : adc al, imm8<br>
`15` id : adc eax, imm32<br>

`18` /r : sbb r/m8, r8<br>
`19` /r : sbb r/m32, r32<br>
`1A` /r : sbb r8, r/m8<br>
`1B` /r : sbb r32, r/m32<br>
`1C` ib : sbb al, imm8<br>
`1D` id : sbb eax, imm32<br>

`20` /r : and r/m8, r8<br>
`21` /r : and r/m32, r32<br>
`22` /r : and r8, r/m8<br>
`23` /r : and r32, r/m32<br>
`24` ib : and al, imm8<br>
`25` id : and eax, imm32<br>

`28` /r : sub r/m8, r8<br>
`29` /r : sub r/m32, r32<br>
`2A` /r : sub r8, r/m8<br>
`2B` /r : sub r32, r/m32<br>
`2C` ib : sub al, imm8<br>
`2D` id : sub eax, imm32<br>

`30` /r : xor r/m8, r8<br>
`31` /r : xor r/m32, r32<br>
`32` /r : xor r8, r/m8<br>
`33` /r : xor r32, r/m32<br>
`34` ib : xor al, imm8<br>
`35` id : xor eax, imm32<br>

`38` /r : cmp r/m8, r8<br>
`39` /r : cmp r/m32, r32<br>
`3A` /r : cmp r8, r/m8<br>
`3B` /r : cmp r32, r/m32<br>
`3C` ib : cmp al, imm8<br>
`3D` id : cmp eax, imm32<br>

`50` : push rax<br>
`51` : push rcx<br>
`52` : push rdx<br>
`53` : push rbx<br>
`54` : push rsp<br>
`55` : push rbp<br>
`56` : push rsi<br>
`57` : push rdi<br>

`58` : pop rax<br>
`59` : pop rcx<br>
`5A` : pop rdx<br>
`5B` : pop rbx<br>
`5C` : pop rsp<br>
`5D` : pop rbp<br>
`5E` : pop rsi<br>
`5F` : pop rdi<br>

`63` /r : movsxd r32, r/m32<br>

`68`&emsp;&emsp;&ensp;: push imm32<br>
`69` /r id : imul r32, r/m32, imm32<br>
`6A`&emsp;&emsp;&ensp;: push imm8<br>
`6B` /r ib : imul r32, r/m32, imm8<br>

`6C` : insb<br>
`6D` : insd<br>
`6E` : outsb<br>
`6F` : outsd<br>

`70` ib : jo rel8<br>
`71` ib : jno rel8<br>
`72` ib : jb rel8<br>
`73` ib : jae rel8<br>
`74` ib : je rel8<br>
`75` ib : jne rel8<br>
`76` ib : jbe rel8<br>
`77` ib : ja rel8<br>
`78` ib : js rel8<br>
`79` ib : jns rel8<br>
`7A` ib : jp rel8<br>
`7B` ib : jnp rel8<br>
`7C` ib : jl rel8<br>
`7D` ib : jge rel8<br>
`7E` ib : jle rel8<br>
`7F` ib : jg rel8<br>

`84` /r : test r/m8, r8<br>
`85` /r : test r/m8, r8<br>

`86` /r : xchg r8, r/m8<br>
`87` /r : xchg r/m32, r32<br>

`88` /r : mov r/m8, r8<br>
`89` /r : mov r/m32, r32<br>
`8A` /r : mov r8, r/m8<br>
`8B` /r : mov r32, r/m32<br>
`8C` /r : mov r16/r32/m16, sreg<br>

`8D` /r : lea r32, m<br>

`8E` /r : mov sreg, r/m16<br>

`8F` /r : pop r/m64<br>

`90` : xchg eax, eax // nop<br>
`91` : xchg ecx, eax<br>
`92` : xchg edx, eax<br>
`93` : xchg ebx, eax<br>
`94` : xchg esp, eax<br>
`95` : xchg ebp, eax<br>
`96` : xchg esi, eax<br>
`97` : xchg edi, eax<br>

`98` : cwde<br>
`99` : cdq<br>

`9B` : fwait<br>
`9C` : pushf<br>
`9D` : popf<br>
`9E` : sahf<br>
`9F` : lahf<br>

`A0` iq : mov al, moffs8<br>
`A1` iq : mov eax, moffs32<br>
`A2` iq : mov moffs8, AL<br>
`A3` iq : mov moffs32, eax<br>

`A4` : movsb<br>
`A5` : movsd<br>
`A6` : cmpsb<br>
`A7` : cmpsd<br>

`A8` ib : test al, imm8<br>
`A9` id : test eax, imm32<br>

`AA` : stosb<br>
`AB` : stosd<br>
`AC` : lodsb<br>
`AD` : lodsd<br>
`AE` : scasb<br>
`AF` : scasd<br>

`B0` ib : mov al, imm8<br>
`B1` ib : mov cl, imm8<br>
`B2` ib : mov dl, imm8<br>
`B3` ib : mov bl, imm8<br>
`B4` ib : mov ah, imm8<br>
`B5` ib : mov ch, imm8<br>
`B6` ib : mov dh, imm8<br>
`B7` ib : mov bh, imm8<br>
`B8` id : mov eax, imm32<br>
`B9` id : mov ecx, imm32<br>
`BA` id : mov edx, imm32<br>
`BB` id : mov ebx, imm32<br>
`BC` id : mov esp, imm32<br>
`BD` id : mov ebp, imm32<br>
`BE` id : mov esi, imm32<br>
`BF` id : mov edi, imm32<br>

`C0` /0 ib : rol r/m8, imm8<br>
`C0` /1 ib : ror r/m8, imm8<br>
`C0` /2 ib : rcl r/m8, imm8<br>
`C0` /3 ib : rcr r/m8, imm8<br>
`C0` /4 ib : shl r/m8, imm8<br>
`C0` /4 ib : sal r/m8, imm8<br>
`C0` /5 ib : shr r/m8, imm8<br>
`C0` /7 ib : sar r/m8, imm8<br>

`C1` /0 ib : rol r/m32, imm8<br>
`C1` /1 ib : ror r/m32, imm8<br>
`C1` /2 ib : rcl r/m32, imm8<br>
`C1` /3 ib : rcr r/m32, imm8<br>
`C1` /4 ib : shl r/m32, imm8<br>
`C1` /4 ib : sal r/m32, imm8<br>
`C1` /5 ib : shr r/m32, imm8<br>
`C1` /7 ib : sar r/m32, imm8<br>

`C2` iw : ret imm16<br>
`C3`&emsp;&ensp;: ret <br>

`C6` /0 ib : mov r/m8, imm8<br>
`C7` /0 id : mov r/m32, imm32<br>

`C8` iw ib : enter imm16, imm8<br>
`C9`&emsp;&emsp;&ensp;&nbsp;: leave<br>

`CA` iw : retf imm16<br>
`CB`&emsp;&ensp;: retf<br>

`CC`&emsp;&ensp;: int3<br>
`CD` id : int imm8<br>

`CF` : iret<br>

`D0` /0 : rol r/m8, 1<br>
`D0` /1 : ror r/m8, 1<br>
`D0` /2 : rcl r/m8, 1<br>
`D0` /3 : rcr r/m8, 1<br>
`D0` /4 : shl r/m8, 1<br>
`D0` /4 : sal r/m8, 1<br>
`D0` /5 : shr r/m8, 1<br>
`D0` /7 : sar r/m8, 1<br>

`D1` /0 : rol r/m16, 1<br>
`D1` /1 : ror r/m16, 1<br>
`D1` /2 : rcl r/m16, 1<br>
`D1` /3 : rcr r/m16, 1<br>
`D1` /4 : shl r/m16, 1<br>
`D1` /4 : sal r/m16, 1<br>
`D1` /5 : shr r/m16, 1<br>
`D1` /7 : sar r/m16, 1<br>

`D2` /0 : ROL r/m8, cl<br>
`D2` /1 : ror r/m8, cl<br>
`D2` /2 : rcl r/m8, cl<br>
`D2` /3 : rcr r/m8, cl<br>
`D2` /4 : shl r/m8, cl<br>
`D2` /4 : sal r/m8, cl<br>
`D2` /5 : shr r/m8, cl<br>
`D2` /7 : sar r/m8, cl<br>

`D3` /0 : ROL r/m16, cl<br>
`D3` /1 : ror r/m16, cl<br>
`D3` /2 : rcl r/m16, cl<br>
`D3` /3 : rcr r/m16, cl<br>
`D3` /4 : shl r/m16, cl<br>
`D3` /4 : sal r/m16, cl<br>
`D3` /5 : shr r/m16, cl<br>
`D3` /7 : sar r/m16, cl<br>

`D7` : xlat<br>

`D8` /0 : fadd m32fp<br>
`D8` /1 : fmul m32fp<br>
`D8` /2 : fcom m32fp<br>
`D8` /3 : fcomp m32fp<br>
`D8` /4 : fsub m32fp<br>
`D8` /5 : fsubr m32fp<br>
`D8` /6 : fdiv m32fp<br>
`D8` /7 : fdivr m32fp<br>

`D9` /0 : fld m32fp<br>
`D9` /2 : fst m32fp<br>
`D9` /3 : fstp m32fp<br>
`D9` /4 : fldenv m14/28byte<br>
`D9` /5 : fldcw m2byte<br>
`D9` /6 : fnstenv m14/28byte<br>
`D9` /7 : fnstcw m2byte<br>

`DA` /0 : fiadd m32int<br>
`DA` /1 : fimul m32int<br>
`DA` /2 : ficom m32int<br>
`DA` /3 : ficomp m32int<br>
`DA` /4 : fisub m32int<br>
`DA` /5 : fisubr m32int<br>
`DA` /6 : fidiv m32int<br>
`DA` /7 : fidivr m32int<br>

`DB` /0 : fild m32int<br>
`DB` /1 : fisttp m32int<br>
`DB` /2 : fist m32int<br>
`DB` /3 : fistp m32int<br>
`DB` /5 : fld m80fp<br>
`DB` /7 : fltp m80fp<br>

`DC` /0 : fadd m64fp<br>
`DC` /1 : fmul m64fp<br>
`DC` /2 : fcom m64fp<br>
`DC` /3 : fcomp m64fp<br>
`DC` /4 : fsub m64fp<br>
`DC` /5 : fsubr m64fp<br>
`DC` /6 : fdev m64fp<br>
`DC` /7 : fdivr m64fp<br>

`DD` /0 : fld m64fp<br>
`DD` /1 : fisttp m64int<br>
`DD` /2 : fst m64fp<br>
`DD` /3 : fstp m64fp<br>
`DD` /4 : frstor m94/108byte<br>
`DD` /6 : fnsave m94/108byte<br>
`DD` /7 : fnstsw m2byte<br>

`DE` /0 : fiadd m16int<br>
`DE` /1 : fimul m16int<br>
`DE` /2 : ficom m16int<br>
`DE` /3 : ficomip m16int<br>
`DE` /4 : fisub m16int<br>
`DE` /5 : fisubr m16int<br>
`DE` /6 : fidiv m16int<br>
`DE` /7 : fidivr m16int<br>

`DF` /0 : fild m16int<br>
`DF` /1 : fisttp m16int<br>
`DF` /2 : fist m16int<br>
`DF` /3 : fistp m16int<br>
`DF` /4 : fbld m80bcd<br>
`DF` /5 : fild m64int<br>
`DF` /6 : fbstp m80bcd<br>
`DF` /7 : fistp m64int<br>

`E0` ib : loopne rel8<br>
`E1` ib : loope rel8<br>
`E2` ib : loop rel8<br>

`E3` ib : jrcxz rel8<br>

`E4` ib : in al, imm8<br>
`E5` ib : in eax, imm8<br>

`E6` ib : out imm8, al<br>
`E7` ib : out imm8, eax<br>

`E8` id : call rel32<br>
`E9` id : jmp rel32<br>

`EA` iw id : jmp ptr16:32<br>

`EB` iw : jmp rel16<br>

`EC` ib : in al, dx<br>
`ED` ib : in eax, dx<br>

`EE` : out dx, al<br>
`EF` : out dx, eax<br>

`F1` : int1 // icebp<br>
`F4` : hlt<br>
`F5` : cmc<br>

`F6` /0 ib : test r/m8, imm8<br>

`F6` /2    : not r/m8<br>
`F6` /3    : neg r/m8<br>
`F6` /4    : mul r/m8<br>
`F6` /5    : imul r/m8<br>
`F6` /6    : div r/m8<br>
`F6` /7    : idiv r/m8<br>

`F7` /0 id : test r/m8, imm8<br>

`F7` /2    : not r/m32<br>
`F7` /3    : neg r/m32<br>
`F7` /4    : mul r/m32<br>
`F7` /5    : imul r/m32<br>
`F7` /6    : div r/m32<br>
`F7` /7    : idiv r/m32<br>

`F8` : clc<br>
`F9` : stc<br>
`FA` : cli<br>
`FB` : sti<br>
`FC` : cld<br>
`FD` : std<br>

`FE` /0 : dec r/m8<br>
`FE` /1 : inc r/m8<br>
`FF` /0 : dec r/m16<br>
`FF` /1 : inc r/m16<br>

`FF` /2 : call r/m64<br>
`FF` /3 : call m16:32<br>

`FF` /4 : jmp r/m64<br>
`FF` /5 : jmp m16:32<br>

`FF` /6 : push r/m64<br>

## More Opcode
0F `00` /0 : sldt r/m16<br>
0F `00` /1 : str r/m16<br>
0F `00` /2 : lldt r/m16<br>
0F `00` /3 : ltr r/m16<br>
0F `00` /4 : verr r/m16<br>
0F `00` /5 : verw r/m16<br>