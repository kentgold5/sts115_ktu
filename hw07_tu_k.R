library(httr)
library(jsonlite)
library(xml2)
library(rvest)

# Part 1
# Copy/paste the second parse_article_links function from the course reader into an R file.
# Annotate where the code breaks and explain why it is happening.

# url = "https://theaggie.org/category/features/"
# page = read_html(url)

parse_article_links = function(page) {
  # Get article URLs
  div = xml_find_all(page, "//div[@id = 'tdi_113']") # ERROR 1. The id that highlights all the articles changed to tdi_74
  links = xml_find_all(div, ".//h3/a")
  urls = xml_attr(links, "href")
  
  # Get next page URL
  nav = xml_find_all(page, "//div[contains(@class, 'page-nav')]")
  next_page = xml_find_all(nav, ".//a[contains(@aria-label, 'next-page')]")
  if (length(next_page) == 0) {
    next_url = NA
  } else {
    next_url = xml_attr(next_page, "href")
  }
  
  # Using a list allows us to return two objects
  list(urls = urls, next_url = next_url)
}

# NOTE: This code is likely to take a while to run, and is meant more for
# reading than for you to run and try out.

url = "https://theaggie.org/category/features/"
article_urls = list()
i = 1

# On the last page, the next URL will be `NA`.
while (!is.na(url)) {
  # Download and parse the page.
  page = read_html(url)
  result = parse_article_links(page)
  
  # Save the article URLs in the `article_urls` list. The variable `i` is the
  # page number.
  article_urls[[i]] = result$url
  i = i + 1
  
  # Set the URL to the next URL.
  url = result$next_url
  
  # Sleep for 1/30th of a second so that we never make more than 30 requests
  # per second.
  Sys.sleep(1/30)
}



# Part 2 Solution 
# In a separate section below, write your own function called parse_article_links_corrected that fixes the problems in part 1
# Only run the loop for the first 5 pages!!!
# Explain how you found out what works/why it works

# function to get the the article links for the current page and the link to the next page
parse_article_links_and_next_page = function(page) {
  # Get article URLs
  div = xml_find_all(page, "//div[@id = 'tdi_74']") # changed the id from tdi_113 to tdi_74
  links = xml_find_all(div, ".//h3/a") # title links are inside of h3 tags. Links are in "a" tags
  urls = xml_attr(links, "href") # extract the links from the href attribute as text
  
  # Get next page URL
  nav = xml_find_all(page, "//div[contains(@class, 'page-nav')]") # highlights navigation bar
  next_page = xml_find_all(nav, ".//a[contains(@aria-label, 'next-page')]") # highlights the next button
  if (length(next_page) == 0) {
    next_url = NA # NA if there is no next page
  } else {
    next_url = xml_attr(next_page, "href") # extract the link from the href attribute as text
  }
  
  # Using a list allows us to return two objects
  list(urls = urls, next_url = next_url)
}

# function
parse_article_links_corrected = function(url) {
  # empty list
  article_urls = list() 
  
  # only 5 pages
  for (i in 1:5) {
    
    # pages past the last page are NA so do not include them
    if (is.na(url)) {
      break 
    }
    
    # Download and parse the page.
    page = read_html(url)
    result = parse_article_links_and_next_page(page) # use above function to get article links and link to next page
  
    # Save the article URLs in the `article_urls` list. 
    article_urls[[i]] = result$url
    i = i + 1
  
    # Set the URL to the next URL.
    url = result$next_url
    
    # be a polite robot
    Sys.sleep(5) # pause the execution for 5 seconds

  }
  
return(article_urls) # return the list of article links

}

parse_article_links_corrected("https://theaggie.org/category/features/page/1") # shows links for first five pages
parse_article_links_corrected("https://theaggie.org/category/features/page/196") # shows links for last five pages
parse_article_links_corrected("https://theaggie.org/category/features/page/198") # only shows links from the page number specified to the last page number
parse_article_links_corrected("https://theaggie.org/category/features/page/200") # shows links for the last page
