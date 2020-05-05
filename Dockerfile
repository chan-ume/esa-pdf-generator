FROM rocker/shiny:3.6.3

RUN apt update && apt install -y libcurl4-openssl-dev libssl-dev
RUN apt-get install -y texlive-latex-base texlive-fonts-recommended texlive-latex-recommended texlive-lang-cjk texlive-luatex texlive-xetex
RUN R -e "install.packages(c('httr', 'dplyr'), dependencies=T)"
