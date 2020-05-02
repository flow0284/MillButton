#!/bin/bash
function get-translations(){
    curl -H "X-Api-Token: 48953334-3b8e-4f2c-92d5-801d83282a7d" -X GET -H \
    "Content-type: application/json" \
    >temp.lua \
    "ttps://wow.curseforge.com/api/projects/31873/localization/export?lang=$1"

    sed -e '/--.*$/{r temp.lua' -e 'd}' MillButton/Locales/$1.lua >temp2.lua
    awk '{gsub("\\\\\\\\n", "\\n", $0); print}' temp2.lua >temp.lua
    mv temp.lua MillButton/Locales/$1.lua
    rm temp2.lua
}
get-translations $1
