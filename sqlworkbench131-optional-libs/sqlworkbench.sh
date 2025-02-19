#!/usr/bin/env bash
# Start SQL Workbench/J in GUI mode

function readlink() {
  case `uname -s` in
    Linux*)
      command readlink -e "$@"
      ;;
    *)
      command readlink "$@"
      ;;
  esac
}

SCRIPT_PATH=$(dirname -- "$(readlink "${BASH_SOURCE[0]}")")
JAVACMD="java"

if [ -x "$SCRIPT_PATH/jre/bin/java" ]
then
  JAVACMD="$SCRIPT_PATH/jre/bin/java"
elif [ -x "$SCRIPT_PATH/jre/Contents/Home/bin/java" ]
then
  # MacOS
  JAVACMD="$SCRIPT_PATH/jre/Contents/Home/bin/java"
elif [ -x "$WORKBENCH_JDK/bin/java" ] && [ -n "${WORKBENCH_JDK}" ]
then
  JAVACMD="$WORKBENCH_JDK/bin/java"
elif [ -x "$JAVA_HOME/jre/bin/java" ] && [ -n "${JAVA_HOME}" ]
then
  JAVACMD="$JAVA_HOME/jre/bin/java"
elif [ -x "$JAVA_HOME/bin/java" ] && [ -n "${JAVA_HOME}" ]
then
  JAVACMD="$JAVA_HOME/bin/java"
fi

cp="$SCRIPT_PATH/sqlworkbench.jar"
cp="$cp:$SCRIPT_PATH/ext/*"

os=`uname -s`

OPTS="--add-opens java.desktop/com.sun.java.swing.plaf.motif=ALL-UNNAMED --add-opens=java.desktop/com.sun.java.swing.plaf.gtk=ALL-UNNAMED"
if [ "$os" = Darwin ];
then
# this would result in a warning on non MacOS systems
  OPTS="$OPTS --add-opens java.desktop/com.apple.laf=ALL-UNNAMED"
fi

# When running in batch mode on a system with no X11 installed, the option
#   OPTS="$OPTS -Djava.awt.headless=true"
# might be needed for some combinations of OS and JDK
#
# For MacOS,
#   OPTS="$OPTS -Dapple.awt.brushMetalLook=true"
# might be needed to get a more "native" look and feel
#
# If font rendering is bad, the following option might fix that:
#   OPTS="$OPTS -Dawt.useSystemAAFontSettings=on"
#
exec "$JAVACMD"  $OPTS \
                -Dvisualvm.display.name=SQLWorkbench/J -cp "$cp" workbench.WbStarter "$@"
