FROM cirrusci/flutter:2.5.1 AS build
COPY . ./
RUN flutter pub get
RUN flutter build web

FROM python:3 AS production
COPY --from=build ./build/web .
CMD ["python", "-m", "http.server", "45029"]
