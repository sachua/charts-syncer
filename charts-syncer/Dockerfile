FROM bitnami/minideb:buster as build
RUN install_packages ca-certificates
RUN mkdir /workdir


FROM ubuntu:latest
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Add charts-syncer
ADD charts-syncer_0.15.0_linux_x86_64.tar.gz /bin/
RUN chmod +x /bin/charts-syncer
# Install cron
RUN apt-get update && apt-get -y install cron
# Add crontab file in the cron directory
ADD crontab /etc/cron.d/helm-sync-cron
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/helm-sync-cron &&\
    crontab /etc/cron.d/helm-sync-cron
# Create the log file to be able to run tail
RUN touch /var/log/cron.log
# Run the command on container startup
CMD cron && tail -f /var/log/cron.log