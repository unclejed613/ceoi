'CEOI.BAS  NOTE KEEP TOTAL PER PAGE OUTPUT BELOW 65 LINES
'CEOI BOOKS SHOULD BE HAND DELIVERED ONLY!!!!!
CLS
SCREEN 12

ON KEY(1) GOSUB trapkey     '[F1] KEY TO ABORT AND EXIT
KEY(1) ON
GOSUB CONFIG
              'CONFIG FILE TROUBLESHOOTING OPTIONS
'PRINT "CONFIG OPTIONS"
'PRINT DAYS
'PRINT PWLEN
'PRINT LFLEN
'PRINT HFLEN
'PRINT HFY
'PRINT CBY
'PRINT NUMENCY
'PRINT NUMCODEY
'PRINT VHFLEN
'PRINT VUHFY
'PRINT ORG$


INPUT "Enter Month ", m$      'enter month using text for month and year (ex. NOV26)
j$ = m$ + ".txt"
OPEN j$ FOR APPEND AS #1

FOR d = 0 TO DAYS                'prints 10 sheets using last digit of date
PRINT ORG$
PRINT #1, ORG$
PRINT "MONTH "; m$
PRINT "DAY ID:", STR$(d)
PRINT #1, "MONTH "; m$                  ' month and day ID
PRINT #1, "DAY ID"; STR$(d)

iteration:
z$ = ""
y$ = ""
PRINT CHR$(32); CHR$(32); "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; CHR$(10);
PRINT #1, CHR$(32); CHR$(32); "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; CHR$(10);
PRINT "____________________________"; CHR$(10);
PRINT #1, "____________________________"; CHR$(10);     'print vigenere table
FOR i = 1 TO 26                                         'for encryption and authentication
RANDOMIZE (TIMER / 3)                      'instructions for using the table
                                        'are not included, and should be
GOTO linegen                            'memorized from external sources.
linedone:
NEXT i

GOSUB callsign
GOSUB PW
IF NUMCODEY = 1 THEN GOSUB numcode      'CONFIGURABLE OPTIONS
IF CBY = 1 THEN GOSUB chanlist          'SEE CEOI.CFG FOR DETAILS
IF HFY = 1 THEN GOSUB FREQS
IF NUMENCY = 1 THEN GOSUB numenc
IF VUHFY = 1 THEN GOSUB VUHF


PRINT CHR$(12)
PRINT #1, CHR$(12)
NEXT d
GOTO trapkey


linegen:
y$ = ""
z$ = ""

FOR x = 1 TO 26                   'generate a line of random letters
chargen:
y$ = CHR$(INT(RND * 26) + 65)
'ya$ = y$ + CHR$(32)

IF LEN(z$) < 1 GOTO skip



tst$ = ""
FOR tst = 1 TO LEN(z$)
tst$ = MID$(z$, tst, 1)           'insure there are no repeat letters in line
IF y$ = tst$ THEN GOTO chargen

NEXT tst
skip:
z$ = z$ + y$                   'assemble line of random letters
'PRINT z$
NEXT x
'RETURN

PRINT CHR$(i + 64); CHR$(179); z$; CHR$(10);  'print line
PRINT #1, CHR$(i + 64); CHR$(179); z$; CHR$(10);
SLEEP 1
GOTO linedone

callsign:                     'assign random callsigns for radio net
RANDOMIZE (TIMER / 3)
PRINT "__________________________________________________________________________"
PRINT #1, "__________________________________________________________________________"

'PRINT "CALLSIGNS"; "      NCS "; CHR$((RND * 25) + 65); CHR$((RND * 9) + 48); CHR$((RND * 25) + 65); "     NET "; CHR$((RND * 25) + 65); CHR$((RND * 9) + 48); CHR$((RND * 25) + 65)
sta$ = "CALLSIGNS         NCS" + CHR$(32) + CHR$((RND * 25) + 65) + CHR$((RND * 9) + 48) + CHR$((RND * 25) + 65) + "      NET " + CHR$((RND * 25) + 65) + CHR$((RND * 9) + 48) + CHR$((RND * 25) + 65)
PRINT sta$
PRINT #1, sta$

'PRINT #1, "__________________________________________________________________________"


U = 10
FOR csx = 1 TO U
PRINT "UNIT"; STR$(csx); "|";       'print a list of stations
PRINT #1, "UNIT"; STR$(csx); "|";
NEXT csx

PRINT CHR$(13)
PRINT #1, CHR$(13)

FOR csx = 1 TO U
RANDOMIZE TIMER
cs$ = ""
a$ = CHR$((RND * 25) + 65)             'generate and print callsigns
b$ = CHR$((RND * 9) + 48)
c$ = CHR$((RND * 25) + 65)
cs$ = a$ + b$ + c$
PRINT " "; cs$; "  |";
PRINT #1, " "; cs$; "  |";
SLEEP 1

NEXT csx
PRINT CHR$(13)
PRINT #1, CHR$(13)
PRINT "___________________________________________________________________________"
PRINT #1, "__________________________________________________________________________"

RETURN

PW:                                   'generate password list for the day
'RANDOMIZE (TIMER/3)
OPEN "DICT2.TXT" FOR INPUT AS #4      'using dictionary words selected at random
'PRINT "________________________________________________________________________"
PRINT "DAILY PASSWORDS"
PRINT "PRIMARY     ";
PRINT #1, "DAILY PASSWORDS"
PRINT #1, "PRIMARY     ";


FOR PW = 1 TO 3       '3 passwords both primary and secondary
RANDOMIZE (TIMER / 3)     'insures duplicates aren't a problem
l = INT(RND * PWLEN) + 1  'and provides better security

FOR x = 1 TO l
INPUT #4, l$
NEXT x
PRINT l$; "  ";
PRINT #1, l$; "  ";
SEEK #4, 1
SLEEP 1

NEXT PW

PRINT CHR$(13);
PRINT #1, CHR$(13)
PRINT "SECONDARY   ";
PRINT #1, "SECONDARY   ";
FOR PW = 1 TO 3
RANDOMIZE (TIMER / 3)
l = INT(RND * PWLEN) + 1

FOR x = 1 TO l
INPUT #4, l$
NEXT x
PRINT l$; "  ";
PRINT #1, l$; "  ";
SEEK #4, 1
SLEEP 1

NEXT PW
PRINT #1, CHR$(13)

PRINT "__________________________________________________________________________"
PRINT #1, "__________________________________________________________________________"

CLOSE #4
RETURN

numcode:          'generate a reduced security cipher for short messages
PRINT "NUMBER CODE (MEDIUM SECURITY)"
PRINT " A  B  C  D  E  F  G  H IJ K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z"
PRINT #1, "NUMBER CODE (MEDIUM SECURITY)"
PRINT #1, " A  B  C  D  E  F  G  H IJ K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z"

RANDOMIZE (TIMER / 3)
R1$ = "00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24"
R2$ = "25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49"
R3$ = "50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74"
R4$ = "75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99"
IR1 = (INT(RND * 25) * 3) + 1         '4 sets of numbers 00-99 selected from
IR2 = (INT(RND * 25) * 3) + 1         'double long strings to allow rollover.
IR3 = (INT(RND * 25) * 3) + 1         'selection of number ranges with random
IR4 = (INT(RND * 25) * 3) + 1         'offsets.
P1$ = MID$(R1$, IR1, 75)
P2$ = MID$(R2$, IR2, 75)
P3$ = MID$(R3$, IR3, 75)
P4$ = MID$(R4$, IR4, 75)
PRINT P1$
PRINT P2$
PRINT P3$                              'print the cipher table
PRINT P4$
PRINT #1, P1$
PRINT #1, P2$
PRINT #1, P3$
PRINT #1, P4$
PRINT "__________________________________________________________________________"
PRINT #1, "__________________________________________________________________________"
SLEEP 1

RETURN

numenc: 'ONLY USE THIS OPTION FOR TRAINING USING THE VIGENERE TABLE AND
        'NUMBER CIPHER. THIS OPTION CAN BE DISABLED IN THE CONFIG FILE.

PRINT "TO ENCRYPT DIGITS, USE THE FOLLOWING CODES WITH THE DIGITS SEPARATED BY X."
PRINT "1 WUN  2 TWO  3 TRE  4 FOR  5 FIV  6 SIX  7 SVN  8 EGT  9 NIN  0 ZRO "
PRINT
PRINT "EXAMPLE: 7035 WOULD READ XSVNXZROXTREXFIVX  IN PLAINTEXT BEFORE ENCRYPTION"
PRINT "AND AFTER DECRYPTION."
PRINT "__________________________________________________________________________"
PRINT #1, "TO ENCRYPT DIGITS, USE THE FOLLOWING CODES WITH THE DIGITS SEPARATED BY X."
PRINT #1, "1 WUN  2 TWO  3 TRE  4 FOR  5 FIV  6 SIX  7 SVN  8 EGT  9 NIN  0 ZRO "
PRINT #1,
PRINT #1, "EXAMPLE: 7035 WOULD READ XSVNXZROXTREXFIVX  IN PLAINTEXT BEFORE ENCRYPTION"
PRINT #1, "AND AFTER DECRYPTION."
PRINT #1, "__________________________________________________________________________"

SLEEP 2

RETURN

chanlist:
RANDOMIZE (TIMER / 3)

PRINT "RADIO CHANNELS"                   'choose radio channels for net
PRINT #1, "RADIO CHANNELS"               'CB channels used as example
PRINT "PRIMARY "; (INT(RND * 40) + 1)         'for regular HF, a frequency
PRINT #1, "PRIMARY "; (INT(RND * 40) + 1)     'list file with random selection
PRINT "SECONDARY "; (INT(RND * 40) + 1)      'could be used (see the password
PRINT #1, "SECONDARY "; (INT(RND * 40) + 1)  ' selection code in the PW: sub.
PRINT "BACKUPS "; (INT(RND * 40) + 1); " "; (INT(RND * 40) + 1); " "; (INT(RND * 40) + 1)
PRINT #1, "BACKUPS "; (INT(RND * 40) + 1); " "; (INT(RND * 40) + 1); " "; (INT(RND * 40) + 1)

PRINT "SWITCH TO USB OR LSB PER INSTRUCTIONS FROM NCS"
PRINT #1, "SWITCH TO USB OR LSB PER INSTRUCTIONS FROM NCS"

PRINT "__________________________________________________________________________"

PRINT #1, "__________________________________________________________________________"
SLEEP 5
RETURN

FREQS:  'FOR THE FREQUENCY LISTS, PLEASE SELECT ONLY ONE (HF, CB, OR VUHF)
        'OPTION IN CEOI.CFG

OPEN "freqlow.txt" FOR INPUT AS #6    'LIST OF NIGHT FREQS
OPEN "freqhi.txt" FOR INPUT AS #5     'LIST OF DAY FREQS
PRINT "NET FREQUENCIES     DAY     NIGHT"
PRINT #1, "NET FREQUENCIES     DAY     NIGHT"



PRINT "PRIMARY            ";
PRINT #1, "PRIMARY            ";

GOSUB FREQPAIR
PRINT "SECONDARY          ";
PRINT #1, "SECONDARY          ";

GOSUB FREQPAIR
PRINT "ALTERNATE 1        ";
PRINT #1, "ALTERNATE 1        ";

GOSUB FREQPAIR
PRINT "ALTERNATE 2        ";
PRINT #1, "ALTERNATE 2        ";

GOSUB FREQPAIR
PRINT "ALTERNATE 3        ";
PRINT #1, "ALTERNATE 3        ";

GOSUB FREQPAIR
PRINT "ALTERNATE 4        ";
PRINT #1, "ALTERNATE 4        ";

GOSUB FREQPAIR
PRINT "ALTERNATE 5        ";
PRINT #1, "ALTERNATE 5        ";

GOSUB FREQPAIR

CLOSE #5
CLOSE #6
PRINT "________________________________________________________________________________"
PRINT #1, "________________________________________________________________________________"

RETURN

FREQPAIR:
RANDOMIZE (TIMER / 3)
l = INT(RND * LFLEN) + 1
h = INT(RND * HFLEN) + 1

FOR FRH = 1 TO h
INPUT #5, HF$
NEXT FRH
PRINT HF$; "    ";
PRINT #1, HF$; "    ";
SLEEP 2
RANDOMIZE (TIMER / 3)
FOR FRL = 1 TO l
INPUT #6, LF$
NEXT FRL
PRINT LF$
PRINT #1, LF$

SEEK #5, 1
SEEK #6, 1

SLEEP 2
RETURN

CONFIG:
OPEN "CEOI.CFG" FOR INPUT AS #2
SEEK #2, 1
INPUT #2, DAYS$: DAYS = VAL(DAYS$)
INPUT #2, PWLEN$: PWLEN = VAL(PWLEN$)
INPUT #2, LFLEN$: LFLEN = VAL(LFLEN$)
INPUT #2, HFLEN$: HFLEN = VAL(HFLEN$)
INPUT #2, HFY$: HFY = VAL(HFY$)    'USE HF FREQS FOR NET
                                   'SELECT ONLY ONE (HF,CB. OR VUHF)
                                   'IN CONFIG FILE
INPUT #2, CBY$: CBY = VAL(CBY$)    'USE CB CHANNELS FOR NET FREQS
INPUT #2, NUMENCY$: NUMENCY = VAL(NUMENCY$)  'INCLUDE TRAINING INFO
                                             'ABOUT ENCRYPTING NUMBERS
INPUT #2, NUMCODEY$: NUMCODEY = VAL(NUMCODEY$) 'INCLUDE NUMBER CODE
INPUT #2, VUHFY$: VUHFY = VAL(VUHFY$)      'USE VHF/UHF NET FREQS
INPUT #2, VHFLEN$: VHFLEN = VAL(VHFLEN$)   'NUMBER OF ENTRIES IN V-UHF.TXT
INPUT #2, ORG$      'NAME OF ORGANIZATION


RETURN

VUHF:
OPEN "V-UHF.txt" FOR INPUT AS #7    'LIST OF VHF/UHF FREQS
PRINT "NET FREQUENCIES VHF/UHF"
PRINT #1, "NET FREQUENCIES VHF/UHF"


PRINT "PRIMARY            ";
PRINT #1, "PRIMARY            ";
GOSUB MHZ
PRINT "SECONDARY          ";
PRINT #1, "SECONDARY          ";
GOSUB MHZ
PRINT "ALTERNATE 1        ";
PRINT #1, "ALTERNATE 1        ";
GOSUB MHZ
PRINT "ALTERNATE 2        ";
PRINT #1, "ALTERNATE 2        ";
GOSUB MHZ
PRINT "ALTERNATE 3        ";
PRINT #1, "ALTERNATE 3        ";
GOSUB MHZ
PRINT "ALTERNATE 4        ";
PRINT #1, "ALTERNATE 4        ";
GOSUB MHZ
PRINT "ALTERNATE 5        ";
PRINT #1, "ALTERNATE 5        ";
GOSUB MHZ


CLOSE #7
PRINT "________________________________________________________________________________"
PRINT #1, "________________________________________________________________________________"

SLEEP 5

RETURN

MHZ:
RANDOMIZE TIMER
l = INT(RND * VHFLEN) + 1
h = INT(RND * VHFLEN) + 1

FOR FRQ = 1 TO h
INPUT #7, VHF$
NEXT FRQ
PRINT VHF$; "    "
PRINT #1, VHF$; "    "

SEEK #7, 1

SLEEP 1
RETURN



trapkey:
CLOSE #1
END

