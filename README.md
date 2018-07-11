---
title: "README.Rmd"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
![logo](images/logo1.png)
[![Build Status](https://travis-ci.org/wrightaprilm/treeStartR.svg?branch=master)](https://travis-ci.org/wrightaprilm/treeStartR)
[![codecov](https://codecov.io/gh/wrightaprilm/treeStartR/branch/master/graph/badge.svg)](https://codecov.io/gh/wrightaprilm/treeStartR)


## treeStartR

Phylogenetic trees, and particularly time-scaled phylogenetic trees, are increasingly estimated using complex models of evolution. Finding a starting tree with a computable likelihood to perform a Bayesian MCMC can be a challenge, particularly when when estimation involves taxa, large datasets, many parameters, and missing data.

The purpose of this package is to allow users to efficiently add taxa to a given tree to generate a reasonable starting tree. While adding tips to a tree may be trivial if all tips have the same datatype (i.e., nucleotide sequence data), this can be more challenging for mixed datatype analyses. Additionally, taxa for which only stratiraphic data are available cannot have phylogenetic placements estimated, and must be placed via expert knowledge. 

This package allows users to input a known phylogeny, and add tips to the tree. Tips can either be added via a pop-up prompt, in which users specify the exact node which the tip will subtend, or at random, or by providing a taxon set with which the tip should form a group.

## Installation

Install the development version directly from Github

```{r}
library(devtools)
install_github("wrightaprilm/treeStartR")
```

## Dependencies

treeStartR depends on phytools.

```{r}
library(phytools)
```

## Usage Example

```{r}
library(treestartr)
data(bears)
```

First, we need to load a list of the total set of taxa present in the tree. The "total set" refers to any taxa that will be included in your analysis. This can be either a CSV or a TSV file. A sample list, tax_list, has been provided as part of the bears data object, but you can also generate one using the function dataf_parser. 

```{r eval=FALSE}
tax_list <- dataf_parsr(path/to/tax_file)
```

Next, we find out which of the taxa from our total set are not represented on the tree already. This function takes as input a tree, with or without branch lengths, but without annotations (such as 95% HPDs). It also takes the total set of taxa generated by dataf_parser:

```{r}
absent_list <- genera_strippr(tree, tax_list)
```

## Adding tips with congeners

Finally, we add the tips that are not present to the tree. If there are other representatives of the same genera as an absent taxon (for example, adding an additional "Ursus" species to the example tree), those taxa will be used to place the tip. If there are multiple species of the genera, the new tip will subtend the most recent common ancestor of the tips already on the tree. If there is only one representative, the tip will subtend the parent node of that taxon.

```{r}
new_tree <- present_tippr(tree, absent_list)
```

## Adding tips manually

We can also add the tips that have no congeners. This function will ask for input. A pop-up will be produced, showing node labels. When the program asks for input, you will tell it what node you would like the tip to subtend:

```{r eval=FALSE}
new_tree <- absent_tippr(tree, absent_list)
```

## Adding tips at random
Or, if there are no congeners, you may choose to add tips at random:

```{r}
new_tree <- rand_absent_tippr(tree, absent_list)
```

## Adding tips via CSV

Lastly, you may have a TSV file that specifies the tips to be added, and a taxon set. treeStartR will locate the MRCA of the taxon set, and add the tips subtending that node.

```{r}
new_tree <- text_placr(tree, mrca_df)
```

## Outputting results

The final tree can be output using standard functions in ape, such as write.nexus():

```{r}
write.nexus(new_tree, file = "data/export_example.tre")
```
