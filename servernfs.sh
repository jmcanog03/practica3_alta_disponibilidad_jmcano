echo "actualizar los repositorios"
sudo apt -y update
sudo apt -y upgrade

echo "Instalar el servidor nfs"
sudo apt install -y nfs-kernel-server

echo "Instalar el motor php fpm"

sudo apt install -y php-fpm

sudo apt install -y php-mysql
