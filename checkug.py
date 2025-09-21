import subprocess
import sys

required_packages = ["requests", "colorama"]

for package in required_packages:
    try:
        __import__(package)
    except ImportError:
        print(f"{package} chưa được cài, đang cài đặt...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", package])


import requests
from colorama import init, Fore

init(autoreset=True)

url = "https://dashboard.kingdev.sbs/tool_ug.php?status"

try:
    response = requests.get(url)
    response.raise_for_status()
except Exception as e:
    print(Fore.RED + f"Lỗi khi kết nối: {e}")
    sys.exit()

data = response.json()
servers = data.get("servers", {})
last_updated = data.get("last_updated", {})
# Lọc server còn hàng
available = {srv: stt for srv, stt in servers.items() if stt != "Out of Stock"}

if available:
    print(Fore.GREEN + "Server còn hàng:")
    for server, status in available.items():
        print(Fore.GREEN + f"  {server}: {status}")
else:
    print(Fore.RED + "Tất cả server đã Out of Stock")

print(Fore.BLUE + f"Cập Nhật Mới Nhất: {last_updated}" )
