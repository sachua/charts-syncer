FROM ubuntu:latest

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/helm-sync-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/helm-sync-cron

# Add charts-syncer
ADD charts-syncer_0.11.0_linux_x86_64.tar.gz /
RUN chmod +x /charts-syncer

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Install cron
RUN apt-get update
RUN apt-get -y install cron

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log