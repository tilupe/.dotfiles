import os
from typing import Optional
import requests
import json
from bs4 import BeautifulSoup as bs
import subprocess
import getpass


def get_latest_dotnet_version() -> Optional[str]:
    dotnet_release_index_path = "https://raw.githubusercontent.com/dotnet/core/main/release-notes/releases-index.json"
    response = requests.get(dotnet_release_index_path)
    if response.status_code != 200:
        print("Failed to download from " + dotnet_release_index_path)
        return None
    content = response.text
    release_index = json.loads(content)
    for release in release_index["releases-index"]:
        if release["support-phase"] == "active":
            return release["channel-version"]
    print("content was wrong:\n" + content)
    return None


def get_latest_dotnet_sdk_download_link() -> Optional[str]:
    latest_version = get_latest_dotnet_version()
    if latest_version is None:
        return None
    baseurl = "https://dotnet.microsoft.com"
    downloads_url = baseurl + "/en-us/download/dotnet/" + latest_version
    response = requests.get(downloads_url)
    if response.status_code != 200:
        print("Failed to download from " + downloads_url)
        return None
    soup = bs(response.content, "html.parser")
    table = soup.find("table")
    linux_th = table.find("th", string="Linux")
    linux_tr = linux_th.parent
    a_tag = linux_tr.find("a", string="x64")
    href_content = a_tag["href"]
    return baseurl + href_content


def dowload_latest_dotnet_sdk() -> str:
    url = get_latest_dotnet_sdk_download_link()
    save_path = "/tmp"
    response = requests.get(url)
    response.raise_for_status()
    file_name = os.path.basename(url)
    save_file_path = os.path.join(save_path, file_name)
    with open(save_file_path, "wb") as file:
        file.write(response.content)
    print("File '{}' downloaded successfully.".format(file_name))
    return save_path + "/" + file_name


def create_dotnet_directory(sudo_password: str, install_dir: str):
    command = ["sudo", "-S", "mkdir", "-p", install_dir]
    subprocess.run(command, input=sudo_password.encode("utf-8"))


def unpack_binary(sudo_password: str, install_dir: str, file_path: str):
    # Todo what if direcotry exists already
    command = [
        "sudo",
        "-S",
        "tar",
        "xzvf",
        file_path,
        "-C",
        install_dir,
    ]
    subprocess.run(command, input=sudo_password.encode("utf-8"))


def create_soft_link_for_dotnet_command(sudo_password: str, install_dir: str):
    # Todo check if file exists already
    command = [
        "sudo",
        "-S",
        "ln",
        "-s",
        install_dir + "/dotnet",
        "/usr/local/bin/dotnet",
    ]
    subprocess.run(command, input=sudo_password.encode("utf-8"))


def delete_file(sudo_password: str, file_path: str):
    command = ["sudo", "-S", "rm", file_path]
    subprocess.run(command, input=sudo_password.encode("utf-8"))


def install_latest_dotnet_sdk():
    file_path = dowload_latest_dotnet_sdk()
    sudo_password = getpass.getpass("Enter your sudo password: ")
    install_dir = "/opt/dotnet"

    create_dotnet_directory(sudo_password, install_dir)
    unpack_binary(sudo_password, install_dir, file_path)
    create_soft_link_for_dotnet_command(sudo_password, install_dir)
    delete_file(sudo_password, file_path)


# Todo check if dotnet is already installed
install_latest_dotnet_sdk()
