# X_Text2ALMClientRelease
A desktop GUI client for X_Text2ALM; an extension of [Text2ALM](https://github.com/cdolson19/Text2ALM) which provides the following capabilities
+Automatically start up the Text2ALM servers and run Text2ALM or [Xclingo](https://github.com/bramucas/xclingo) on selected test files with selected trace files
+View resulting Clingo or Xclingo output within the client
+View and filter performance metrics on your executions of Text2ALM or X_Text2ALM
+Utilize the trace file builder tool to assist your construction of trace files
...This tool allows you to build files that strictly adhere to xclingo language. If you want it to be a mixed file, you would have to edit it in another text editor outside this tool.

# Prerequisites
1. Installation of Text2ALM. Create a folder named **Text2ALM** in your **Home** directory. Proceed to follow [these instructions](https://github.com/cdolson19/Text2ALM/wiki/System-Setup) in that folder.
2. Installation of xclingo. Instructions found [here](https://github.com/bramucas/xclingo). If your python requirements mentioned on that page are met, ```pip install xclingo``` will install xclingo

# Installation
1. Clone this repository to your **Home** directory such that the result is ```(user)/Home/X_Text2ALMClientRelease```
2. Run ```./install_x_text2alm_client.sh```, presuming you have met the prerequisites this should create an X_Text2ALM folder in your Home directory with the necessary assets to run the desktop client application.

# Running the client
1. Navigate to /home/(user)/X_Text2ALMClientRelease/Release/net6.0
2. Run ```./GuiClient```

A video demonstration of the capabilities can be seen here
[XText2ALMClientBetaRelease.webm](https://user-images.githubusercontent.com/43710452/201573532-e7c59343-4012-4f59-a18e-485dfafaf2c2.webm)

**Note** this is the first beta release of this application. It was developed strictly on a voluntary hobby basis and almost certainly contains bugs and much room for improvement. I am very open to feedback and to developing additional features should the interest be there for it. 
