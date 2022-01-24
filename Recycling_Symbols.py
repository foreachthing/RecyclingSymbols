# required: pip install git+https://github.com/SolidCode/SolidPython.git
import ntpath
from os import path, remove
from solid import *
from solid.utils import *
from subprocess import run

recycling_codes = []

# https://en.wikipedia.org/wiki/Recycling_codes#List_of_Chinese_codes_for_plastics_products
# List is stored in codelist.txt
# plastic code, plastic description, symbol code
# 1           , PLA                , 1          
with open(ntpath.join(
    f'{path.dirname(path.abspath(__file__))}', 'codelist.txt'), 'r') as filehandle:
    for line in filehandle:
        tmplst = [line.split(',')[0].strip(), 
                  line.split(',')[1].strip(), 
                  line.split(',')[2].strip()]

        # add item to the list
        recycling_codes.append(tmplst)

scadfile = import_scad(ntpath.join(
    f'{path.dirname(path.abspath(__file__))}', 
    'Recycling_Symbols.scad'))

symbol_code = 0

for plastics in recycling_codes:
    numerical_code = str(plastics[0])
    plastic_symbol = str(plastics[1]).upper()
    symbol_code = int(plastics[2])

    code_name = numerical_code + '-' + plastic_symbol
    print("### ## # Creating: " + code_name)
    
    rec_sym_out_file = ntpath.join(
        f'{path.dirname(path.abspath(__file__))}', 
        code_name + '_out_file.scad')
    rec_sym_out_stl_file = ntpath.join(
        f'{path.dirname(path.abspath(__file__))}', 
        code_name + '.stl')
    
    font_size=8
    if len(numerical_code) >= 3:
        font_size = 5
    elif len(numerical_code) >= 2:
        font_size = 6
    elif len(numerical_code) >= 1:
        font_size = 7        

    b = scadfile.Recycling_Symbol(
        Symbol=symbol_code,
        Numerical_Code=numerical_code,
        Plastic_Symbol=plastic_symbol,
        Font_Size=font_size,
        Length=30, Width=30,
        Thickness=2,
        Arrow_Width=2.5,
        Arrow_Head_Width=5,
        Arrow_Head_Length=5)

    scad_render_to_file(b, rec_sym_out_file)

    # h:\apps\PortableApps\OpenSCAD\openscad.com g:\dev\RecyclingSymbols\Recycling_Symbols.scad --export-format "binstl" -o file.stl
    run(["h:\\apps\\PortableApps\\OpenSCAD\\openscad.com",
         rec_sym_out_file,
         "--export-format","binstl",
         "-o",
         rec_sym_out_stl_file])

    # remove temp scad file agin.
    if path.exists(rec_sym_out_file):
        remove(rec_sym_out_file)

    