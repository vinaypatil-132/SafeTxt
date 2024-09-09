#!/bin/bash

# Default password for encryption/decryption
default_password="DefaultSecretPassword123"

# Function to display a banner
function display_banner() {
    echo -e "\e[34m============================================================\e[0m"
    echo -e "\e[92m                    Secure Message Tool                     \e[0m"
    echo -e "\e[34m============================================================\e[0m"
}

# Function to encrypt a message
function encrypt_message() {
    read -p "Write the message: " message
    encrypted=$(echo "$message" | openssl enc -aes-128-cbc -a -A -pass pass:"$default_password")
    echo -e "\e[93mEncrypted message: \e[0m$encrypted"
}

# Function to decrypt a message
function decrypt_message() {
    read -p "Enter the encrypted message: " encrypted_message
    decrypted=$(echo "$encrypted_message" | openssl enc -aes-128-cbc -a -A -d -pass pass:"$default_password" 2>/dev/null)
    
    if [ $? -eq 0 ]; then
        echo -e "\e[92mDecrypted message: \e[0m$decrypted"
    else
        echo -e "\e[31mError: Decryption failed. Invalid input.\e[0m"
    fi
}

# Main menu loop
function main_menu() {
    while true; do
        echo -e "\n\e[96mChoose an option:\e[0m"
        echo -e "\e[93m1) Encrypt a message\e[0m"
        echo -e "\e[93m2) Decrypt a message\e[0m"
        echo -e "\e[93m3) Exit\e[0m"
        
        read -p "Enter your choice: " choice
        
        case $choice in
            1)
                encrypt_message
                ;;
            2)
                decrypt_message
                ;;
            3)
                echo -e "\e[92mExiting the tool. Stay secure!\e[0m"
                break
                ;;
            *)
                echo -e "\e[31mInvalid option. Please try again.\e[0m"
                ;;
        esac
    done
}

# Display the banner and start the main menu
display_banner
main_menu
