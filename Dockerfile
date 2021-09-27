FROM python:3
COPY ./web .
CMD ["python", "-m", "http.server", "45029"]
