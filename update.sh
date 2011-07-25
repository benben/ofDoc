#!/bin/bash
DOC_DIR="/home/ofxfenster/ofDoc/"
#relative to PWD
OF_DIR="openFrameworks"
CLONE_URL="http://github.com/openframeworks/openFrameworks.git"
DOXY_BIN="/home/ofxfenster/doxygen-1.7.4/bin/doxygen"

if [ -d $DOC_DIR$OF_DIR ]
then
    cd $DOC_DIR$OF_DIR
    git pull origin master
    cd $DOC_DIR
    $DOXY_BIN $DOC_DIR'Doxyfile'
else
    git clone $CLONE_URL $PWD$OF_DIR
    $DOXY_BIN $DOC_DIR'Doxyfile'
fi

PWD=$DOC_DIR
LINE=`grep -n "<div class=\"contents\">" html/index.html | cut -f1 -d:`
LINE=`expr $LINE + 1`
DATE_STR="last created at `date -u`<br /><h2>Download this documentation as <a href="ofDoc.zip">ZIP</a> 
here.</h2>"
nawk '{sub(/^<div class="contents">/,dt)}1' dt="&$DATE_STR" html/index.html > html/index.html_temp
mv html/index.html_temp html/index.html
zip -r ofDoc.zip html/
