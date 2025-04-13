#!/usr/bin/env python3
import requests

ip = requests.get("https://api.ipify.org").text
print(f'{{"ip": "{ip}"}}')
