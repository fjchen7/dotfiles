If you want to install additional command line tools, just create a new file in `misc/installs`,`misc/install.sh` will parse and execute them automatically.

Install file example

```bash
#cmd
jq

#darwin
brew install jq

#linux
sudo apt-get install jq

```

if there is `#cmd`, the install script will check if terminal has this command. In this case, the command is `jq`. If exsitent, then installation will not go on.

If ther is not `#cmd`, the install script will go on to execute further install commands.

The following lines after `#darwin` and `#linux` are install commands respectively for different platforms.
