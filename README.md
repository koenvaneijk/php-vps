# 🚀 PHP Hosting with Automatic HTTPS

This template and script provides a straightforward solution for PHP hosting with automatic HTTPS. Key features include:

1. ⚡ Quick Setup: Rapidly deploy a PHP environment with a single script `ship.sh`.
2. 🔒 Automatic HTTPS: Secure sites using Caddy and Cloudflare DNS.
3. 🐳 Docker-Based: Utilize containerization for flexibility.
4. 🛠️ Simplified Configuration: Automatic HTTPS reduces manual certificate management.
5. 🐘 PHP-FPM: Optimize PHP processing.
6. 🔄 Easy Maintenance: Update components via Docker images.
7. 🌐 Multi-Domain Support: Host multiple PHP sites with wildcard SSL.

This setup allows developers to focus more on coding and less on server management. 💻

For individual developers and small teams, this solution offers an accessible way to host PHP applications. 🏠 Using a basic VPS, you can set up and host PHP apps without dealing with complex server configurations or costly hosting plans. This approach simplifies web hosting, making it easier to deploy and test ideas quickly and cost-effectively.

## Features

- 🚀 Caddy web server with automatic SSL via Cloudflare DNS
- 🐘 PHP 8.3 with common extensions
- 🐳 Docker-based setup for easy deployment and scaling
- 🔒 Wildcard SSL support
- 📊 Efficient logging configuration

## Prerequisites

- A system running Ubuntu (or another supported Linux distribution)
- A Cloudflare account with an API token for DNS verification

## Quick Start

We've provided a convenient setup script `ship.sh` to quickly get you started. This script will:

1. Guide you through creating a Cloudflare API token
2. Provide instructions for setting up DNS records
3. Install Docker if it's not already installed
4. Set up the necessary environment variables
5. Start the Docker containers

To use the script:

1. Clone this repository:
   ```bash
   git clone https://github.com/koenvaneijk/php-vps
   cd php-vps
   ```

2. Make the script executable:
   ```bash
   chmod +x ship.sh
   ```

3. Run the script:
   ```bash
   ./ship.sh
   ```

4. Follow the on-screen instructions to complete the setup.

## Manual Setup

If you prefer to set things up manually, follow these steps:

1. Ensure Docker and Docker Compose are installed on your system.

2. Clone this repository:
   ```bash
   git clone https://github.com/koenvaneijk/php-vps
   cd php-vps
   ```

3. Create a `.env` file in the root directory and add your Cloudflare API token:
   ```
   CLOUDFLARE_API_TOKEN=your_cloudflare_api_token_here
   DOMAINS=example.com,example.net
   ```

4. Modify the `Caddyfile` to include your domain(s):
   ```
   example.com {
       root * /srv/example.com/public
       php_fastcgi php-fpm:9000
       file_server
   }
   ```

5. Place your PHP files in the `sites` directory. The structure should be:
   ```
   sites/
   ├── example.com/
   │   └── public/
   │       └── index.php
   └── example.net/
       └── public/
           └── index.php
   ```

6. Start the containers:
   ```bash
   docker compose up -d
   ```

## Usage

To add a new site:
- Create a new directory in the `sites` folder with your domain name
- Add your PHP files to the `public` subdirectory inside that folder

To add a new domain:
- Edit the .env and add the domain
- Restart Caddy with `docker restart caddy`

## Misc: add Aider to `.bashrc`
```
export OPENAI_API_KEY=your_openai_api_key_here
export ANTHROPIC_API_KEY=your_anthropic_api_key_here

aider() {
    docker run -it --rm \
        --user $(id -u):$(id -g) \
        --volume "$(pwd)":/app \
        --env OPENAI_API_KEY \
        --env ANTHROPIC_API_KEY \
        paulgauthier/aider "$@"
}
```

## AI dev workflow for a new app
- Create folder in `sites` with the domain name (e.g. `subdomain.example.com`)
- `cp instructions.txt ./sites/subdomain.example.com`
- `cd ./sites/subdomain.example.com`
- `aider`
- `/add instructions.txt`
- Prompt away!

Optionally you can work in e.g. subdomain-dev.example.com and to deploy to 'production' just copy the folder to the production domain.

## License

This project is open source and available under the MIT License.

```
MIT License

Copyright (c) 2024 Koen van Eijk

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```



