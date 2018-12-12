#!/usr/bin/env bash

# Install R
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" > /etc/apt/sources.list.d/cran.list
apt-get -q update
apt-get -q -y upgrade
apt-get -q -y install r-base r-base-dev

# Install Shiny Server
apt-get -q -y install gdebi-core
R --slave -e "install.packages('shiny', repos='https://cran.rstudio.com/')"
VERSION=$(curl -Ss "https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION")
curl -SsO "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb"
gdebi --non-interactive shiny-server-$VERSION-amd64.deb
rm shiny-server-$VERSION-amd64.deb

# Install Baseline CompaRe dependencies
apt-get -q -y install libxml2-dev libcurl4-gnutls-dev libssl-dev libcairo2-dev
R --slave -e "install.packages('shinycssloaders', repos='https://cran.rstudio.com/')"
R --slave -e "install.packages('shinyjs', repos='https://cran.rstudio.com/')"
R --slave -e "install.packages('shinyBS', repos='https://cran.rstudio.com/')"
R --slave -e "install.packages('DT', repos='https://cran.rstudio.com/')"
R --slave -e "install.packages('ggplot2', repos='https://cran.rstudio.com/')"
R --slave -e "install.packages('reshape2', repos='https://cran.rstudio.com/')"
R --slave -e "install.packages('scales', repos='https://cran.rstudio.com/')"
R --slave -e "install.packages('svglite', repos='https://cran.rstudio.com/')"
R --slave -e "install.packages('BiocManager', repos='https://cran.rstudio.com/')"
R --slave -e "BiocManager::install()"
R --slave -e "BiocManager::install('DESeq2')"
R --slave -e "install.packages('devtools', repos='https://cran.rstudio.com/')"
R --slave -e "devtools::install_github('richysix/shinyMisc')"
R --slave -e "devtools::install_github('richysix/biovisr')"

# Install Baseline CompaRe
mkdir /srv/shiny-server/baseline_compare
git clone https://github.com/richysix/baseline_compare.git /srv/shiny-server/baseline_compare
