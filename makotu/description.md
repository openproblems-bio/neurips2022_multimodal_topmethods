
# 3rd place solution

You can find the code on github
[here](https://github.com/makotu1208/open-problems-multimodal-3rd-solution).

## Multiome

### Preprocess

- use okapi bm25 instead of tfidf
- dimensionality reduction：use lsi(implemented in muon) instead of svd
  <https://muon.readthedocs.io/en/latest/api/generated/muon.atac.tl.lsi.html>
  muon.atac.tl.lsi(rawdata(with okapi preprocessing), n_comps=64)

### feature

Basically, pre-processing contributed greatly to the accuracy, but the
following features also contributed somewhat to the accuracy.

- binary feature transformed 0/1 binary and reduced 16 dimensions(svd)
  as features
- w2v vector feature For each cell, the top100 with the highest
  expression levels were lined up and vectorized by gensim to get
  feature vector(16dims) for each gene.
  <https://radimrehurek.com/gensim/models/word2vec.html> Ex. CellA:
  geneB → geneE → geneF → … CellB: geneA → geneC → geneM → … top100
  genes vector average in each cell used as features.
- leiden cluster mean feature I made Clusters using muon’s leiden
  clustering(23 cluster).
  <https://muon.readthedocs.io/en/latest/api/generated/muon.tl.leiden.html#muon.tl.leiden>
  After taking the average of the features for each cluster(23 cluster ×
  228942 feat), they were reduced to 16 dimensions by svd and used as
  features(23 cluster × 16feat). After that, join on clusters.
- connectivy matrix feature Since muon’s leiden clustering generates an
  adjacency matrix between cells as a byproduct, I also use it
  16-dimensional with svd as a feature.

### Model

- mlp Simple 4-layer mlp; no major differences from mlp in public
  notebooks target has been reduced to 128 dimensions with svd. use rmse
  loss
- catboost
  - target has been reduced to 128 dimensions with svd.

### Ensemble

I made a model of nearly 20 mlp and 3 catboosts with various feature
combinations. and cv-based weighted averaging.

## CITEseq

### Preprocess

The same process as in the organizer was applied.

use `sc.pp.normalize_per_cell` and `sc.pp.log1p` (excluding the gene
that are significantly related to the target protein)

### Feature

I’ve made a lot of features, and here are some of them that have worked
to some degree.

- leiden cluster feature I made Clusters using muon’s leiden clustering.
  Average of features per cluster and reduce dimensions with svd.
  (excluding Important genes. It were not used svd, and use raw count’s
  average for each cluster was used as features as is.)
- w2v vector feature Same as multiome.

### Model

- mlp
  - Simple 4-layer mlp; no major differences from mlp in public
    notebooks
  - Using correlation_loss. No different from public notebook.
- catboost

### Ensemble

I made a model of nearly 20 mlp and 2 catboosts with various feature
combinations. and cv-based weighted averaging.

## Validation

It goes without saying that one of the key elements of this competition
is validation. I tried binary classification to classify test data used
in PB and others. (At this point, the classification accuracy was so
high. So I think it is dangerous to trust LB.) The 10% of the training
data that is close to the PB, is used as validation data. This method
seemed to work well, the submit with my highest cv was highest pb score.
