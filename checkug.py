import requests

url = "https://dashboard.kingdev.sbs/tool_ug.php?status"

response = requests.get(url)

if response.status_code == 200:
    data = response.json()
    servers = data["servers"]

    # Lọc server còn hàng
    available = {srv: stt for srv, stt in servers.items() if stt != "Out of Stock"}

    if available:
        print("Server còn hàng:")
        for server, status in available.items():
            print(f"  {server}: {status}")
    else:
        print("Tất cả server đã Out of Stock")
else:
    print("Lỗi:", response.status_code)
