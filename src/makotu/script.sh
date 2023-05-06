#/bin/bash

res=/opt


## VIASH START

## VIASH END

repo="$res/makotu_openproblems"

echo "copying data to working folder"
cp -r "$par_input" "$repo/input/raw"
cp -r "$meta_resources_dir/resources" "$repo/input/raw"

echo "Preprocess data"
cd "$repo/code/1.raw_to_preprocess/cite/"
python3 "make-cite-sparse-matrix.py"
python3 "make-clusters.py"

cd "$repo/code/1.raw_to_preprocess/multi/"
python3 "make-multi-sparse-matrix.py"

cd "$repo/code/1.raw_to_preprocess/cite/"
python3 "make-cite-sparse-matrix.py"

cd "$repo/code/2.preprocess_to_feature/cite/"
python3 "make-base-feature.py"
python3 "make-base-word2vec.py"
python3 "make-features.py"

cd "$repo/code/2.preprocess_to_feature/multi/"
python3 "multi-allsample-basefeature.py"
python3 "multi-allsample-target.py"

echo "Train cite"
cd "$repo/code/4.model/train/cite/"
python3 "cite-mlp.py"
python3 "cite-catboost.py"

echo "train multi"
cd "$repo/code/4.model/train/multi/"
python3 "multi-mlp.py"
python3 "multi-catboost.py"

echo "Make prediction"
python3 "$repo/code/4.model/pred/prediction.py"