aps() {
selected_packages=$(pacman -Sl | awk '{print $2}' | \
    fzf --ansi --preview="pacman -Si {}" --preview-window=:hidden --bind="space:toggle-preview")

    if [ -n "$selected_packages" ]; then
        for pkg in $selected_packages; do
            sudo pacman -S "$pkg"
        done
    fi
}

aur() {
selected_packages=$(yay -Sl | awk '{print $2}' | \
    fzf --ansi --preview="yay -Si {}" --preview-window=:hidden --bind="space:toggle-preview")

    if [ -n "$selected_packages" ]; then
        for pkg in $selected_packages; do
            yay -Gp "$pkg" | less
            yay -S "$pkg"
        done
    fi
}


# Install fzf 
# pacman -Syu fzf 
# Add the file to your .bashrc
# echo "source path/to/functions.txt" >> ~/.bashrc

## Uncomment the code below and comment until this line for Ubuntu's apt 
#aps() {
# apt list 2>/dev/null | awk -F '/' '{print $1}' | fzf --ansi --preview="apt show {} 2>/dev/null" --preview-window=:hidden --bind="space:toggle-preview" | xargs -r -d "\n" sudo apt install -y
#}
