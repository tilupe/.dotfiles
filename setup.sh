#!/bin/bash

$PACKAGE_MANAGER
$INSTALL_ALL
$INSTALLABLE_PROGRAMS

install_stow() {
    local package_manager=$1
    if ! command -v stow &> /dev/null; then
        if [ "$package_manager" = "apt" ]; then
            sudo apt-get update
            sudo apt-get install -y stow
        elif [ "$package_manager" = "pacman" ]; then
            sudo pacman -Sy
            sudo pacman -S --noconfirm stow
        elif [ "$package_manager" = "zypper" ]; then
            sudo zypper refresh
            sudo zypper --non-interactive install stow
        elif [ "$package_manager" = "dnf" ] || [ "$package_manager" = "yum" ]; then
            sudo dnf -y install stow || sudo yum -y install stow
        else
            echo "Unsupported package manager."
        fi
    else
        echo "stow is already installed."
    fi
}

install_choice() {
    read -p "Do you want to install all programs or choose specific ones?\n Type 'all' for complete install or 'select' for individual programs: " choice
    if [ "$choice" = "all" ]; then
        INSTALL_ALL=true
        echo "Installing all programs."
    elif [ "$choice" = "select" ]; then

        echo "Available programs:"
        for i in "${!INSTALLABLE_PROGRAMS[@]}"; do
            echo "$i: ${INSTALLABLE_PROGRAMS[$i]}"
        done

        read -p "Enter the program numbers you want to install (separated by spaces) or exclude (by adding a minus sign in front): " program_choice
        IFS=' ' read -r -a choices <<< "$program_choice"

        for choice in "${choices[@]}"; do
            if [ "$choice" = "0" ]; then
                INSTALL_ALL=true
                echo "Installing all programs."
                break
            elif [ "${choice:0:1}" = "-" ]; then
                index=${choice:1}
                unset "$INSTALLABLE_PROGRAMS"["$index"]
            else
                unset "$INSTALLABLE_PROGRAMS"[$choice]
            fi
        done

        echo "Installing the selected programs:"
        for program in "${INSTALLABLE_PROGRAMS[@]}"; do
            echo "Installing $program"
            # Add your installation command for each program here
        done
    else
        echo "Invalid choice. Please choose 'all' or 'select'."
    fi
}


if command -v apt &> /dev/null; then
    echo "apt package manager is available on this system and will be used for installing packages"
    PACKAGE_MANAGER="apt"
elif command -v pacman &> /dev/null; then
    echo "pacman package manager is available on this system and will be used for installing packages"
    PACKAGE_MANAGER="pacman"
elif command -v zypper &> /dev/null; then
    echo "zypper package manager is available on this system and will be used for installing packages"
    PACKAGE_MANAGER="zypper"
elif command -v dnf &> /dev/null; then
    echo "dnf package manager is available on this system and will be used for installing packages"
    PACKAGE_MANAGER="dnf"
elif command -v yum &> /dev/null; then
    echo "yum package manager is available on this system and will be used for installing packages"
    PACKAGE_MANAGER="yum"
else
    echo "There was no package manager found for this system"
    exit 1
fi


INSTALLABLE_PROGRAMS=("Install all" "program1" "program2" "program3") # Add your list of programs here
install_choice
for program in "${INSTALLABLE_PROGRAMS[@]}"; 
do
  echo "$program"
done
echo $PACKAGE_MANAGER
if $INSTALL_ALL; then echo "Installing all programs"; fi
install_stow "$PACKAGE_MANAGER"

