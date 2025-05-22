# Simple Web Scraper

This script provides a basic web scraper that can fetch and parse HTML content from a given URL. It uses the `requests` library to make HTTP requests and `BeautifulSoup` to parse HTML.

## Features

- Fetches HTML content from a URL.
- Parses HTML using BeautifulSoup.
- Extracts all links from a page as an example.
- Basic error handling for network issues and HTTP errors.

## Requirements

- Python 3
- `requests`
- `beautifulsoup4`

## Setup

1.  **Clone the repository (if applicable) or download the `scraper.py` script.**
2.  **Install the required libraries:**
    ```bash
    pip install requests beautifulsoup4
    ```

## Usage

To run the scraper with the example URL (http://example.com):

```bash
python scraper.py
```

This will print all the links found on the example page. You can modify the `sample_url` variable in the `if __name__ == "__main__":` block in `scraper.py` to scrape a different URL.

## How it Works

The `scraper.py` script contains a function `get_parsed_html(url)` which:
1. Takes a URL as input.
2. Fetches the page content using `requests.get()`.
3. Parses the content using `BeautifulSoup`.
4. Returns the `BeautifulSoup` object.

The main part of the script (`if __name__ == "__main__":`) demonstrates how to use this function to get all links (`<a>` tags) from the specified `sample_url`.
