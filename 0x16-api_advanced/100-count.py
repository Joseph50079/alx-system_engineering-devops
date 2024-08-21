#!/usr/bin/python3

"""
Recursive function for Querying Reddit api
"""

import requests
after = None


def recurse(subreddit, hot_list=[]):
    """
    recursively get subreddit in a list
    """

    global after

    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    header = {"User-Agent": "my-recursive-posts"}
    params = {"after": after}

    response = requests.get(
        url,
        headers=header,
        params=params,
        allow_redirects=False)
    if response.status_code == 200:
        after = response.json().get("data").get('after')
        params['after'] = after
        recurse(subreddit, hot_list)
        children = response.json().get('data').get('children')
        for i in children:
            hot_list.append(i['data']['title'])
            return hot_list
    else:
        return None


def for_count_word(word, word_list):
    """
    Method for getting how many times a word appears in word_list
    """
    return word_list.count(word.lower())


def count_for_title(word, title):
    """
    For counting each word in a single title
    """
    title_words = title.lower().split()
    return title_words.count(word.lower())


def count_words(subreddit, word_list):
    """
    Count words for subreddit
    """
    title_list = recurse(subreddit)
    if title_list is None:
        return
    word_list = [keyword.lower() for keyword in word_list]
    set_word = list(set(word_list))

    # Dictionary to store the count of each word
    word_count = {word: 0 for word in set_word}

    # Count the occurrences of each word in all titles
    for word in set_word:
        n_word = for_count_word(word, word_list)
        for title in title_list:
            n_keyword = count_for_title(word, title)
            word_count[word] += n_keyword

    # Print the results if the total count is not zero
    for word, total in word_count.items():
        if total > 0:
            print(f"{word}: {total}")
