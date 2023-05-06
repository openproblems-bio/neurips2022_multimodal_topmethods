
# 1st Place Solution Summary

You can find the code on github
[here](https://github.com/shu65/open-problems-multimodal).

## Multiome

### Model Overview

![](images/multiome_model_overview.png)

### Input Processing

![](images/multiome_input_preprocessing.png)

### Target Preprocessing

![](images/multiome_target_preprocessing.png)

tSVD-based imputation method:

1.  Perform dimensionality reduction on the data with tSVD
2.  and then, Transform the data back to the original space
3.  copy the value of the 0 part of the original data from the
    transformed values.

### Model

![](images/multiome_model.png)

### Output Postprocessing and Loss

![](images/multiome_postprecessing_1.png)

![](images/multiome_postprocessing_2.png)

In the inference phase, the model outputs the average of the five
predicted target data.

## CITEseq

### Model Overview

![](images/cite_model_overview.png)

### Input Preprocessing

![](images/cite_input_preprocessing.png)

In selecting important genes in CITEseq, the correlation coefficient is
calculated for each batch and select only genes with high correlation in
many batches.

Genes were selected from those related to the target proteins and
pathway.

I use [Reactome](https://reactome.org/) as pathway database.

### Target Preprocessing

![](images/cite_target_preprocessing.png)

### Model

![](images/cite_model.png)

### Output Postprocessing and Loss

![](images/cite_output_postprocessing.png)

In the inference phase, the model outputs the average of the five
predicted target data.

## Local evaluation

I used two evaluation schemes.

1.  Evaluation with cross validation:
    - 5-fold cross validation grouped by donor and day
2.  Evaluation for hyperparameter optimization with Optuna:
    - Training data set is divided into training and validation data
      sets. ( Training data set: 80%, validation data set: 20%. )

## Ensemble

I used the weighted average of predictions of the following models.

1.  Models trained with changing the seed
2.  Models fine-tuned on only some batches
    - Batch combination pattern examples: males only, female only, Day
      4, 7 only, etc.
    - Use a model trained on the full training data set as a
      pre-training model

## Development setup

Download resources

``` bash
res_dir=src/shuji_suzuki/resources
mkdir -p "$res_dir"
wget https://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/tsv/hgnc_complete_set.txt -O "$res_dir/hgnc_complete_set.txt"
wget https://reactome.org/download/current/ReactomePathways.gmt.zip -O "$res_dir/ReactomePathways.gmt.zip" &&
  unzip "$res_dir/ReactomePathways.gmt.zip" -d "$res_dir" && 
  rm "$res_dir/ReactomePathways.gmt.zip"
```

Clone repo

``` bash
echo shu65_openproblems > src/shuji_suzuki/.gitignore
git clone https://github.com/shu65/open-problems-multimodal.git src/shuji_suzuki/shu65_openproblems
```

## Executing the method

Run method

``` bash
viash run src/shuji_suzuki/config.vsh.yaml -- \
  --input sample_data \
  --output output \
  ---memory 100GB \
  ---cpus 30
```
