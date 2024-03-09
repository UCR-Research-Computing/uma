# Ursa Major Ask (UMA)

Ursa Major Ask (UMA) is a powerful command-line interface (CLI) tool that leverages the capabilities of OpenAI's GPT language model. It allows you to interact with the AI system using natural language, enabling you to generate scripts, code, text files, and more with ease.

It can generate and run code including research software and Slurm submission scripts.

## Features

- **Script Generation**: UMA can generate scripts in various programming languages, such as Python, Bash, Perl, and Ruby, based on your natural language requests.
- **Text File Generation**: In addition to scripts, UMA can create text files with any desired content, making it useful for tasks like documentation, notes, or code snippets.
- **Contextual Understanding**: UMA maintains a session history, enabling the AI to provide contextually relevant responses based on the conversation's flow.
- **Command-Line Interface**: UMA is a CLI tool, making it easy to integrate into your existing workflow and automate tasks with scripts or shell commands.

## Installation

To install UMA, you'll need Python 3.6 or later and pip (the Python package installer). Clone the repository and install the required dependencies:

```bash
git clone https://github.com/UCR-Research-Computing/uma.git
cd uma
./install-uma.sh
```

An `install-uma.sh` script is included in the repository to automate the installation process. Here are the steps that the script performs:

1. **Create a 'bin' folder in your home directory**: This folder will be used to store the UMA script.

2. **Copy the UMA script to the 'bin' folder**: The script will be available in your 'bin' folder after this step.

3. **Set the permissions for the script**: The permissions for the UMA script are set to 755, making it executable.

4. **Add the 'bin' folder to your PATH**: This allows you to run the UMA script from anywhere on your system without having to specify the full path to the script.

5. **Install the required Python packages**: Create a conda environment named 'uma' and install the required Python packages: The script creates a conda environment named 'uma' and uses pip to install the required Python packages listed in the requirements.txt file within this environment.


---

### Configuring the OpenAI API key

During the installation process, the script checks for an existing configuration file (`config.py`) to determine if your OpenAI API key has already been set. Here's what happens:

- **If a Configuration File Exists:** The script detects that your setup is potentially complete and does not modify your existing configuration. This precaution helps in preserving any pre-existing settings, including the OpenAI API key.

- **Initial Setup:** If the configuration file is not found, the script assumes a fresh setup. You will be prompted to enter your OpenAI API key. This key is essential for your application's communication with OpenAI's services.

  - **Providing the API Key:** Upon prompt, entering your API key directly configures your application for immediate use.
  
  - **Using a Placeholder:** If you skip entering the API key, a placeholder is set. You'll need to update this with your actual API key later for the application to function correctly.

### How to Update the OpenAI API Key

If you initially used a placeholder or need to update your OpenAI API key, follow these steps to edit the `config.py` file within your installation directory:

1. **Locate the Configuration File:** Navigate to the installation directory where your `config.py` file is located. This path was specified during the installation and is referenced as `$install_location`.

2. **Edit the Configuration File:** Open the `config.py` file in a text editor of your choice. For example, using a terminal-based editor like `nano`, you can execute:
   ```bash
   nano $install_location/config.py
   ```
   Replace `$install_location` with the actual path to your installation directory.

3. **Update the API Key:** Within the `config.py` file, locate the line containing `OPENAI_API_KEY = "your-openapi-key"`. Replace `"your-openapi-key"` with your actual OpenAI API key enclosed in quotes. For example:
   ```python
   OPENAI_API_KEY = "sk-abcdef1234567890"
   ```
   Ensure to save your changes before closing the editor.

4. **Save and Close:** After updating the API key, save the file and exit the text editor. If using `nano`, press `CTRL + O` to save, then `Enter`, followed by `CTRL + X` to exit.

### Verifying the Configuration

Once you've updated the `config.py` file with your OpenAI API key, your application is ready to communicate with OpenAI's services. It's a good practice to verify the configuration by running a simple test or operation that requires API access, ensuring everything is set up correctly.

---

## Usage

You can run the script from the command line with the following command:

```bash
usage: UMA [-h] [-r] [-u] [-w] [--ext EXT] [transcript ...]

Your script description.

positional arguments:
  transcript           Transcript of the conversation

options:
  -h, --help           show this help message and exit
  -r, --run            Run the generated script
  -u, --update         Update Ursa_Major_Ask
  
Writing Options:
  -w, --write          Write the generated script. Must be used with --ext.
  --ext EXT            Specify the file extension to use when saving the file with -w. This argument is required if -w is used.
```

# Running Generated Scripts with UMA

One of the truly unique and powerful features of UMA is the `-r` or `--run` option. This option allows you to simply describe what you want to accomplish, and UMA will generate the appropriate script or code to achieve that task and execute it for you, all in one command.

## Real-Time Code Generation and Execution

With the `-r` option, you no longer need to explicitly ask UMA to "write a script" or specify the programming language. Instead, you can simply describe your desired task or objective, and UMA will intelligently determine the best approach, generate the necessary code, and execute it in real time.

```bash
UMA -r print Hello, World
```
The command above will generate a script (likely a Python script) that prints 'Hello, World!' and immediately execute it, outputting 'Hello, World!' to the console.

```bash
UMA -r calculate and print the fibonacci numbers up to 10000
```
```
Fibonacci Series up to 10000:
1
2
3
5
8
13
21
34
55
89
144
233
377
610
987
1597
2584
4181
6765

completed running: run.sh
```

---

## Example: Creating and Analyzing a Weather Dataset

UMA can also assist with data file creation and subsequent analysis. For instance, you might want to generate a dataset and then perform some initial data exploration or visualization tasks. Here's how you could accomplish this in two steps using UMA:

### Step 1: Create a CSV File with Weather Data

First, to create a CSV file named `weather.csv` containing example weather data, you would use the following command:

```bash
UMA -r create a csv file of example weather data named weather.csv
```

This command instructs UMA to generate a CSV file with sample weather data. The data might include columns such as Date, Location, Temperature, and Weather conditions, similar to:

```plaintext
Date,Location,Temperature,Weather
2022-01-01,Los Angeles,75,Sunny
2022-01-02,New York,50,Cloudy
2022-01-03,Chicago,45,Rainy
2022-01-04,Miami,85,Sunny
```

### Step 2: Analyze and Visualize the Data

After generating the `weather.csv` file, you might be interested in analyzing this data further. With UMA, you can easily proceed to data analysis and visualization. For example:

```bash
UMA -r load this data into a pandas DataFrame and create a basic plot using matplotlib to visualize the temperature variation across location < weather.csv
```

Executing this command prompts UMA to read the `weather.csv` file, load the data into a pandas DataFrame, and then use matplotlib to create a basic plot visualizing the temperature variation across different locations.

#### What UMA Does:

UMA interprets your command to perform the following actions:

1. **Load the CSV Data**: UMA loads the weather data from `weather.csv` into a pandas DataFrame. This step involves parsing the CSV file and converting it into a structured format that's easy to work with in Python.

2. **Visualize the Data**: Next, UMA creates a plot using matplotlib to visualize how the temperature varies by location. This visualization might be a bar chart showing each location's temperature, allowing you to quickly grasp the temperature differences.

#### Expected Outcome:

You'll receive a visual output, a bar chart, illustrating the temperature variations across the locations specified in your dataset. This visualization helps in understanding how the weather patterns differ among various cities.

---

This example demonstrates the versatility of UMA in creating datasets and facilitating the initial steps of data analysis and visualization. By seamlessly integrating data generation and analysis workflows, UMA streamlines the process from data creation to insightful visualizations.


Here are a few examples that involve high performance computing (HPC) with Slurm and genomics research pipelines:

1. **Running a Job on a Slurm Managed HPC Cluster**

   Instead of asking UMA to generate a Slurm script, you can simply request the desired outcome:

   ```bash
   UMA -r run the Python script 'my_analysis.py' on the 'research' partition of the HPC cluster
   ```

   UMA will generate the appropriate Slurm script to submit a job that runs 'my_analysis.py' on the 'research' partition of your cluster, and then execute the script to submit the job.

2. **Automating a Genomics Pipeline**

   Imagine you need to automate a genomics pipeline involving multiple tools:

   ```bash
   UMA -r run FastQC on 'sample.fastq', trim adapters using Trimmomatic, and then align the reads to the 'reference.fa' genome using HISAT2
   ```

   UMA will generate a Bash script that performs the specified tasks and then run this script for you.

3. **Creating and Running a Bioinformatics Workflow with Nextflow**

   ```bash
   UMA -r create and run a Nextflow workflow that takes 'reads.fastq' as input, runs FastQC for quality control, trims with Trimmomatic, aligns with BWA, and calls variants with FreeBayes
   ```

   UMA would create a Nextflow script that performs the specified workflow and then execute this script to start the workflow.

These examples demonstrate how UMA can be used in a scientific research setting, helping to automate tasks related to HPC and genomics research by simply describing your desired outcome. The possibilities are endless, and UMA's utility extends as far as your needs and creativity can take it.

## Unleashing Endless Possibilities

This ability is more than a convenience—it's a game-changer. Whether you need to create a Python script, a Bash shell script, or even a complex data analysis pipeline, UMA can generate and execute it for you by simply understanding your requirements. You can leverage the full power of the OpenAI model, GPT-3.5-turbo, to analyze data, automate tasks, or even write software—all within a single command.

Moreover, since UMA can take any text file as an input, the possibilities are virtually limitless. You could feed it a data file and ask it to perform data analysis, input a requirements document and ask it to write the corresponding code, or provide a bug report and ask it to debug and fix the code for you.

With UMA, you are not just talking about code—you are bringing it to life, turning ideas into actions and solutions in a matter of seconds. Code generation and execution have never been so accessible and intuitive. It's not just a coding tool; it's your AI-powered coding assistant that understands your needs and acts on them in real time.

Unlock the full potential of your programming prowess with the power of UMA.

## Powerful File Input and Data Analysis

UMA isn't just designed to accept file input – it's built to harness the full potential of OpenAI's GPT-3 model, enabling sophisticated analysis and interpretation of the data you feed into it. This elevates UMA from a mere command-line tool to a versatile solution for a wide range of data processing tasks.

Whether you are dealing with scripts, structured text files, or raw data, UMA can process it, and utilize the language understanding capabilities of GPT-3 to provide meaningful insights.

The power of this approach lies in its versatility. You are not limited to scripts or programming languages; you can feed in any type of text file and let the model analyze it based on the question you ask.

### Examples

1. **Analyzing a CSV data file**: If you have a CSV file, `sales_data.csv`, containing sales data for a period, you could ask:

    ```
    UMA analyze the sales trend < sales_data.csv
    ```
    UMA will provide you with an interpretation of the sales trend based on the data in the file.

2. **Understanding Log Files**: You have a log file, `server.log`, and you want to know about any critical errors. You can ask:

    ```
    UMA find critical errors < server.log
    ```
    The command-line tool will provide a summary of the critical errors found in the log file.

3. **Interpreting Complex XML or JSON data**: You can even feed complex XML or JSON files. For instance, with a complex JSON data file `user_data.json`, you might want to understand the user behavior it signifies:

    ```
    UMA interpret user behavior < user_data.json
    ```
    UMA will then provide an interpretation of the user behavior based on the data.


Remember, UMA is as powerful and versatile as the questions you ask and the data you feed. It leverages the robustness of OpenAI's GPT-3 model to analyze, understand, and provide insights on a wide array of data. 

---

Please note that the file paths in these examples are relative. If your files are in different directories, be sure to include the correct paths. Also, ensure the data or text you're feeding into UMA does not contain sensitive or personal information, as it will be processed by an external AI model.

Here are additional examples showcasing the versatility of Ursa Major Ask (UMA) for a variety of tasks, from file manipulation and data processing to advanced analytics and visualization. Each example is designed to illustrate how UMA can be employed to automate and streamline complex processes with simple commands.

### Example: Generating a Financial Report from Transaction Data

#### Step 1: Generate Transaction Data File

To create a detailed CSV file named `transactions.csv` containing financial transaction data for a given period, use the command:

```bash
UMA -r create a csv file of monthly financial transactions named transactions.csv
```

This command prompts UMA to generate a CSV file, possibly including columns for Date, Transaction ID, Description, Category, and Amount, encapsulating a month's worth of financial transactions.

#### Step 2: Analyze Monthly Expenses by Category

After you have your transaction data ready, you might want to analyze your monthly expenses categorized by the type of expense:

```bash
UMA -r analyze monthly expenses by category from the transactions.csv file and visualize it < transactions.csv
```

**What UMA Does:**

1. **Data Aggregation**: UMA reads `transactions.csv`, aggregating expenses by category to understand spending patterns.
2. **Visualization**: It then generates a pie chart or bar graph visualizing the proportion of total expenses for each category, making it easier to identify where most of the money is going.

#### Expected Outcome:

A visual representation of monthly expenses by category, aiding in financial planning and budget management.

### Example: Analyzing Social Media Engagement

#### Step 1: Compile Social Media Data

Imagine you want to compile data regarding social media engagement for your content across various platforms:

```bash
UMA -r create a csv file with social media engagement data named engagement.csv
```

UMA could generate a CSV file that includes columns like Date, Platform, Likes, Comments, Shares, and Views.

#### Step 2: Identify Trends in Engagement

To extract insights from the engagement data, particularly identifying trends over time:

```bash
UMA -r plot engagement trends over time from engagement.csv < engagement.csv
```

**What UMA Does:**

1. **Trend Analysis**: Loads the engagement data, analyzing trends over time for various metrics (likes, comments, shares, views).
2. **Generate Plots**: Creates line graphs or time-series plots for each engagement metric over time, allowing you to visually track how engagement has evolved.

#### Expected Outcome:

Visual plots that highlight engagement trends, enabling you to strategize content based on historical performance.

### Example: Environment Monitoring Data Interpretation

#### Step 1: Generate Environmental Data Log

For environmental scientists, generating a log of environmental data from various sensors:

```bash
UMA -r create a csv file with environmental data from multiple sensors named environment_log.csv
```

This might create a file with Date, Time, Location, Temperature, Humidity, CO2 Levels, and Particulate Matter.

#### Step 2: Environmental Data Analysis for Anomalies

To identify any anomalies or patterns in the environmental data:

```bash
UMA -r detect anomalies in environmental data and generate a report < environment_log.csv
```

**What UMA Does:**

1. **Anomaly Detection**: Processes the environmental data to detect any unusual patterns or values that deviate significantly from the norms.
2. **Report Generation**: Compiles findings into a report, highlighting any detected anomalies along with their potential implications.

#### Expected Outcome:

A detailed report on environmental data anomalies, aiding in early detection of environmental issues or the assessment of sensor equipment performance.

These examples illustrate UMA's capacity to simplify complex data tasks, from creation and analysis to visualization and reporting, across diverse domains with straightforward commands.

## Note

This script is for educational and research purposes. It is not meant for production use.

## License

This project is licensed under the terms of the MIT license.

## Contributions

We welcome contributions to improve this project. Please feel free to create an issue or pull request.

## Contact

For any queries, please reach out to us at research-computing@ucr.edu.
```
