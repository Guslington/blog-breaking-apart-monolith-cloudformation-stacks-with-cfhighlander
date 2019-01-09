FROM python:3

COPY docker-entrypoint.sh /

RUN mkdir /app

WORKDIR /app

ADD requirements.txt /app/

RUN pip install -r requirements.txt

ADD src/ /app/

EXPOSE 8000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "python3", "manage.py", "runserver", "0:8000" ]
