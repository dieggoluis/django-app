FROM python:3.6.9-alpine

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements/common.txt .
RUN pip install --no-cache-dir -r common.txt

# copy project
COPY web/ .

# migrade db
RUN python manage.py migrate

# expose port 8000
EXPOSE 8000

CMD ["gunicorn", "web.wsgi:application", "--bind", "0.0.0.0:8000"]
