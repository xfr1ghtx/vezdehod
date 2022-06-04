import requests
import json


def count_tries(users):
    link = "https://codeforces.com/api/user.status?handle="
    for user in users:
        request_info = requests.get(link + user)
        json_obj = dict(request_info.json())

        tasks = []

        for submissions in json_obj['result']:
            prob = submissions.get('problem')
            if prob.get('contestId'):
                tasks.append(
                    str(prob.get('contestId')) + prob.get('index')
                )
            else:
                tasks.append(
                    prob.get('index')
                )

        print(
            user, len(set(tasks))
        )


students = input().split()  # Список логинов через пробел. Например: login1 login2 login3
count_tries(students)
