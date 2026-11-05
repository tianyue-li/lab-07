for n in 1 2 3 4; do
    dir="Testcase$n"
    out="${dir}Diff"
    rm -rf -- "$out"
        for first in "$dir"/*.1.txt;do
        [ -f "$first" ] || continue
        second="${first%.1.txt}.2.txt"
        name="${first##*/}"
        name="${name%.1.txt}"
        if cmp -s "$first" "$second"; then
        continue 
        fi
        mkdir -p "$out"
        diff -u "$first" "$second" > "$out/${name}Diff.txt"
    done
done 