CEOI5 is for creating books used for managing emergency radio networks. Daily frequency and callsign assignments, with authentication tables.
HF, CB, and VHF/UHF frequency lists are configurable options. The config file is a self explanatory text file.
CEOI5 was written in Qbasic 4.5.  CEOI5d.zip includes an MSDOS executable, and CEOI5w.zip includes a windows executable compiled by QB64.
Place all files in a directory with user priveleges.
The config file is a text file, which is self explanatory, and notes are included in the source code.  Running the program reads from the included
support files, and sends output to a file named (month).txt, where (month) is the abbreviation of the month (i.e. JAN, FEB, MAR, etc...)
Configurable options are: HF, CB, or VHF/UHF frequency lists, length of the support files, number of days printed to output file, and encryption options.
The included support files contain lists of frequencies for HF, CB, or VHF/UHF operation of the net.  There are 2 support files for HF frequencies, 
one list is for day operation, and the other for night operation. The included VHF/UHF support file currently contains the frequencies for the 22 FRS channels.
For CB operation, there is no support file, as the subroutine chooses CB channel numbers and prints those. There is a dictionary file to provide challenge/password
words for physical site access. 
All frequencies, and challenge/passwords are randomly chosen, and the possibility of duplications in any day's listings (the primary frequency might also show up in 
one of the alternate slots). The chance of duplicates is inversely proportional to the number of unique entries in the support file.

