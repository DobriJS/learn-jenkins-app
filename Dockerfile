FROM mcr.microsoft.com/playwright:v1.39.0-jammy
RUN npm install -g netlify-cli@21.5.0 serve
RUN apt update && apt install jq -y