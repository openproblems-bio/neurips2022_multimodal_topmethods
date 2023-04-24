#/bin/bash

shu65_openproblems=/opt/shu65_openproblems

## VIASH START
meta_resources_dir=src/shuji_suzuki
shu65_openproblems=src/shuji_suzuki/shu65_openproblems
## VIASH END

python3 script/make_compressed_dataset.py --data_dir "$par_input"
python3 script/make_additional_files.py --data_dir "$par_input"
python3 script/make_cite_input_mask.py --data_dir "$par_input" \
  --hgnc_complete_set_path "$meta_resources_dir/hgnc_complete_set.txt" \
  --reactome_pathways_path "$meta_resources_dir/ReactomePathways.gmt"