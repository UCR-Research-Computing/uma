"""
A simple web scraper using requests and BeautifulSoup.
This script provides a function to fetch and parse HTML from a given URL.
It also includes an example usage of the function.
"""

import requests
from bs4 import BeautifulSoup

def get_parsed_html(url: str):
    """
    Fetches the HTML content of a given URL and returns a BeautifulSoup object.

    Args:
        url: The URL to scrape.

    Returns:
        A BeautifulSoup object if successful, None otherwise.
    """
    try:
        # Send an HTTP GET request to the URL
        response = requests.get(url)
        # Check if the request was successful (status code 200)
        if response.status_code == 200:
            # Parse the HTML content using BeautifulSoup
            soup = BeautifulSoup(response.content, 'html.parser')
            return soup
        else:
            # Print an error message if the status code is not 200
            print(f"Error: Received status code {response.status_code} for URL: {url}")
            return None
    except requests.exceptions.RequestException as e:
        # Handle exceptions that may occur during the request (e.g., network issues)
        print(f"Error fetching URL {url}: {e}")
        return None

# The following block executes only when the script is run directly (not imported as a module)
if __name__ == "__main__":
    # Define a sample URL for demonstration
    sample_url = "http://example.com"
    print(f"Attempting to scrape: {sample_url}")
    
    # Call the function to get the parsed HTML
    parsed_html = get_parsed_html(sample_url)

    # Check if HTML parsing was successful
    if parsed_html:
        print("\nSuccessfully fetched and parsed HTML.")
        # Find all anchor (<a>) tags in the parsed HTML
        anchor_tags = parsed_html.find_all('a')
        
        # Check if any anchor tags were found
        if anchor_tags:
            print("\nFound the following links:")
            # Iterate through the found anchor tags
            for tag in anchor_tags:
                # Get the value of the 'href' attribute (the link URL)
                href = tag.get('href')
                # Print the link if it exists
                if href:
                    print(href)
        else:
            # Message if no anchor tags are found
            print("\nNo anchor tags with href found on the page.")
    else:
        # Message if HTML fetching or parsing failed
        print(f"\nFailed to fetch or parse HTML from {sample_url}.")
