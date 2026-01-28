aps() {
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

    # Let user select packages
    selected_packages=$(apt list 2>/dev/null | awk -F '/' '{print $1}' | \
        fzf --multi \
            --ansi \
            --preview="apt show {} 2>/dev/null" \
            --preview-window="$preview_position" \
            --bind="space:toggle-preview" \
            --bind="ctrl-/:toggle-preview" \
            --bind="alt-j:preview-down,alt-k:preview-up" \
            --header="TAB: select | SPACE: toggle preview | Alt-j/k: scroll | ENTER: install"
    )

    if [ -n "$selected_packages" ]; then
        # Print selected packages nicely
        printf "Packages to install:\n%s\n\n" "$selected_packages"

        # Confirm with user
        read -p "Proceed with installation? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Install one by one (preserves interactive stdin)
            for pkg in $selected_packages; do
                sudo apt install -y "$pkg"
            done
        else
            echo "Cancelled."
        fi
    fi
}
