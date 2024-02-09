library(ape)
library(phytools)
library(geiger)
setwd("/Users/sranavat/Desktop/combined_choi_pericopsis")

##Import the  ML tree
filt_tree<-read.tree("filtered_choi_rd2_20tree.raxml.bestTree")

##Plot the tree
plot(filt_tree, cex=0.5)

##Add Cercis as the outgroup
outgroup_taxon<-"Cercis_canadensis_KF856619"

##Assign it to a rooted tree
rooted_tree<-root(filt_tree, outgroup = outgroup_taxon)

#Plot the rooted tree
plot(rooted_tree, cex=0.5)

##Use the chronopl (molecular dating with penalized likelihood)
mytimetree<-chronopl(rooted_tree, lambda=1, age.max= NULL, age.min = 66, node = "root")

#Plot the dated tree
plot(mytimetree, cex=0.5)

#Convert tree to NEXUS format
write.nexus(mytimetree, file="/Users/sranavat/Desktop/combined_choi_pericopsis/filtered_choi_rd2_ultrametric_min66mya.nex")

#Convert the NEXUS tree to NEWICK using Figtree v1.4.4
