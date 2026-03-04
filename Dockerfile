FROM python:3.13.2-slim

LABEL maintainer="Gentlesprite"
LABEL description="Telegram Restricted Media Downloader - A Telegram media downloader"

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 复制项目文件
COPY module/ ./module/
COPY main.py .
COPY requirements.txt .

# 创建必要的目录
RUN mkdir -p /app/sessions \
    /app/temp \
    /app/output \
    /app/downloads

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 设置环境变量
ENV PYTHONUNBUFFERED=1
ENV TRMD_SESSION_DIR=/app/sessions
ENV TRMD_TEMP_DIR=/app/temp
ENV TRMD_OUTPUT_DIR=/app/output
ENV TRMD_DOWNLOAD_DIR=/app/downloads

# 暴露 Web 端口（如果使用 Web 模式）
# EXPOSE 8080

# 运行程序
CMD ["python", "main.py"]
