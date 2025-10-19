{writeScriptBin, inotify-tools, ...}:

writeScriptBin "auto-upload-scans" ''
#!/bin/sh
WATCH_DIR="/home/wcka/Dokumente/Scans/"
REMOTE_USER="paperless"
REMOTE_HOST="192.168.0.4"
REMOTE_DIR="/home/paperless/paperless-ngx/consume"

${inotify-tools}/bin/inotifywait -m -e create --format "%f" "$WATCH_DIR" | while read NEWFILE
do
    FILE="$WATCH_DIR/$NEWFILE"
    echo Found new file: $FILE
    # Wait until file is done being written
    sleep 10
    # Upload via scp (or rsync)
    if [[ "''${FILE}" == *.pdf ]];
    then scp "$FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"
    else echo "File was not a pdf"
    fi
done
''
