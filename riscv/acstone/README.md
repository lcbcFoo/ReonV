ACStone
============

* For adding another architecture, follow riscv.mk convention and create the .mk file with $(TESTS) rule.

* Execute `make` to see the options

* Edit and source the file `acstone.env.sh`
```bash
source acstone.env.sh
```

* Build the pieces of code
```bash
make build
```

* Run the simulator using gdb commands
```bash
make run
```

* Check the correctness using the x86 output
```bash
make check
```
* If you are using acsim with -scsv flag, run the following to generate consolidated statistics
```bash
make consolidate
```


Pieces of code
---------------------

```
000.main	Simple main function that returns 0

011.const	Uses signed char
012.const   Uses unsigned char
013.const	Uses signed short int
014.const	Uses unsigned short int
015.const	Uses int
016.const	Uses unsigned int
017.const	Uses signed long long int 
018.const	Uses unsigned long long int

021.cast	Uses cast signed char to signed short int
022.cast	Uses cast signed char to signed int
023.cast	Uses cast signed char to signed long long int
024.cast	Uses cast signed short int to signed int
025.cast	Uses cast signed short int to signed long long int
026.cast	Uses cast signed int to signed long long int
027.cast	Uses some unsigned casts

031.add		Uses signed and unsigned char adds
032.add		Uses signed and unsigned short int adds
033.add		Uses signed and unsigned int adds
034.add		Uses signed and unsigned long long int adds

041.sub		Uses signed and unsigned char subs
042.sub		Uses signed and unsigned short int subs
043.sub		Uses signed and unsigned int subs
044.sub		Uses signed and unsigned long long int adds

051.mul		Uses signed char multiplication
052.mul		Uses unsigned char multiplication
053.mul		Uses signed short int multiplication
054.mul		Uses unsigned short int multiplication
055.mul		Uses signed int multiplication
056.mul		Uses unsigned int multiplication
057.mul		Uses various signed multiplication
058.mul		Uses various unsigned multiplication

061.div		Uses signed char division
062.div		Uses unsigned char division
063.div		Uses signed short int division
064.div		Uses unsigned short int division
065.div		Uses signed int division
066.div		Uses unsigned int division
067.div		Uses signed long long int division
068.div		Uses unsigned long long int division

071.bool	Uses char boolean operators
072.bool	Uses short int boolean operators
073.bool	Uses int boolean operators
074.bool	Uses long long int boolean operators
075.bool	Uses various boolean operators

081.shift	Uses signed and unsigned char shifts
082.shift	Uses signed and unsigned short int shifts
083.shift	Uses signed and unsigned int shifts
084.shift	Uses signed and unsigned long long int shifts
085.shift	Uses shifts and some logic operators

111.if		Uses signed char ifs
112.if		Uses unsigned char ifs
113.if		Uses signed short int ifs
114.if		Uses unsigned short int ifs
115.if		Uses signed int ifs
116.if		Uses unsigned int ifs
117.if		Uses signed long long int ifs
118.if		Uses unsigned long long int ifs
119.if		Uses various ifs

121.loop	Uses while loops
122.loop	Uses for loops
123.loop	Uses implemented unsigned multiplication
124.loop	Uses implemented signed multiplication (Booth)
125.loop	Uses implemented simple strlen loop
126.loop	Uses implemented simple fatorial loop

131.call	Uses calls functions arg int, ret int
132.call	Uses indirect calls functions
133.call	Uses recursive fatorial
134.call	Uses recursive Fibonacci function

141.array	Uses size three dot products
142.array	Uses a kind of square matrix multiplication
143.array	Uses signed and unsigned char Bubble Sort
144.array	Uses signed and unsigned short int Bubble Sort
145.array	Uses signed and unsigned int Bubble Sort
146.array	Uses signed and unsigned long long int Bubble Sort
```
