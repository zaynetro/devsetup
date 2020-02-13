#!/bin/bash
set -e

# Create bash directory
bash_dir=$HOME/.bash
if [[ ! -d $bash_dir ]]; then
  echo "Creating $bash_dir dir..."
  mkdir $bash_dir
fi

# Install git aware prompt
# https://github.com/jimeh/git-aware-prompt
git_aware_dir=$bash_dir/git-aware-prompt
if [[ ! -d $git_aware_dir ]]; then
  # Clone it if not exists
  echo "Cloning git aware prompt to $bash_dir..."
  (cd $bash_dir && git clone https://github.com/jimeh/git-aware-prompt.git )
else
  # Update it otherwise
  echo "Pulling git aware prompt changes..."
  (cd $git_aware_dir && git pull origin master )
fi

# Copy .bash_profile
echo "Copying .bash_profile..."
cp bash_profile $HOME/.bash_profile

# Validate that .bashrc exists
if [[ ! -f $HOME/.bashrc ]]; then
  echo "Creating .bashrc..."
  touch $HOME/.bashrc
fi

# Validate that .bashrc sources common file
common_str="source ~/.bash/common.sh"
if ! grep -Fxq "$common_str" $HOME/.bashrc; then
  echo "Adding sourcing to a common file to bashrc..."
  echo "$common_str" >> $HOME/.bashrc
fi

# Copy environment files
echo "Copying environment files..."
cp *.sh $bash_dir
rm $bash_dir/setup.sh

echo "Sourcing $HOME/.bash_profile..."
source $HOME/.bash_profile
