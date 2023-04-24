
Download resources

```bash
res_dir=src/shuji_suzuki/resources
mkdir -p "$res_dir"
wget https://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/tsv/hgnc_complete_set.txt -O "$res_dir/hgnc_complete_set.txt"
wget https://reactome.org/download/current/ReactomePathways.gmt.zip -O "$res_dir/ReactomePathways.gmt.zip" &&
  unzip "$res_dir/ReactomePathways.gmt.zip" -d "$res_dir" && 
  rm "$res_dir/ReactomePathways.gmt.zip"
```

Clone repo

```bash
echo shu65_openproblems > src/shuji_suzuki/.gitignore
git clone https://github.com/shu65/open-problems-multimodal.git src/shuji_suzuki/shu65_openproblems
```