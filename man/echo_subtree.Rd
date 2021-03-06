% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/echo_subtree.R
\name{echo_subtree}
\alias{echo_subtree}
\title{Print subtrees with tips added.}
\usage{
echo_subtree(tree, mrca_list, tip)
}
\arguments{
\item{tree}{Tree to which the tip will be added; object of type phylo}

\item{mrca_list}{Vector of taxa. The added tip will subtend the MRCA of these taxa}

\item{tip}{Taxon which will be added to the tree.}
}
\value{
tree subtree to which tip was added
}
\description{
Once a tip has been added to the tree, print the newick-formatted subtree to which the tip was added.
}
\examples{
mrca_list <- c("Ursus_arctos", "Ursus_spelaeus", "Ursus_americanus")
tree <- text_placr(tree, mrca_df)
echo_sub <- echo_subtree(tree, mrca_list, "Ursus_abstrusus")
}
