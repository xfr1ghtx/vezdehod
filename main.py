from http.server import HTTPServer, BaseHTTPRequestHandler
import json


def create_question(text, answers, category):
    return {
        'text': text,
        'answers': answers,
        'category': category
    }


def create_card(pic_id, card_type="BigImage", url=None):
    return {
        'type': card_type,
        'image_id': pic_id,
        'url': url
    }


cards = {
    'backend': create_card(457239019),
    'mobile': create_card(457239018),
    'security': create_card(457239020),
    'algorithms': create_card(457239017),
    'mem': create_card(457239022, "MiniApp", "https://vk.com/app7543093")
}


def create_counter():
    return {
        'backend': 0,
        'security': 0,
        'mobile': 0,
        'algorithms': 0,
        'stage': 0
    }


def create_response(session, response, **kwargs):
    answer = kwargs
    answer['session'] = session
    answer['response'] = response
    return answer


users = {}

questions = [
    create_question("<speaker audio_vk_id=2000512046_456239028>{Что выведет программа?}{} <speak>let a = 5 let b = 7 console.log({a+b}{ а плюс ^бэ^ })</speak> <s>Введите текст</s>",
        ["12"], 'algorithms'),
    create_question("На каком языке пишут приложения для IOS?",
        ["swift", "свифт", "обжектив-си", "objective-c"], 'mobile'),
    create_question("<speaker audio_vk_id=2000512046_456239026>{Как называется самый распространённый язык для работы с реляционными базами данных}{}",
        ["sql"], 'backend'),
    create_question("<speaker audio_vk_id=2000512046_456239027>{Как называется вид инъекции, направленный на взлом реляцонных баз данных?}{} Введите текст",
        ["sql", "sql-injection", "sql-инъекция"], 'security'),
    create_question("Интерфейс для взаимодействия других программ с вашим сервисом",
        ["api", "апи"], 'backend'),
    create_question("Заполните многоточие, чтобы выдать всем пользователям все права для этого файла: \nsudo chmod " +
        "<...> /vezdekod/vezdehits.txt?",
        ["777"], 'security'),
    create_question("Какую сред`у разработки используют для создания android-приложений?",
        ["android studio, androidstudio"], 'mobile'),
    create_question("Как`ой `алгоритм имеет в ^худшем^ случае асимпт`отитическую сложность {nlogn}{эн лог эн}?" +
        "\n1. quickSort(X)\n2. bubbleSort(X)\n3. mergeSort(X)",
        ["3"], 'algorithms')
]


class MyHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        body = self.rfile.read(content_length)
        body = json.loads(body)

        if ('type' in body) and ('group_id' in body):
            if (body['type'] == 'confirmation') and (body['group_id'] == 213734019):
                self.wfile.write(bytes('9167cd1f', "utf-8"))
                return

        request = body['request']
        session = body['session']
        user_id = session['user_id']

        if user_id in users:
            user = users[user_id]
            if user['stage'] < len(questions):
                question = questions[user['stage']]
                if (user['stage'] > 0) and (request['command'] in question['answers']):
                    user[question['category']] += 1
                user['stage'] += 1
                self.send_as_json(create_response(
                    session,
                    {
                        "text": questions[user['stage']]["text"],
                        "tts": questions[user['stage']]["text"],
                    }
                ))
                return
            else:
                if (user['stage'] > 0) and (request['command'] in questions[-1]['answers']):
                    user[questions[-1]['category']] += 1
                del user['stage']
                max_ = max(user)
                keys = user.keys()

                argmax = None
                for key in keys:
                    if user[key] > max_:
                        argmax = key

                self.send_as_json(create_response(
                    session,
                    {
                        "text": f"<speaker audio=marusia-sounds/game-win-1>" +
                                f"Вам подходит категория {argmax}!" +
                                f"\nВаши баллы:" +
                                f"\nСпортпрог: {user['algorithms']}"
                                f"\nMobile: {user['mobile']}"
                                f"\nBack end: {user['backend']}"
                                f"\nИнфобез: {user['security']}",
                        "tts": f"<speaker audio=marusia-sounds/game-win-1>" +
                                f"Вам подходит категория {argmax}!" +
                                f"\nВаши баллы:" +
                                f"\nСпортпрог: {user['algorithms']}"
                                f"\nMobile: {user['mobile']}"
                                f"\nBack end: {user['backend']}"
                                f"\nИнфобез: {user['security']}",
                        "commands": [
                            cards[argmax],
                            cards['mem']
                        ]
                    },

                ))
                del user

        if request['command'] in ['вопросы об it', 'vezdehits вопросы об it']:
            users[user_id] = create_counter()
            self.send_as_json(create_response(
                session,
                {
                    'text': questions[0]['text'],
                    'tts': questions[0]['text']
                }
            ))
            return

        if request['command'] in ['vezdehits вездекод', 'vezdehits вездеход']:
            self.send_as_json(create_response(
                session,
                {
                    'text': "Привет вездекодерам!",
                    'tts': "Привет вездекодерам!"
                }
            ))
            return

        self.send_as_json(create_response(
            session,
            {
                "text": "Не понял.",
                "tts": "Не понял."
            },
            buttons={
                0: {
                    'title': 'VEZDEHITS Вездекод',
                    'payload': {
                        'text': 'VEZDEHITS Вездекод'
                    }
                },
                1: {
                    'title': 'VEZDEHITS Вездекод',
                    'payload': {
                        'text': 'VEZDEHITS Вездекод'
                    }
                }
            }
        ))

    def send_as_json(self, answer):
        self.wfile.write(bytes(json.dumps(answer), "utf-8"))


server_address = ('0.0.0.0', 7413)
server = HTTPServer(server_address, MyHTTPRequestHandler)
server.serve_forever()