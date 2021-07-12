FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y cron

COPY task.sh /usr/local/bin/task.sh
COPY cron-example /etc/cron.d/cron-example

RUN chmod 0644 /etc/cron.d/cron-example
RUN chmod 0755 /usr/local/bin/task.sh

CMD ["cron", "-f"]
