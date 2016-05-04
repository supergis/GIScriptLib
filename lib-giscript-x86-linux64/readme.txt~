GIScript Runtime library.2016-03.
For Ubuntu(64) 14.04/15.10.

Setup as follow step:

1: run setup-libpath.sh, link the lib to python site-packages/PyUGC.
2: run set-up-giscript.sh, rename the conflicted *.so of system libraries.
3: add search path of GIScript *.so

echo "Config GIScript runtime library..."
export GISCRIPT_HOME=/home/supermap/GISpark/lib-giscript-x86-linux64
export LD_LIBRARY_PATH=$GISCRIPT_HOME/bin:$GISCRIPT_HOME/lib:$LD_LIBRARY_PATH
echo "LD_LIBRARY_PATH: "$LD_LIBRARY_PATH

You can include this setting in ~/.bashrc or in startup.sh.


