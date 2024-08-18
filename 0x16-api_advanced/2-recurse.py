#!/usr/bin/python3

"""
Recurse subreddit
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
