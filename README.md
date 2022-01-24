# RecyclingSymbols

Create Recycling Symbols for pretty much every plastic on Wikipedia.
These symbols (.stl) can then be imported to any slicer like PrusaSlicer, Cura and so on.

## Usage in PrusaSlicer
1. Add part
2. add "negative volume" modifier and choose your symbol
3. mirror if necessery, place and/or scale symbol

![PLA in PrusaSlicer](https://user-images.githubusercontent.com/10420187/150867363-8e9251c6-2c51-4817-9e8b-ec53f0d764ea.png)



Feel free to PR more symbols.

## RUN Script to Create Symbols
You'll need [Python](https://www.python.org/), [SolidPython](https://github.com/SolidCode/SolidPython) and [OpenSCAD](https://openscad.org/). See notes in `Recycling_Symbols.py`.
Then you just run `Recycling_Symbols.py` and wait for the symbols to be created.

It will create a STL file for each line in `codelist.txt`. It will create 140 STL files, at time of writing this.

## Font
I've tested the script with "Helvetica Rounded", since this font prints really well.
If you want to use your font, just copy the font file to `c:\users\<user>\.fonts` (create folder if necessary).
Download Font: https://www.maisfontes.com/helvetica-rounded-lt-std-bold.font


