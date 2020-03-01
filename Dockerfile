FROM jupyter/datascience-notebook:python-3.7.6
WORKDIR work
COPY . .
RUN pip install nltk
RUN python -m nltk.downloader stopwords
RUN python -m nltk.downloader wordnet
RUN python -m nltk.downloader punkt