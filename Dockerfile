FROM python:3.10

LABEL maintainer "Tobias Verbeke <tobias.verbeke@openanalytics.eu>"

RUN pip3 install shiny matplotlib numpy gunicorn

ENV USER foo
ENV UID 1000
ENV GROUP foo
ENV GID 1000
ENV HOME /home/$USER
RUN addgroup -g $GID -S $GROUP && adduser -u $UID -S $USER -G $GROUP

# Copy your code
COPY --chown=$UID:$GID ./ $HOME/

# Application working directory
WORKDIR $HOME

EXPOSE 8080

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8080", "-k", "uvicorn.workers.UvicornWorker"]
