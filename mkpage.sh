#!/bin/sh

template="template.html5"
tmpdir="/tmp/mkpage-$RANDOM"

insert_html() {
    # input: input filename
    cat "$template" | awk 'BEGIN{output=1} /\$body\$/{output=0} output{print}'
    cat $@ | awk 'BEGIN{output=0} /<\/body>/{output=0} output{print} /<body.*>/{output=1}'
    cat "$template" | awk 'BEGIN{output=0} output{print} /\$body\$/{output=1}'
}

if test "$1" = "-f"; then
    echo "doing fast run ..."
else
    echo "doing complete run ..."
    rm -r out/*
    cp -r data/* out/
fi

for x in $(find src/); do
    to="$(echo $x | sed s/^src/out/)"
    if test -d "$x"; then
        mkdir "$to" 2>/dev/null
    elif test -f "$x"; then
        if test "$(echo $to | tail -c 5)" = "html"; then
            insert_html "$x" > "$to"
        else
            if test "$(echo $to | tail -c 4)" = "doc"; then
                test -d "$tmpdir" || mkdir "$tmpdir"
                lowriter --convert-to odt --outdir "$tmpdir" "$x"
                x="$(echo $x | sed "s,^src,$tmpdir,g" | sed 's/doc$/odt/g')"
            fi
            to="$(echo $to | sed 's/\..*/\.html/g')"
            if ! test "$(echo $to | tail -c 5)" = "html"; then
                to="$to"".html"
            fi
            pandoc -t html5 --template "$template" \
                "$x" -o "$to"
        fi
    fi
done

test -d "$tmpdir" && rm -r "$tmpdir"
