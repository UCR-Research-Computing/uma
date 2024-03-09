#!/bin/bash

# Function to check if pip is installed
check_pip_installed() {
    if ! command -v pip3 > /dev/null; then
        local msg="pip is not installed or not found in PATH. Please install pip before running this script."
        echo "$msg"
        log_error "$msg"  # Assuming log_error function can handle a single argument
        exit_gracefully
    fi
}

# Function to check if a package is installed
package_installed() {
    local package="$1"
    local installed_packages
    installed_packages=$(pip3 freeze)
    if echo "$installed_packages" | grep -q "^$package=="; then
        return 0  # Package is installed
    else
        return 1  # Package is not installed
    fi
}

# Function to install Python packages from requirements file
install_python_packages() {
    if pip3 install -r ./requirements.txt; then
        echo "Python packages installed successfully."
    else
        echo "Error: Failed to install required Python packages."
        exit 1
    fi
}


# Function to check if a directory is in the PATH
is_in_path() {
    [[ ":$PATH:" == *":$1:"* ]]  # Check if the directory is in the PATH
}

# Function to log errors
log_error() {
    echo "$(date): $1" >> installation_errors.log
}

# Function to rollback changes
rollback_changes() {
    # Implement rollback logic here
    echo "Rolling back changes..."
}

# Function to exit gracefully
exit_gracefully() {
    echo "Exiting gracefully..."
    rollback_changes
    exit 1
}

# Trap Ctrl+C and exit gracefully
trap exit_gracefully SIGINT

# Check if pip is installed
check_pip_installed

# Inform the user about the process
echo "Starting the installation process..."

# Prompt the user for an installation location
read -rp "Enter the installation location (default: ~/bin): " install_location

# Use ~/bin as the default answer if no input is provided
install_location=${install_location:-"$HOME/bin"}

# Validate the installation location, create if it does not exist
if [ ! -d "$install_location" ]; then
    echo "Installation location '$install_location' does not exist. Attempting to create it..."
    mkdir -p "$install_location" || { echo "Error: Failed to create installation location at '$install_location'."; exit_gracefully; }
    echo "Installation location '$install_location' created successfully."
fi

# Append the chosen location to the user's PATH if it's not already there
if ! is_in_path "$install_location"; then
    echo "export PATH=\"\$PATH:$install_location\"" >> "$HOME/.bashrc"

    # Update the current shell session with the new PATH
    export PATH="$PATH:$install_location"
fi

echo "Installation location set to: $install_location"

# Read the requirements file line by line
#while IFS= read -r line; do
#    package=$(echo "$line" | cut -d'=' -f1)  # Extract package name
#    if package_installed "$package"; then
#        echo "Package '$package' is already installed."
#    else
#        echo "Package '$package' is not installed."
        # Create a virtual environment for the installation process
echo "Creating a virtual environment for the installation process..."
#python3.9 -m venv ~/.uma-venv
conda create -y -n uma python=3.9

# Activate the virtual environment
#source ~/.uma-venv/bin/activate || { echo "Error: Failed to activate the virtual environment."; exit_gracefully; }
#conda init
# Initialize conda
source ~/miniconda3/etc/profile.d/conda.sh
conda activate uma || { echo "Error: Failed to activate the virtual environment."; exit_gracefully; }

# Install required Python packages in the virtual environment
echo "Installing required Python packages in the virtual environment..."
#if ! pip install -r ./requirements.txt > /dev/null 2>&1; then
pip3 install --upgrade pip

if ! pip3 install -r ./requirements.txt ; then
    log_error "Failed to install required Python packages in the virtual environment."
    exit_gracefully
fi

echo "Python packages installed successfully in the virtual environment."

#        break  # Stop checking further packages
#    fi
#done < ./requirements.txt


# Inform the user about the next steps
echo "Copying 'uma' script to the installation location and setting permissions..."

# Check if 'uma' file exists in the installation location
if [ -f "$install_location/uma" ]; then
    echo "'uma' script already exists at $install_location ."
    echo "Please run 'uma -u' to update the app if needed."
    echo "Moving on with the installation process..."
else
    # Copy 'uma' script to the installation location and set permissions
    if ! cp ./uma "$install_location" || ! chmod 755 "$install_location/uma"; then
        log_error "Failed to copy 'uma' script to the installation location or set permissions at $install_location."
        echo "Error: Failed to copy 'uma' script to the installation location or set permissions."
        exit_gracefully
    else
        echo "'uma' script copied and permissions set successfully."
    fi
fi

chmod 755 "$install_location/uma"

# Inform the user about the next steps
echo "Copying 'prompts.py' to the installation location..."

# Copy 'prompts.py' to the installation location
if ! cp ./prompts.py "$install_location" && chmod 755 "$install_location/prompts.py"; then
    log_error "Failed to copy 'prompts.py' to the installation location or set permissions."
    echo "Error: Failed to copy 'prompts.py' to the installation location or set permissions."
    exit_gracefully
else
    echo "'prompts.py' copied successfully."
fi

# Copy 'UMA' to the installation location
if ! cp ./UMA "$install_location" && chmod 755 "$install_location/UMA"; then
    log_error "Failed to copy 'UMA' to the installation location or set permissions."
    echo "Error: Failed to copy 'UMA' to the installation location or set permissions."
    exit_gracefully
else
    echo "'UMA' copied successfully."
fi

# Check if the config file already exists
if [ -f "$install_location/config.py" ]; then
    echo "Config file '$install_location/config.py' already exists."
    echo "Skipping setting the OpenAI API key."
else
    # Prompt the user to set the OpenAI API key
    echo "Please set your OpenAI API key:"
    read -rp "Enter your OpenAI API key (press Enter to use the default placeholder): " openai_api_key

    # Use the default placeholder if no key is provided
    openai_api_key=${openai_api_key:-"your-openapi-key"}

    # Write the API key to the config file
    cat <<EOF >> "$install_location/config.py"
OPENAI_API_KEY = "$openai_api_key"
EOF

    # Inform the user about the next steps
    if [ "$openai_api_key" == "your-openapi-key" ]; then
        echo "OpenAI API key set to the default placeholder."
        echo "You'll need to edit '$install_location/config.py' with your actual API key later."
    else
        echo "OpenAI API key set successfully."
    fi
fi


# Inform the user that the setup is complete
echo "Setup completed successfully."


