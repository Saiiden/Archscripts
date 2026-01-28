# FuzzyPackageLister

A Program for listing packages from your preferred package managers.

## Setup For Arch Linux (Pacman and Yay)

### Install fzf 
```bash
pacman -Sy fzf
```

### Add the file to your ~/.bashrc
```bash
cat ./arch.sh >> ~/.bashrc
```

## Setup For Ubuntu (Apt)

### Install fzf
```bash
sudo apt install fzf
```

### Add the file to your ~/.bashrc
```bash
cat ./ubuntu.sh >> ~/.bashrc
```

---

### Source your .bashrc to initialize the program
```bash
source ~/.bashrc
```

