sudo dnf update -y
sudo dnf install git cockpit curl python3-devel vim golang java-11-openjdk-devel gcc-c++ cmake make npm -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo systemctl start cockpit.socket
sudo systemctl enable --now cockpit.socket
ret=$?

if [ $ret -ne 0 ]; then
	result = "Cockpit isn't live... Please check logs"
else
	curl http://localhost:9090
	newRet=$?
	if [ $newRet -ne 0 ]; then
		result = "Cockpit should be up, but isn't..."
	else
		result = "Cockpit is up and running"
	fi
fi


git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/irmo-keulen/vimrc.git
mv vimrc/.vimrc ~/.vimrc
rm -rf ~/vimrc
vim +PluginInstall +qall                                                                                                                                                                  
python3 ~/.vim/bundle/YouCompleteMe/install.py --all
vim +YcmRestartServer +qall
sudo dnf install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)
