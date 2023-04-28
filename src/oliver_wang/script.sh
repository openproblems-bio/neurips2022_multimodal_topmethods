#/bin/bash

res=/opt

## VIASH START

## VIASH END

repo="$res/wang_openproblems"

echo "Copying data to output"
mkdir "input"
cp -r "$par_input/open-problems-multimodal" "/input"
cp -r "$par_input/open-problems-raw-counts" "/input"

echo "preprocessing data"
cd "$repo/data_preprocessing/"
papermill "cite.ipynb"
papermill "multi.ipynb"


ls= ls
echo "$ls"