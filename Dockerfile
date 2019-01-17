FROM openjdk:8

ENV SONAR_SCANNER_VERSION 3.3.0.1492-linux

RUN apt-get update
RUN apt-get install unzip -y

RUN curl -sLO https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip
RUN unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}
RUN ls /
RUN chmod +x /sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner
RUN cd /usr/bin && ln -s /${SONAR_SCANNER_VERSION}/bin/sonar-scanner sonar-scanner

# Install nodeJS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Install typescript
RUN npm install -g typescript

ENV NODE_PATH "/usr/lib/node_modules/"

CMD sonar-scanner -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.projectKey=$SONAR_PROJECT_KEY -Dsonar.projectName=$SONAR_PROJECT_NAME -Dsonar.projectVersion=$SONAR_PROJECT_VERSION -Dsonar.sources=/usr/src/