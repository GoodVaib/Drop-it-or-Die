#!/usr/bin/env python3
import os
import json
import requests
import html

def send_telegram_message(message, parse_mode='HTML'):
    bot_token = os.getenv('TELEGRAM_BOT_TOKEN')
    chat_id = os.getenv('TELEGRAM_CHAT_ID')
    topic_id = 6
    
    url = f"https://api.telegram.org/bot{bot_token}/sendMessage"
    payload = {
        'chat_id': chat_id,
        'message_thread_id': topic_id,
        'text': message,
        'parse_mode': parse_mode,
        'disable_web_page_preview': True
    }
    
    response = requests.post(url, json=payload)
    return response.json()

def main():
    event_path = os.getenv('GITHUB_EVENT_PATH')
    
    with open(event_path, 'r') as f:
        event_data = json.load(f)
    
    event_type = event_data.get('ref_type', '')
    ref_name = event_data.get('ref', '')
    repo_name = event_data['repository']['full_name']
    repo_url = event_data['repository']['html_url']
    sender_name = event_data['sender']['login']
    sender_url = event_data['sender']['html_url']
    
    # Экранируем HTML символы
    ref_name_escaped = html.escape(ref_name)
    repo_name_escaped = html.escape(repo_name)
    sender_name_escaped = html.escape(sender_name)
    
    message = None
    
    if event_type == 'branch':
        message = f'🔨 <b>[<a href="{repo_url}">{repo_name_escaped}</a>] New branch created: <a href="{repo_url}/tree/{ref_name}">{ref_name_escaped}</a> by {sender_name_escaped}</b>'
    
    elif event_type == 'tag':
        message = f'🏷️ <b>[<a href="{repo_url}">{repo_name_escaped}</a>] New tag created: <a href="{repo_url}/releases/tag/{ref_name}">{ref_name_escaped}</a> by {sender_name_escaped}</b>'
    
    else:
        print(f"Unhandled create event type: {event_type}")
        return
    
    if message:
        print(f"Sending message: {message}")
        result = send_telegram_message(message)
        print(f"Telegram API response: {result}")

if __name__ == '__main__':
    main()


