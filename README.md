# 🚀 PHP Hosting with Automatic HTTPS

This template provides a straightforward solution for PHP hosting with automatic HTTPS. Key features include:

1. ⚡ Quick Setup: Rapidly deploy a PHP environment.
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

### Installing Docker and Docker Compose

If you don't have Docker and Docker Compose installed, you can easily set them up on Ubuntu using the following steps:

1. Update your existing list of packages:
   ```bash
   sudo apt update
   ```

2. Install a few prerequisite packages which let apt use packages over HTTPS:
   ```bash
   sudo apt install apt-transport-https ca-certificates curl software-properties-common
   ```

3. Download and run the official Docker installation script:
   ```bash
   curl -fsSL https://get.docker.com -o get-docker.sh
   sudo sh get-docker.sh
   ```

4. Add your user to the docker group to run Docker commands without sudo:
   ```bash
   sudo usermod -aG docker $USER
   ```

7. Log out and log back in for the group changes to take effect.

## Setup

1. Clone this repository to your local machine or VPS:
   ```bash
   git clone https://github.com/koenvaneijk/php-vps
   cd php-vps
   ```

2. Create a `.env` file in the root directory and add your Cloudflare API token:
   ```
   CLOUDFLARE_API_TOKEN=your_cloudflare_api_token_here
   ```

3. Modify the `Caddyfile` to include your domain(s):
   ```
   example.com {
       root * /srv/example.com/public
       php_fastcgi php-fpm:9000
       file_server
   }
   ```

4. Place your PHP files in the `sites` directory. The structure should be:
   ```
   sites/
   ├── example.com/
   │   └── public/
   │       └── index.php
   └── example.net/
       └── public/
           └── index.php
   ```

5. If needed, customize the PHP extensions in `php/Dockerfile`.

## Usage

1. Start the containers:
   ```bash
   docker compose up -d
   ```

3. To add a new site:
   - Create a new directory in the `sites` folder with your domain name (or including subdomain e.g. subdomain.example.com or example.com)
   - Add your PHP files to the `public` subdirectory inside that folder

4. To add a new domain:
    - Edit the Caddyfile and add the domain
    - Restart caddy with `docker restart caddy`

2. Your PHP applications should now be accessible at their respective domains.

## Updates and Maintenance

### Updating Docker Containers

To update your Docker containers with the latest images and configurations:

1. Pull the latest changes from the repository:
   ```bash
   git pull origin main
   ```

2. Rebuild and restart the containers:
   ```bash
   docker compose down
   docker compose build --no-cache
   docker compose up -d
   ```

This process will ensure you have the latest versions of Caddy, PHP, and any other dependencies defined in the Dockerfiles.

### Installing System Updates

To keep the host system updated:

1. Update the package list:
   ```bash
   sudo apt update
   ```

2. Upgrade installed packages:
   ```bash
   sudo apt upgrade -y
   ```

3. Remove unnecessary packages:
   ```bash
   sudo apt autoremove -y
   ```

4. Reboot the system if required (e.g., after kernel updates):
   ```bash
   sudo reboot
   ```

### Updating PHP Version

To update the PHP version:

1. Modify the `php/Dockerfile` to use the desired PHP version.
2. Rebuild the PHP container:
   ```bash
   docker compose build --no-cache php-fpm
   docker compose up -d php-fpm
   ```

Remember to test your applications thoroughly after updating PHP, as newer versions may introduce breaking changes.

### Backup Before Updating

It's always a good practice to backup your data before performing updates:

1. Backup your sites directory:
   ```bash
   tar -czvf sites_backup.tar.gz sites
   ```

2. Backup your Docker volumes:
   ```bash
   docker run --rm -v php-vps_caddy_data:/data -v $(pwd):/backup alpine tar -czvf /backup/caddy_data_backup.tar.gz /data
   docker run --rm -v php-vps_caddy_config:/config -v $(pwd):/backup alpine tar -czvf /backup/caddy_config_backup.tar.gz /config
   ```

By following these update and maintenance procedures, you can ensure your PHP hosting environment remains secure, up-to-date, and running smoothly!

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
