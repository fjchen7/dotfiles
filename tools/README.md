If you want to install additional CLI tools, just create a new file in `./installers`. `./install.sh` will parse and install them automatically.

Install file example in `./installers`

```bash
#cmd
jq

#darwin
brew install jq

#linux
sudo apt-get install jq

```

if there is tag `#cmd`, the `install.sh` will check if terminal has this command. In this case, the command is `jq`. If existent, installation will not go on.

If there is not tag `#cmd`, the `install.sh` will go on to execute further install steps.

The following lines after `#darwin` and `#linux` are install commands respectively for different platforms.
