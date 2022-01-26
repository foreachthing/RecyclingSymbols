# RecyclingSymbols

Create Recycling Symbols for pretty much every plastic on [Wikipedia](https://en.wikipedia.org/wiki/Recycling_codes#List_of_Chinese_codes_for_plastics_products).
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


### Arguments
To get a list of all possible arguments, type `Recycling_Symbols.py -h`.

* `--path-openscad` lets you define your own path to the OpenSCAD.com file.
* `--codelist` lets you define your own file with symbols to be created.
* `--symbol` lets you define just one single symbol (list won't be used). Example: `--symbol 92 PLA 1` will create the symbol for PLA, number 99 within the recycling arrows.
* `-m` if argument is passed, the symbols will be mirrored (so you won't have to do that manually in your slicer software).

```
--path-openscad PATH_OPENSCAD
                        Path to OpenSCAD.com (Default: h:\apps\PortableApps\OpenSCAD\openscad.com)
  --codelist CODELIST   File with all the codes listed. (Default: codelist.txt)
  --symbol code description symbol
                        Outputs single symbol, if defined. Mirrored if -m is passed. Code: plastic code (92 for PLA).
                        Description: PLA. Symbol: 1
  -m                    Outputs the symbols mirrored if argument is passed. (Default: False)
```


## Font
I've tested the script with "Helvetica Rounded", since this font prints really well.
If you want to use your font, just copy the font file to `c:\users\<user>\.fonts` (create folder if necessary).
Download Font: https://www.maisfontes.com/helvetica-rounded-lt-std-bold.font

Any other installed font can be used.
In Windows, copy your font files to `c:\Users\<user>\.fonts\` (create folder if necessary) and restart OpenSCAD. To get a list of installed fonts in OpenSCAD, go to Help -> Font list.
