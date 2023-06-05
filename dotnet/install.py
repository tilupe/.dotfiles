import os
from typing import Optional
import requests
import json
from bs4 import BeautifulSoup as bs
from packaging import version
import subprocess
import getpass
import shutil
import urllib.request


def is_dotnet_installation_necessary() -> bool:
    if shutil.which("dotnet") is None:
        return True
    latest_release_version = get_latest_dotnet("latest-release")
    output = subprocess.check_output(["dotnet", "--list-sdks"], universal_newlines=True)
    lines = output.strip().split("\n")
    latest_installed_version = lines[0].split()[0]
    if version.parse(latest_installed_version) >= version.parse(latest_release_version):
        print(
            "dotnet skd version is already up to date with version {}".format(
                latest_installed_version
            )
        )
        return False
    return True


def get_latest_dotnet(field_name: str) -> str:
    dotnet_release_index_path = "https://raw.githubusercontent.com/dotnet/core/main/release-notes/releases-index.json"
    try:
        response = requests.get(dotnet_release_index_path)
    except Exception as error:
        raise error
    if response.status_code != 200:
        raise Exception(
            "Failed to download from "
            + dotnet_release_index_path
            + " \n status code was: "
            + response.status_code
        )

    content = response.text
    release_index = json.loads(content)

    for release in release_index["releases-index"]:
        if release["support-phase"] == "active":
            return release[field_name]
    raise Exception("No release found in json: " + response.text)


def get_latest_dotnet_sdk_download_link() -> Optional[str]:
    latest_version = get_latest_dotnet("channel-version")
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
    url = baseurl + href_content
    response = requests.get(url)
    if response.status_code != 200:
        print("Failed to download from " + downloads_url)
        return None
    soup = bs(response.content, "html.parser")
    div = soup.find("div", class_="swim-container")
    direct_link_div = div.find("div", class_="direct-link")
    a_tag_two = direct_link_div.find("a", id="directLink")
    href_content = a_tag_two["href"]
    return href_content


def dowload_latest_dotnet_sdk(save_path: str) -> str:
    url = get_latest_dotnet_sdk_download_link()
    file_name = os.path.basename(url)
    print("Downloading from {}".format(url))
    command = [
        "wget",
        "-O",
        save_path,
        url,
    ]
    subprocess.run(command)
    print("File '{}' downloaded successfully.".format(file_name))
    return save_path + file_name


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
    symbolic_link = "/usr/local/bin/dotnet"
    if os.path.exists(symbolic_link):
        return
    # Todo check if file exists already
    command = [
        "sudo",
        "-S",
        "ln",
        "-s",
        install_dir,
        symbolic_link,
    ]
    subprocess.run(command, input=sudo_password.encode("utf-8"))


def delete_file(sudo_password: str, file_path: str):
    command = ["sudo", "-S", "rm", file_path]
    subprocess.run(command, input=sudo_password.encode("utf-8"))


def install_latest_dotnet_sdk():
    # if not is_dotnet_installation_necessary():
    # return
    file_path = dowload_latest_dotnet_sdk("~/tmp")
    sudo_password = getpass.getpass("Enter your sudo password: ")
    install_dir = "/opt/dotnet"

    create_dotnet_directory(sudo_password, install_dir)
    unpack_binary(sudo_password, file_path, install_dir)
    create_soft_link_for_dotnet_command(sudo_password, install_dir)
    delete_file(sudo_password, file_path)


# Todo check if dotnet is already installed
install_latest_dotnet_sdk()
