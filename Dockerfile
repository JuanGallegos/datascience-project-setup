FROM --platform=linux/amd64 r-base:4.3.0
RUN apt update
RUN apt-get install curl
RUN apt-get install pkg-config
RUN apt-get install libcurl4-openssl-dev 
RUN apt-get install libssl-dev 
RUN apt-get install -y libxml2-dev
RUN apt-get install -y libfontconfig1-dev
RUN apt-get install -y libharfbuzz-dev libfribidi-dev
RUN apt-get install -y libtiff5-dev
RUN Rscript -e 'install.packages("gargle", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("ids", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("openssl", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("ggplot2", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("systemfonts", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("textshaping", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("googledrive", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("googlesheets4", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("httr", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("ragg", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("xml2", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("rvest", repos="http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("tidyverse", repos="http://cran.rstudio.com/")'
WORKDIR /usr/local/src/myscripts
COPY myscript.R /usr/local/src/myscripts
