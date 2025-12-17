# $1 is the first argument you pass to the script
sudo pacman -Rs "$1"

# Optional: Add these to clean up the folders we discussed earlier
# rm -rf ~/.config/"$1"
# rm -rf ~/.local/share/"$1"