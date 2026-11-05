#!/bin/bash

all_pass=1

for n in 1 2 3 4; do
    dir="Testcase$n"
    out="${dir}Diff"

    ok=1
    has_diff=0

    for first in "$dir"/*.1.txt; do
        [ -f "$first" ] || continue

        second="${first%.1.txt}.2.txt"
        name="${first##*/}"
        name="${name%.1.txt}"
        output="$out/${name}Diff.txt"

        if cmp -s "$first" "$second"; then
            if [ -f "$output" ]; then
                ok=0
            fi
        else
            has_diff=1

            if [ ! -f "$output" ]; then
                ok=0
            elif ! cmp -s \
                <(diff -u "$first" "$second" | tail -n +3) \
                <(tail -n +3 "$output"); then
                ok=0
            fi
        fi
    done

    if [ "$has_diff" -eq 1 ]; then
        if [ ! -d "$out" ]; then
            ok=0
        fi
    else
        if [ -d "$out" ]; then
            ok=0
        fi
    fi

    if [ "$ok" -eq 1 ]; then
        echo "Testcase$n: PASS"
    else
        echo "Testcase$n: FAIL"
        all_pass=0
    fi
done

if [ "$all_pass" -eq 1 ]; then
    exit 0
else
    exit 1
fi