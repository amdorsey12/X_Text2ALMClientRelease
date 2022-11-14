#!/bin/bash
echo "Starting StanfordCoreNlp"
cd resources/stanford-corenlp-full-2018-10-05
java -mx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 9001 -timeout 45000

