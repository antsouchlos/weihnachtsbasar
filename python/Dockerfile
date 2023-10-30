FROM ubuntu:20.04

RUN apt-get update && apt-get install -y python3 python3-pip && apt-get upgrade -y && rm -rf /var/cache/apt

COPY . /usr/local/bin/app
WORKDIR /usr/local/bin/app

RUN pip install -r requirements.txt

CMD ["python3", "-m", "wbdb"]
