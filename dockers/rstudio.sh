docker run --name rstudio -d -p 8787:8787 -v $HOME/rstudio:/home/rstudio -e PASSWORD=rstudio rocker/rstudio
