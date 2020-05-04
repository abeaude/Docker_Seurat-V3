FROM rocker/verse:3.6.2
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -y -q --no-install-recommends install \
  cargo \
  freeglut3-dev \
  zlib1g \
  libpng16-16 \
  libhdf5-dev \
  libgsl0-dev \
  && apt-get clean 

RUN R -e "BiocManager::install(c('multtest','S4Vectors', 'SummarizedExperiment', 'SingleCellExperiment', 'MAST', 'DESeq2', 'destiny', 'BiocParallel','limma'),ask=FALSE, quiet = TRUE)" \
  && install2.r --error -s --deps TRUE --ncpus 5 \
	future \
	igraph\
	cowplot \
	hdf5r \
	Seurat \
  && R -e 'devtools::install_github(repo = "mojaveazure/loomR", ref = "develop")'
  
COPY SDMTools_1.1-221.2.tar.gz /home/rstudio

RUN install2.r /home/rstudio/SDMTools_1.1-221.2.tar.gz \
    && rm /home/rstudio/SDMTools_1.1-221.2.tar.gz
