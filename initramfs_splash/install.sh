echo "Installing OLED Boot Script..."

# check that this is a Raspberry Pi 4
if [ "$(uname -m)" != "aarch64" ] && [ "$(uname -m)" != "armv7l" ]; then
    echo "This script is intended for Raspberry Pi 4 only."
    exit 1
fi

# change to the directory of the script
cd "$(dirname "$0")"
echo "Current directory: $(pwd)"

# compile the C program
echo "Compiling oled_boot.c..."
gcc -o oled_boot oled_boot.c

# check if the compilation was successful
if [ $? -ne 0 ]; then
    echo "Compilation failed. Please check the source code for errors."
    exit 1
fi

# copy the compiled binary to /usr/local/bin
echo "Copying oled_boot to /usr/local/bin..."
sudo cp oled_boot /usr/local/bin/oled_boot

# copy oled to /etc/initramfs-tools/scripts/init-top/oled
echo "Copying oled script to /etc/initramfs-tools/scripts/init-top/oled..."
sudo mkdir -p /etc/initramfs-tools/scripts/init-top
sudo cp oled /etc/initramfs-tools/scripts/init-top/oled
sudo chmod +x /etc/initramfs-tools/scripts/init-top/oled

# copy oled_display to /etc/initramfs-tools/scripts/oled_display
echo "Copying oled_display script to /etc/initramfs-tools/scripts/oled_display..."
sudo cp oled_display /etc/initramfs-tools/scripts/oled_display
sudo chmod +x /etc/initramfs-tools/scripts/oled_display

# Update initramfs
echo "Updating initramfs..."
sudo update-initramfs -u -k $(uname -r)