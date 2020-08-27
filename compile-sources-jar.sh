#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 sources.jar [classpath]"
    echo
    exit 1
fi

OUT_JAR=`basename $1-compiled.jar`

rm -rf $OUT_JAR
rm -rf src
rm -rf classes

mkdir src
mkdir classes

if [ -n "$2" ]; then
    CLASSPATH="-cp $2"
fi

unzip -d src $1
if [ $? -ne 0 ]; then
    echo "Unzip failed"
    exit 1
fi

find src -name *.java | xargs javac -d classes $CLASSPATH
if [ $? -ne 0 ]; then
    echo "Java compilation failed"
    exit 1
fi

jar cf $OUT_JAR -C classes .

if [ $? -ne 0 ]; then
    echo "Jar creation failed"
    exit 1
fi

echo
echo "Compiled and built $OUT_JAR"
