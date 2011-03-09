" taken from Caio Romao
" Allows use of `gf` in python files
" .vim/ftplugin/python.vim

set fdm=indent
python << EOF
import os
import sys
import vim
sst_path = os.path.expanduser('~/allwork/upp/')
sst_paths = [
    os.path.join(sst_path, 'sst/wui'),
    os.path.join(sst_path, 'sst/overlay/ALL/opt/ibm/sst/lib'),
    os.path.join(sst_path, 'common/wui'),
]
for p in sys.path + sst_paths:
    # Add each directory in sys.path, if it exists.
    if os.path.isdir(p):
        # Command 'set' needs backslash before each space.
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
