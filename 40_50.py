import random
import discord
from discord.ext import commands, tasks
from datetime import datetime as dt
import requests

# В той же ветке на гите лежит файл README.md с описанием работы бота

def read_csv(filename = './students.csv'):
    rows = []
    with open(filename, encoding='utf8') as file:
      lines = file.readlines()
      lines = [line.rstrip() for line in lines]

    for index in range(3):
        lines[index] = lines[index].split(',')
    lines[-1] = lines[-1].strip('"').split('","')
    lines[-1] = list(map(lambda x: x.split(','), lines[-1]))
    return lines


weekdays = {
    'понедельник': 0,
    'вторник': 1,
    'среда': 2,
    'четверг': 3,
    'пятница': 4,
    'суббота': 5,
    'воскресенье': 6
}


def check_weekday(weekday_interval):
    weekday_from, weekday_to = weekday_interval.split(' - ')
    weekday_from, weekday_to = weekdays[weekday_from], weekdays[weekday_to]
    if weekday_to < weekday_from:
        weekday_to += 7

    return weekday_from <= dt.today().weekday() <= weekday_to


def check_time(time_interval):
    time_from, time_to = time_interval.split(' - ')

    format_ = '%H:%M'
    time_from = dt.strptime(time_from, format_).time()
    time_to = dt.strptime(time_to, format_).time()

    return time_from <= dt.today().time() <= time_to


def check_study_time(weekday_interval: str,time_interval: str):
    return check_weekday(weekday_interval) and check_time(time_interval)


intents = discord.Intents.default()
bot = commands.Bot(command_prefix="$", intents=intents)

students = {
}


@tasks.loop(seconds=30)
async def printer():
    print("aaaaa")
    groups = read_csv()
    for i in range(len(groups[0])):
        if check_study_time(groups[1][i], groups[2][i]):
            if groups[0][i] not in students:
                students[groups[0][i]] = []
        else:
            if groups[0][i] in students:
                with open("logs.txt", "a") as file:
                    file.write("\n-----------------------------------")
                    file.write(dt.today().strftime("\n%Y-%m-%d %H:%M:%S"))
                    for student in students[groups[0][i]]:
                        file.write(f"\nstudent")
                del students[groups[0][i]]


@bot.event
async def on_voice_state_update(member, before, after):
    groups = read_csv()
    if after.channel and (after.channel.name in groups[0]):
        print(member)
        index = groups[0].index(after.channel.name)
        time_now = check_study_time(groups[1][index], groups[2][index])
        if time_now and (str(member) in groups[-1][index]):
            print(member)
            students[groups[0][index]].append(str(member))


def get_all_problems():
    link ="https://codeforces.com/api/problemset.problems"
    request_info = requests.get(link)
    json_obj = dict(request_info.json())

    problems = []

    for p in json_obj['result']['problems']:

        if p.get('contestId'):
            problems.append(
                str(p.get('contestId')) + '$' +  p.get('index')
            )
        else:
            problems.append(
                p.get('index')
            )
    return set(problems)


def get_tries(users):
    link = "https://codeforces.com/api/user.status?handle="
    problems_matrix = []
    for user in users:
        request_info = requests.get(link + user)
        json_obj = dict(request_info.json())

        problems = []

        print(json_obj)
        for submissions in json_obj['result']:
            prob = submissions.get('problem')
            if prob.get('contestId'):
                problems.append(
                    str(prob.get('contestId')) + '$' + prob.get('index')
                )
            else:
                problems.append(
                    prob.get('index')
                )

        problems_matrix.append(set(problems))
    result = set([])
    for row in problems_matrix:
        result.union(row)
    return result


@bot.command(name="?")
async def what(ctx, *args):
    tries = get_tries(args)
    all_problems = get_all_problems()
    diff = all_problems.difference(tries)
    info = random.sample(diff, 1)
    contest_id, index = info[0].split("$")
    await ctx.send(f"https://codeforces.com/contest/{contest_id}/problem/{index}")

printer.start()

bot.run("OTgyNTMwNjAzNzAwMzU1MDky.GCtv7G.gGQBbZ2H8xhKIKj-kp67mHTRxRC0NYITItXfbQ")

