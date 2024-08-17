#!/usr/bin/python3

"""
Top ten of Subreddit posts
"""

import requests


def top_ten(subreddit):
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    header = {"User-Agent": "Google Chrome Version 8.1.*"}
    params = {"limit": 10}

    try:
        response = requests.get(
            url,
            headers=header,
            params=params,
            allow_redirects=False)
        if response.status_code == 200:
            children = response.json().get("data").get("children")
            for i in children:
                print(i["data"]["title"])
        else:
            print(None)
    except Exception:
        print(None)
