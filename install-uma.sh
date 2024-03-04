#!/bin/bash


# Function to check if a package is installed
package_installed() {
    local package="$1"
    local installed_packages
    installed_packages=$(pip freeze)
    if echo "$installed_packages" | grep -q "^$package=="; then
        return 0  # Package is installed
    else
        return 1  # Package is not installed
    fi
}

# Function to install Python packages from requirements file
install_python_packages() {
    if pip install -r ./requirements.txt; then
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

# Inform the user about the process
echo "Starting the installation process..."

# Prompt the user for an installation location
read -rp "Enter the installation location (default: ~/bin): " install_location

# Use ~/bin as the default answer if no input is provided
install_location=${install_location:-"$HOME/bin"}

# Validate the installation location
if [ ! -d "$install_location" ]; then
    echo "Error: Installation location '$install_location' does not exist."
    exit_gracefully
fi

# Append the chosen location to the user's PATH if it's not already there
if ! is_in_path "$install_location"; then
    echo "export PATH=\"\$PATH:$install_location\"" >> "$HOME/.bashrc"

    # Update the current shell session with the new PATH
    export PATH="$PATH:$install_location"
fi

echo "Installation location set to: $install_location"

# Read the requirements file line by line
while IFS= read -r line; do
    package=$(echo "$line" | cut -d'=' -f1)  # Extract package name
    if package_installed "$package"; then
        echo "Package '$package' is already installed."
    else
        echo "Package '$package' is not installed."
        # Create a virtual environment for the installation process
        echo "Creating a virtual environment for the installation process..."
        python3 -m venv ~/uma_installation_venv

        # Activate the virtual environment
        source ~/uma_installation_venv/bin/activate || { echo "Error: Failed to activate the virtual environment."; exit_gracefully; }

        # Install required Python packages in the virtual environment
        echo "Installing required Python packages in the virtual environment..."
        if ! pip install -r ./requirements.txt > /dev/null 2>&1; then
            log_error "Failed to install required Python packages in the virtual environment."
            exit_gracefully
        fi

        echo "Python packages installed successfully in the virtual environment."

        # Deactivate the virtual environment
        deactivate || { echo "Error: Failed to deactivate the virtual environment."; exit_gracefully; }

	# Deactivate the virtual environment
	deactivate || { echo "Error: Failed to deactivate the virtual environment."; exit_gracefully; }

	# Define the virtual environment directory
	venv_dir=~/uma_installation_venv

	# Delete the virtual environment
	echo "Deleting the virtual environment..."
	rm -rf "$venv_dir"

	# Check to ensure the virtual environment directory is deleted
	if [ -d "$venv_dir" ]; then
    	    echo "Error: Failed to delete the virtual environment."
   	    exit_gracefully
	else
    	    echo "Virtual environment deleted successfully."
        fi




	# Install required Python packages in the base Python environment
	echo "Installing required Python packages in the base Python environment..."
	if ! pip install -r ./requirements.txt > /dev/null 2>&1; then
    	    log_error "Failed to install required Python packages in the base Python environment."
    	    exit_gracefully
	fi

	echo "Installing required Python packages in the base Python environment complete" 


        break  # Stop checking further packages
    fi
done < ./requirements.txt


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

