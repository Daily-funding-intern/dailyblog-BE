FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libmariadb-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*


COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

COPY wait-for-it.sh .
RUN chmod +x wait-for-it.sh

EXPOSE 8000

CMD ["./wait-for-it.sh", "daily_blog_db:3306", "--", "python", "manage.py", "runserver", "0.0.0.0:8000"]

