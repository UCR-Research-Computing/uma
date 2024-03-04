# Ursa Major Ask (UMA) Program

## Overview
The Ursa Major Ask (UMA) program is an interactive command-line tool that integrates with the OpenAI API to generate and execute scripts based on user input. It allows for dynamic script creation and execution through AI language modeling, providing a convenient way to automate tasks and perform actions within a Linux environment. Below is a detailed guide on using and understanding the Ursa Major Ask program.

## Features

### 1. Session Management
- Initialize and maintain session validity for continuous interaction flow.
  
### 2. Transcript Handling
- Append transcripts, fetch history, and update conversation context with AI responses.
  
### 3. OpenAI Interactions
- Interact with the OpenAI ChatCompletion model to generate scripts based on user and AI prompts.
  
### 4. Script Generation and Execution
- Generate, save, and run scripts with shebang lines, script types, and cleaning for execution.
  
### 5. File Operations
- Save responses to files with proper extensions, manage file cleanup.
  
### Additional Functions
- Run LS Later command.
- Update program-related files with latest versions.
- Generate summarized history of conversations.

## Usage Instructions

### How to Run
1. Supply a conversation transcript as input to engage with the AI model.
2. Choose an option:
   - Use `-r` to run the generated script immediately.
   - Use `-w` to write the generated script to a file.
   - Use `-u` to update specific program files.

### Example Usages
- To run a script based on the conversation transcript:
  ```bash
  python script_name.py conversation_transcript -r
  ```

- To write a script based on the conversation transcript to a file:
  ```bash
  python script_name.py conversation_transcript -w
  ```

- To update program files:
  ```bash
  python script_name.py -u
  ```

### Code Execution
- Running the script with a `-r` flag executes the generated script.
- Issuing the script command with a `-w` flag writes the generated script to a file.

### External Dependencies
- Relies on the OpenAI API for intelligent language model interactions.

## Notes
- Ensure proper OpenAI API key configurations and dependencies are correctly set up for smooth operation.
- Handle session management, script generation, and file operations with care.

For any queries or detailed assistance, feel free to reach out with specific requirements or questions related to the Ursa Major Ask program.
