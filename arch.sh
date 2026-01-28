aps() {
    selected_packages=$(pacman -Sl | awk '{print $2}' | \
        fzf --multi \
            --ansi \
            --preview="pacman -Si {}" \
            --preview-window=right:60%:wrap \
            --bind="space:toggle-preview" \
            --bind="ctrl-/:toggle-preview" \
            --bind="alt-j:preview-down,alt-k:preview-up" \
            --header="TAB: select multiple | SPACE/Ctrl-/: toggle preview | Alt-j/k: scroll preview")

    if [ -n "$selected_packages" ]; then
      echo -e "Selected packages:\n$selected_packages"
      for pkg in $selected_packages; do
        sudo pacman -S "$pkg"
        done
    fi
}

aur() {
    selected_packages=$(yay -Sl | awk '{print $2}' | \
        fzf --multi \
            --ansi \
            --preview="yay -Si {}" \
            --preview-window=right:60%:wrap \
            --bind="space:toggle-preview" \
            --bind="ctrl-/:toggle-preview" \
            --bind="alt-j:preview-down,alt-k:preview-up" \
            --header="TAB: select multiple | SPACE/Ctrl-/: toggle preview | Alt-j/k: scroll preview")

    if [ -n "$selected_packages" ]; then
        echo -e "Selected packages:\n$selected_packages"
        for pkg in $selected_packages; do
          yay -Gp "$pkg" | less
          yay -S "$pkg"
          done
    fi
}

apd() {
    # Get terminal dimensions
    local term_width=$(tput cols)
    local term_height=$(tput lines)
    
    # Decide preview layout based on terminal size
    local preview_position
    if [ "$term_width" -ge 120 ]; then
        preview_position="right:60%:wrap"
    elif [ "$term_height" -ge 30 ]; then
        preview_position="down:50%:wrap"
    else
        preview_position="down:80%:wrap:hidden"
    fi
    
    selected_packages=$(pacman -Qq | \
        fzf --multi \
            --ansi \
            --preview="pacman -Qi {}" \
            --preview-window="$preview_position" \
            --bind="space:toggle-preview" \
            --bind="ctrl-/:toggle-preview" \
            --bind="alt-j:preview-down,alt-k:preview-up" \
            --header="TAB: select | SPACE: preview | Alt-j/k: scroll | ENTER: delete")
    
    if [ -n "$selected_packages" ]; then
        printf "Packages to remove:\n%s\n\n" "$selected_packages"

        read -p "Proceed with removal? [y/N] " -n 1 -r
        echo

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            for pkg in $selected_packages; do
                sudo pacman -Rns "$pkg"
            done
        else
            echo "Cancelled."
        fi
    fi
}


aurd() {
    local term_width=$(tput cols)
    local term_height=$(tput lines)
    
    local preview_position
    if [ "$term_width" -ge 120 ]; then
        preview_position="right:60%:wrap"
    elif [ "$term_height" -ge 30 ]; then
        preview_position="down:50%:wrap"
    else
        preview_position="down:80%:wrap:hidden"
    fi
    
    selected_packages=$(yay -Qq | \
        fzf --multi \
            --ansi \
            --preview="yay -Qi {}" \
            --preview-window="$preview_position" \
            --bind="space:toggle-preview" \
            --bind="ctrl-/:toggle-preview" \
            --bind="alt-j:preview-down,alt-k:preview-up" \
            --header="TAB: select | SPACE: preview | Alt-j/k: scroll | ENTER: delete")

    if [ -n "$selected_packages" ]; then
        printf "Packages to remove:\n%s\n\n" "$selected_packages"

        read -p "Proceed with removal? [y/N] " -n 1 -r
        echo

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            for pkg in $selected_packages; do
              yay -Rns "$pkg"
            done
        else
            echo "Cancelled."
        fi
    fi
}
