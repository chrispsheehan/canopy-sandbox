FROM mcr.microsoft.com/dotnet/core/sdk:2.1

COPY ./src ./src

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install xvfb unzip google-chrome-stable -y && \
    apt-get clean && \
    wget https://chromedriver.storage.googleapis.com/2.29/chromedriver_linux64.zip && \
    unzip -d /usr/local/bin chromedriver_linux64.zip && \
    rm chromedriver_linux64.zip

RUN dotnet build /src
WORKDIR /src/bin/Debug/netcoreapp2.1
CMD dotnet CanopySandbox.dll
