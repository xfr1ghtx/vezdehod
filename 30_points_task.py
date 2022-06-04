import requests
import json

def count_tries(users):
      link = "https://codeforces.com/api/user.status?handle="
      for user in users:
          request_info = requests.get(link+user)
          json_obj = dict(request_info.json())

          contests=[]

          for submissions in json_obj['result']:
              contests.append(
                  submissions.get('problem').get('contestId')
              )

          print(
              user,len(set(contests))
          )


students = input().split() # Список логинов через пробел. Например: login1 login2 login3
count_tries(students)