#!/usr/bin/env python3
import os
import json
import requests
import urllib.parse

def send_telegram_message(message):
    bot_token = os.getenv('TELEGRAM_BOT_TOKEN')
    chat_id = os.getenv('TELEGRAM_CHAT_ID')
    topic_id = 6  # Ваш topic_id
    
    url = f"https://api.telegram.org/bot{bot_token}/sendMessage"
    payload = {
        'chat_id': chat_id,
        'message_thread_id': topic_id,
        'text': message,
        'parse_mode': 'MarkdownV2',  # Используем MarkdownV2 - он более строгий
        'disable_web_page_preview': True
    }
    
    response = requests.post(url, json=payload)
    return response.json()

def escape_markdown_v2(text):
    """Экранирование специальных символов для MarkdownV2"""
    escape_chars = '_*[]()~`>#+-=|{}.!'
    return ''.join(f'\\{char}' if char in escape_chars else char for char in text)

def main():
    event_path = os.getenv('GITHUB_EVENT_PATH')
    
    with open(event_path, 'r') as f:
        event_data = json.load(f)
    
    print(f"Event data: {json.dumps(event_data, indent=2)}")  # Debug
    
    event_type = event_data.get('ref_type', '')  # 'branch' или 'tag'
    ref_name = event_data.get('ref', '')
    repo_name = event_data['repository']['full_name']
    repo_url = event_data['repository']['html_url']
    sender_name = event_data['sender']['login']
    sender_url = event_data['sender']['html_url']
    
    # Экранируем все переменные
    ref_name_escaped = escape_markdown_v2(ref_name)
    repo_name_escaped = escape_markdown_v2(repo_name)
    sender_name_escaped = escape_markdown_v2(sender_name)
    
    message = None
    
    if event_type == 'branch':
        branch_url = f"{repo_url}/tree/{urllib.parse.quote(ref_name)}"
        message = f"🔨 *\\[{repo_name_escaped}\\] New branch created: \\[{ref_name_escaped}\\]\\({branch_url}\\) by [{sender_name_escaped}]\\({sender_url}\\)*"
    
    elif event_type == 'tag':
        tag_url = f"{repo_url}/releases/tag/{urllib.parse.quote(ref_name)}"
        message = f"🏷️ *\\[{repo_name_escaped}\\] New tag created: \\[{ref_name_escaped}\\]\\({tag_url}\\) by [{sender_name_escaped}]\\({sender_url}\\)*"
    
    else:
        print(f"Unhandled create event type: {event_type}")
        return
    
    if message:
        print(f"Sending message: {message}")  # Debug
        result = send_telegram_message(message)
        print(f"Telegram API response: {result}")
        
        if not result.get('ok'):
            # Попробуем отправить без Markdown если есть ошибка
            print("Trying without Markdown formatting...")
            plain_message = f"🔨 [{repo_name}] New {event_type} created: {ref_name} by {sender_name}"
            payload_plain = {
                'chat_id': chat_id,
                'message_thread_id': topic_id,
                'text': plain_message,
                'disable_web_page_preview': True
            }
            response_plain = requests.post(url, json=payload_plain)
            print(f"Plain message response: {response_plain.json()}")
    else:
        print("No message to send")

if __name__ == '__main__':
    main()
