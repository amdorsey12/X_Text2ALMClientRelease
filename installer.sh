#!/bin/bash

#Create X_Text2ALM in home directory
cwd=$(pwd)
cd ~
mkdir X_Text2ALM
cd "$cwd"
cp -rf X_Text2ALMClientRelease ~/X_Text2ALM/
cd ~/X_Text2ALM

#Clone Text2ALM repository
git clone https://github.com/cdolson19/Text2ALM.git

#Verify python version and install required version if necessary
version=$(python -V 2>&1 | grep -Po '(?<=Python )(.+)')
if [[ -z "$version" ]]
then
    echo "No Python!, installing Python 3.8 ..."
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt-get update
    sudo apt-get install python3.8 
fi
parsedVersion=$(echo "${version//./}")
if [[ "$parsedVersion" -ge "360" ]]
then 
    echo "Valid version: $version"
else
    echo "Invalid version, installing Python 3.8 ..."
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt-get update
    sudo apt-get install python3.8
fi

#Set up system environment
pip install -r Text2ALM/requirements.txt
python - << EOF
import nltk
nltk.download('punkt')
nltk.download('verbnet3')
EOF
python3 -m pip install --user --upgrade clingo
pip install pandas
pip install more_itertools

#Verify .NET runtime installed and install if not already installed
dotnetVersion=$(dotnet --version)
echo $dotnetVersion
parsedDotnetVersion=$(echo "${dotnetVersion//./}")
echo $parsedDotnetVersion
if [[ -z "$dotnetVersion" ]]
then
    echo "No .NET!, installing .NET 6 runtime ..."
    sudo apt-get update && \
  	sudo apt-get install -y aspnetcore-runtime-6.0
fi
parsedDotnetVersion=$(echo "${dotnetVersion//./}")
if [[ "$parsedDotnetVersion" -ge "60000" ]]
then 
    echo "Valid version: $dotnetVersion"
else
    echo "Invalid version, installing .NET 6 runtime ..."
    sudo apt-get update && \
  	sudo apt-get install -y aspnetcore-runtime-6.0
fi

#Get LTH resources
wget -m https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mate-tools/srl-4.31.tgz
wget -m https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mate-tools/CoNLL2009-ST-English-ALL.anna-3.3.srl-4.1.srl.model
wget -m https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mate-tools/CoNLL2009-ST-English-ALL.anna-3.3.parser.model
wget -m https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mate-tools/CoNLL2009-ST-English-ALL.anna-3.3.postagger.model
wget -m https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mate-tools/CoNLL2009-ST-English-ALL.anna-3.3.lemmatizer.model

#Create resources directory
mkdir -p Text2ALM/resources/models/eng

#Move LTH resources to resources directory and rename srl model
tar -xvzf storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mate-tools/srl-4.31.tgz -C Text2ALM/resources
cd storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mate-tools/
mv CoNLL2009-ST-English-ALL.anna-3.3.srl-4.1.srl.model CoNLL2009-ST-English-ALL.anna-3.3.srl.model
mv *.model ../../../../../Text2ALM/resources/models/eng/
cd ../../../../../


#Get StanfordCoreNLP and move it to resources
wget -m http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip
unzip nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip -d Text2ALM/resources

#Clean up LTH and StanfordCoreNLP
rm -rf storage.googleapis.com
rm -rf nlp.stanford.edu

#Replace srl run_http_server.sh contents with Text2ALM run_http_server.sh contents
cp -f Text2ALM/run_http_server.sh Text2ALM/resources/srl-20131216/scripts/run_http_server.sh

#Make directories for Xclingo
mkdir ClingoIntermediateOutput XclingoOutput
cd Text2ALM
mkdir ExecutionTimes TestTraceFiles
cd ..

#Copy scripts into place and clean up srl resources path
cp -rf X_Text2ALMClientRelease/Scripts Text2ALM/
cd Text2ALM
mkdir resources/srl-4.31
mv resources/srl-20131216 resources/srl-4.31

#Copy publish to X_Text2ALM root
cd ..
cp -r X_Text2ALMClientRelease/Release/net6.0/linux-x64/publish .
