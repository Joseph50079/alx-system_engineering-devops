#!/usr/bin/python3

"""Module for gathering data from an api"""

import json
import sys
import urllib.request


if __name__ == "__main__":
    user_id = sys.argv[1]
    url = f"https://jsonplaceholder.typicode.com/todos?userId={user_id}"
    employee_url = f"https://jsonplaceholder.typicode.com/users?id={user_id}"

    try:
        with urllib.request.urlopen(employee_url) as emp_res:
            user_data = emp_res.read().decode('utf-8')
            users = json.loads(user_data)
            EMPLOYEE_NAME = users[0]['name']
        with urllib.request.urlopen(url) as response:
            data = response.read().decode('utf-8')
            todos = json.loads(data)

            TOTAL_NUMBER = len(todos)
            NUMBER = sum(todo['completed'] for todo in todos)
            shorten = f"done with tasks({NUMBER}/{TOTAL_NUMBER}):"

            print(f"Employee {EMPLOYEE_NAME} is {shorten}")
            for todo in todos:
                if todo['completed'] is True:
                    print("\t {}".format(todo['title']))
    except urllib.error.URLError as e:
        print()
    except ValueError:
        print()
