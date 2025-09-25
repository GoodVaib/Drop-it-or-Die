#!/usr/bin/env python3
import os
import json
import requests

def send_telegram_message(message):
    bot_token = os.getenv('TELEGRAM_BOT_TOKEN')
    chat_id = os.getenv('TELEGRAM_CHAT_ID')
    topic_id = 6  # Ваш topic_id
    
    url = f"https://api.telegram.org/bot{bot_token}/sendMessage"
    payload = {
        'chat_id': chat_id,
        'message_thread_id': topic_id,
        'text': message,
        'parse_mode': 'Markdown',
        'disable_web_page_preview': True
    }
    
    response = requests.post(url, json=payload)
    return response.json()

def main():
    event_path = os.getenv('GITHUB_EVENT_PATH')
    
    with open(event_path, 'r') as f:
        event_data = json.load(f)
    
    event_type = event_data.get('ref_type', '')  # 'branch' или 'tag'
    ref_name = event_data.get('ref', '')
    repo_name = event_data['repository']['full_name']
    repo_url = event_data['repository']['html_url']
    sender_name = event_data['sender']['login']
    sender_url = event_data['sender']['html_url']
    
    if event_type == 'branch':
        message = f"""🔨 **[[{repo_name}]({repo_url})] New branch created: [`[{ref_name}]({repo_url}/tree/{ref_name})`] by {sender_name}**"""
    
    elif event_type == 'tag':
        message = f"""🔨 **[[{repo_name}]({repo_url})] New tag created: [{ref_name}]({repo_url}/releases/tag/{ref_name}) by {sender_name}**"""
    
    else:
        # На всякий случай, если будет другой тип
        message = f"""📌 **Создан новый объект**

📁 Репозиторий: [{repo_name}]({repo_url})
📌 Тип: `{event_type}`
🔖 Имя: `{ref_name}`
👤 Автор: [{sender_name}]({sender_url})"""
    
    result = send_telegram_message(message)
    print("Message sent:", result)

if __name__ == '__main__':
    main()
