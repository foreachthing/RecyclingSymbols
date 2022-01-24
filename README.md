# RecyclingSymbols

Create Recycling Symbols for pretty much every plastic on Wikipedia.
So far only the Recycling symbol works.

Feel free to PR more symbols.

## RUN
You'll need [Python](https://www.python.org/), [SolidPython](https://github.com/SolidCode/SolidPython) and [OpenSCAD](https://openscad.org/). See notes in `Recycling_Symbols.py`.
Then you just run `Recycling_Symbols.py` and wait for the symbols to be created.

It will create a STL file for each line in `codelist.txt`. It will create 140 STL files, at time of writing this.

## Font
I've tested the script with "Helvetica Rounded", since this font prints really well.
If you want to use your font, just copy the font file to `c:\users\<user>\.fonts` (create folder if necessary).
Download Font: https://www.maisfontes.com/helvetica-rounded-lt-std-bold.font


