aps() {
    apt list 2>/dev/null | awk -F '/' '{print $1}' | fzf --ansi --preview="apt show {} 2>/dev/null" --preview-window=:hidden --bind="space:toggle-preview" | xargs -r -d "\n" sudo apt install -y
}
