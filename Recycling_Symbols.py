"""
    required: pip install git+https://github.com/SolidCode/SolidPython.git
"""
import argparse
from os import path, remove
from pathlib import Path
import subprocess
import solid
import solid.utils


class AddSymbolAction(argparse.Action):
    """
        custom action
    """
    def __call__(self, parser, namespace, values, option_string=None):
        for symbol in values:
            namespace.symbol.append(symbol)


def argumentparser():
    """
        ArgumentParser
    """
    parser = argparse.ArgumentParser(
        prog=path.abspath(__file__),
        description='** Creates STL files of plastic codes for 3D-Printing.' \
            'Those can then be imported into your slicer and imprinted '\
            'in your model.',
        allow_abbrev=False,
        epilog='NOTE: '\
            'Best results are with a rounded font.')

    # Edit the default path to fit your needs or provide path argument
    parser.add_argument('--path-openscad', type=str,
    default=Path("h:/apps/PortableApps/OpenSCAD/openscad.com"), \
    help='Path to OpenSCAD.com ' \
        '(Default: %(default)s)')

    parser.add_argument('--codelist', type=str, default="codelist.txt", \
    help='File with all the codes listed. ' \
        '(Default: %(default)s)')

    parser.add_argument('--symbol', nargs=3,
        metavar=('code', 'description', 'symbol'),
        action=AddSymbolAction,
        default=[],
        help='Outputs single symbol, if defined. '\
        'Code: plastic code (92 for PLA). Description: PLA. Symbol: 1')

    parser.add_argument('-m', action='store_true', default=False, \
    help='Outputs the symbols mirrored if argument is passed. '\
        '(Default: %(default)s)')

    parser.add_argument('--font-quality', type=int, default=35, \
    help='Quality (or poly count) for the font. Only rounded fonts '\
        'need high poly count. '\
        '(Default: %(default)s)')

    try:
        args = parser.parse_args()

        # To get all defaults:
        all_defargs = {}
        for key in vars(args):
            all_defargs[key] = parser.get_default(key)

        return [args, all_defargs, parser]

    except IOError as msg:
        parser.error(str(msg))
        return ""

# Parse the arguments
ARGS, ALL_DEFARGS, PARSER = argumentparser()

# new list for recycling codes
RECYCLING_CODES = []

# add single symbol, if argument is passed
if len(ARGS.symbol) == 3:
    RECYCLING_CODES.append(ARGS.symbol)

if len(RECYCLING_CODES) == 0:
    # https://en.wikipedia.org/wiki/Recycling_codes#List_of_Chinese_codes_for_plastics_products
    # List is stored in codelist.txt
    # plastic code, plastic description, symbol code
    # 1           , PLA                , 1
    path_to_codelist = Path(f'{path.dirname(path.abspath(__file__))}', ARGS.codelist)
    if not path.isfile(path_to_codelist):
        print("Using " + ALL_DEFARGS.get('codelist'))
        path_to_codelist = Path(f'{path.dirname(path.abspath(__file__))}',
                                ALL_DEFARGS.get('codelist'))

    # open file and feed into list
    with open(path_to_codelist, 'r', encoding='utf8') as filehandle:
        for line in filehandle:
            tmplst = [line.split(',')[0].strip(),
                    line.split(',')[1].strip(),
                    line.split(',')[2].strip()]

            # add item to the list
            RECYCLING_CODES.append(tmplst)

SCADFILE = solid.import_scad(Path(
    f'{path.dirname(path.abspath(__file__))}', 'Recycling_Symbols.scad'))

SYMBOL_CODE = 0

for plastics in RECYCLING_CODES:
    NUMERICAL_CODE = str(plastics[0])
    PLASTIC_SYMBOL = str(plastics[1]).upper()
    SYMBOL_CODE = int(plastics[2])

    CODE_NAME = NUMERICAL_CODE + '-' + PLASTIC_SYMBOL
    print("### ## # Creating: " + CODE_NAME)

    REC_SYM_OUT_FILE = Path(
        f'{path.dirname(path.abspath(__file__))}',
        CODE_NAME + '_out_file.scad')
    rec_sym_out_stl_file = Path(
        f'{path.dirname(path.abspath(__file__))}',
        CODE_NAME + '.stl')

    FONT_SIZE=8
    if len(NUMERICAL_CODE) >= 3:
        FONT_SIZE = 5
    elif len(NUMERICAL_CODE) >= 2:
        FONT_SIZE = 6
    elif len(NUMERICAL_CODE) >= 1:
        FONT_SIZE = 7

    # Convert bool to int
    # 0 or 1 ==> 0 = not mirrored (false); 1 = mirrored (true)
    if ARGS.m == ALL_DEFARGS.get('m'):
        if ALL_DEFARGS.get('m'):
            EXPORT_X_MIRRORED = 1
        else:
            EXPORT_X_MIRRORED = 0
    else:
        EXPORT_X_MIRRORED = 1

    b = SCADFILE.Recycling_Symbol(
        Symbol=SYMBOL_CODE,
        Numerical_Code=NUMERICAL_CODE,
        Plastic_Symbol=PLASTIC_SYMBOL,
        Font_Size=FONT_SIZE,
        Length=30, Width=30,
        Thickness=2,
        Arrow_Width=2.5,
        Arrow_Head_Width=5,
        Arrow_Head_Length=5,
        x_mirror=EXPORT_X_MIRRORED,
        font_quality=ARGS.font_quality)

    solid.scad_render_to_file(b, REC_SYM_OUT_FILE)

    PATH_TO_OPENSCAD = Path(f'{path.dirname(path.abspath(__file__))}',
                            ARGS.path_openscad)
    if not path.isfile(PATH_TO_OPENSCAD):
        print("Using OpenSCAD from " + ALL_DEFARGS.get('path_openscad'))
        PATH_TO_OPENSCAD = Path(f'{path.dirname(path.abspath(__file__))}',
                                ALL_DEFARGS.get('path_openscad'))

    _ = subprocess.run([PATH_TO_OPENSCAD,
         REC_SYM_OUT_FILE,
         "--export-format","binstl",
         "-o",
         rec_sym_out_stl_file], check=True)

    # remove temp scad file agin.
    if path.exists(REC_SYM_OUT_FILE):
        remove(REC_SYM_OUT_FILE)
